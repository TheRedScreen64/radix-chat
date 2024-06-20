#include "../null.h"
#include "../debug.h"
#include "../Vector.h"
#include "../String/String.h"

#include "NMap.h"

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <unistd.h>
#include <stdlib.h>

#include <sys/shm.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/types.h>

#define __NMAP_DEFAULT_INITBUFFERSIZE sizeof(struct _nmap)

/* these values assume an mmap and shm page size of 4096 */
#define __NMAP_DB_CAP 0x10000000000ULL        /* size cap (in bytes) per database shouldn't be larger than 128T to fit inside address space boundaries of linux  */
                                              /* needs to be significantly larger than 2¹⁶ to prevent conflicts when generating the file descriptor */
#define __NMAP_DB_ENTRYPOINT 0xC0000000000ULL /* entry point for address space that is used for shared mappings */

#define __NMAP_DIR /*HOME_DIR*/ "/.nmdb"
#define __NMAP_INF /*__NMAP_DIR*/ "/inf.dat"
#define __NMAP_DBDIR /*__NMAP_DIR*/ "/db"
#define __NMAP_FD_BOUND 600

#ifndef __USE_XOPEN2K8 /* for use of pread/pwrite functions in vscode */
#define __USE_XOPEN2K8
#endif

struct _nmap
{
    int dbfd;
    _nmap_size dbsize;
    _nmap_size dbcapacity;
    struct _freelink *dbfreelist;
    void *dbdir;
    void *map_addr; /* allthough mmap spaces arent shared they shouldn't overlap */
    char *name;
};

typedef _nmap_size _nmap_head; /* header to store size */

typedef struct _freelink Freelist;

struct _freelink
{
    _nmap_size size;
    void *buff;

    struct _freelink *next;
};

#define flst_empty(fli) fli == null

#define flst_buff(fli) fli->buff

#define flst_size(fli) fli->size

#define flst_push(fli, _size, _buff, map)                                      \
    fli->next = (struct _freelink *)nmap_alloc(map, sizeof(struct _freelink)); \
    fli->next->size = _size;                                                   \
    fli->next->buff = _buff;

#define flst_pop(fli) fli = fli->next;

#define _nmap_usableSize(addr) (*(((_nmap_head *)addr) - 1) - sizeof(_nmap_head)) /* substract header size */

struct _nmap *nmap_openStorage(const char *name)
{
    assert_non_null(name);

    char *t = getenv("HOME");
    if (t == null)
    {
        printf("nmap_openStorage getenv: HOME env not set\n");
        _Exit(1);
    }
    xstrcreateft(str, t);

    /* default nmap storage directory */
    xstrappends(&str, __NMAP_DIR);
    mkdir(xstrserialize(str), S_IRUSR | S_IWUSR);

    /* database directory */
    xstrappends(&str, __NMAP_DBDIR);
    mkdir(xstrserialize(str), S_IRUSR | S_IWUSR);

    xstrappendc(&str, '/');
    xstrappends(&str, (char *)name); /* database name */
    xstrappends(&str, ".ndb");

    xstrcreateft(sharedmem, (char *)name);
    xstrappends(&sharedmem, "_ndb");

    /* open shared db memory */
    int db_shm = shm_open(xstrserialize(sharedmem), O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
    free(sharedmem._str);
    if (db_shm == -1)
    {
        perror("nmap_openStorage shm_open");
        _Exit(1);
    }
    lseek(db_shm, SEEK_SET, sizeof(struct _nmap));
    write(db_shm, t, 1); /* write dummy byte, variable wouldn't matter */

    /* attach shared db memory */
    struct _nmap *map;
    if ((map = (struct _nmap *)mmap(null, sizeof(struct _nmap), PROT_READ | PROT_WRITE, MAP_SHARED, db_shm, 0)) == MAP_FAILED)
    {
        perror("nmap_openStorage mmap 1");
        _Exit(1);
    }

    /* load database file */
    int dbfd;
    if ((dbfd = open(xstrserialize(str) /* string was already serialized above */, O_RDWR, S_IRUSR | S_IWUSR)) == -1)
    {
        /* database constructor - start */
        if ((dbfd = open(str._str, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR)) == -1)
        {
            perror("nmap_openStorage open 1");
            _Exit(1);
        }

        /* collect address info */
        int name_len = strlen(name);
        str._size -= name_len + 4 + sizeof(__NMAP_DBDIR) /* .ndb */; /* restore old string length to access info file */
        /* collect map addresses from info directory */
        xstrappends(&str, __NMAP_INF);
        int info;
        if (((info = open(xstrserialize(str), O_RDWR | O_CREAT, S_IRUSR | S_IWUSR))) == -1)
        {
            perror("nmap_openStorage open 2");
            _Exit(1);
        }
        free(str._str);
        read(info, &map->map_addr, sizeof(void *));

        map->map_addr += __NMAP_DB_CAP;

        map->dbfd = (int)__NMAP_FD_BOUND + (((unsigned long long)map->map_addr) / __NMAP_DB_CAP); /* creates a unique fd if __NMAP_DB_CAP is significantly larger than 2¹⁶ */
        lseek(info, 0, SEEK_SET);                                                      /* needed because open for some reason doesn't open the file with offset set to 0 */
        write(info, &map->map_addr, sizeof(void *));
        close(info);

        lseek(dbfd, __NMAP_DEFAULT_INITBUFFERSIZE, SEEK_CUR);
        write(dbfd, &(char){0}, 1); /* write dummy byte to complete truncate operation */

        map->dbcapacity = __NMAP_DEFAULT_INITBUFFERSIZE;
        map->dbsize = sizeof(struct _nmap);

        /* load mmap */
        if (mmap(map->map_addr, map->dbcapacity, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED_NOREPLACE, dbfd, 0) != map->map_addr)
        {
            printf("nmap_openStorage database limit reached\n");
            _Exit(1);
        }
        if (dup2(dbfd, map->dbfd) == -1) /* should work in most cases to produce an unique descriptor by shifting the map address 16 bytes and casting it to int */
        {
            perror("nmap_openStorage dup2");
            printf("Terminal file descriptor boundary exceeded. Try increasing or decreasing the __NMAP_FD_BOUND constant.\n");
            _Exit(1);
        }

        /* write database name to map */
        map->name = (char *)nmap_qalloc(map, name_len * sizeof(char));
        memcpy(map->name, name, name_len);
        map->dbdir = map->map_addr + map->dbsize;
        return (void *)map;
        /* database constructor - end */
    }
    free(str._str);
    read(dbfd, map, sizeof(struct _nmap)); /* collect database object */
    /* load mmap */
    // printf("map->map_addr: %llu, map->dbcapacity: %llu, dbfd: %d, map->dbsize: %llu\n", map->map_addr, map->dbcapacity, dbfd, map->dbsize);
    if (mmap(map->map_addr, map->dbcapacity, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED_NOREPLACE, dbfd, 0) == MAP_FAILED)
    {
        perror("nmap_openStorage mmap 2");
        _Exit(1);
    }

    if (dup2(dbfd, map->dbfd) == -1) /* should work in most cases to produce an unique descriptor by shifting the map address 16 bytes and casting it to int */
    {
        perror("nmap_openStorage dup2");
        printf("Terminal file descriptor boundary exceeded. Try increasing or decreasing the __NMAP_FD_BOUND constant.\n");
        _Exit(1);
    }

    return (void *)map;
}

NMap *nmap_openStorageOnDevice(const char *name, const char *deviceId)
{
    assert_non_null(name);
    assert_non_null(deviceId);

    xstrcreateft(sharedmem, (char *)name);
    xstrappends(&sharedmem, "_ndb");

    /* open shared db memory */
    int db_shm = shm_open(xstrserialize(sharedmem), O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
    free(sharedmem._str);
    if (db_shm == -1)
    {
        perror("nmap_openStorage shm_open");
        _Exit(1);
    }
    lseek(db_shm, SEEK_SET, sizeof(struct _nmap));
    write(db_shm, &db_shm, 1); /* dummy byte */

    /* attach shared db memory */
    struct _nmap *map;
    if ((map = (struct _nmap *)mmap(null, sizeof(struct _nmap), PROT_READ | PROT_WRITE, MAP_SHARED, db_shm, 0)) == MAP_FAILED)
    {
        perror("nmap_openStorage mmap 1");
        _Exit(1);
    }

    /* load database file */
    int dbfd;
    if ((dbfd = open(deviceId, O_RDWR, S_IRUSR | S_IWUSR)) == -1)
    {
        /* database constructor - start */
        if ((dbfd = open(deviceId, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR)) == -1)
        {
            perror("nmap_openStorage open 1");
            _Exit(1);
        }

        /* create info filepath */
        char *t = getenv("HOME");
        if (t == null)
        {
            printf("nmap_openStorage getenv: HOME env not set\n");
            _Exit(1);
        }
        xstrcreateft(str, t);

        /* default nmap storage directory */
        xstrappends(&str, __NMAP_DIR);
        mkdir(xstrserialize(str), S_IRUSR | S_IWUSR);

        /* database directory */
        xstrappends(&str, __NMAP_DBDIR);
        mkdir(xstrserialize(str), S_IRUSR | S_IWUSR);

        xstrappendc(&str, '/');
        xstrappends(&str, __NMAP_INF); /* address info file */
        /* collect address info */
        /* collect map addresses from info directory */
        int info;
        if (((info = open(xstrserialize(str), O_RDWR | O_CREAT, S_IRUSR | S_IWUSR))) == -1)
        {
            perror("nmap_openStorage open 2");
            _Exit(1);
        }
        free(str._str);
        read(info, &map->map_addr, sizeof(void *));

        map->map_addr += __NMAP_DB_CAP;

        map->dbfd = (int)__NMAP_FD_BOUND + (((unsigned long long)map->map_addr) / __NMAP_DB_CAP); /* creates a unique fd if __NMAP_DB_CAP is significantly larger than 2¹⁶ */
        lseek(info, 0, SEEK_SET);                                                      /* needed because open for some reason doesn't open the file with offset set to 0 */
        write(info, &map->map_addr, sizeof(void *));
        close(info);

        lseek(dbfd, __NMAP_DEFAULT_INITBUFFERSIZE, SEEK_CUR);
        write(dbfd, &(char){0}, 1); /* write dummy byte to complete truncate operation */

        map->dbcapacity = __NMAP_DEFAULT_INITBUFFERSIZE;
        map->dbsize = sizeof(struct _nmap);

        /* load mmap */
        if (mmap(map->map_addr, map->dbcapacity, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED_NOREPLACE, dbfd, 0) != map->map_addr)
        {
            printf("nmap_openStorage database limit reached\n");
            _Exit(1);
        }
        if (dup2(dbfd, map->dbfd) == -1) /* should work in most cases to produce an unique descriptor by shifting the map address 16 bytes and casting it to int */
        {
            perror("nmap_openStorage dup2");
            printf("Terminal file descriptor boundary exceeded. Try increasing or decreasing the __NMAP_FD_BOUND constant.\n");
            _Exit(1);
        }

        /* write database name to map */
        register int name_len = strlen(name);
        map->name = (char *)nmap_qalloc(map, name_len * sizeof(char));
        memcpy(map->name, name, name_len);
        map->dbdir = map->map_addr + map->dbsize;
        return (void *)map;
        /* database constructor - end */
    }
    read(dbfd, map, sizeof(struct _nmap)); /* collect database object */
    /* load mmap */
    // printf("map->map_addr: %llu, map->dbcapacity: %llu, dbfd: %d, map->dbsize: %llu\n", map->map_addr, map->dbcapacity, dbfd, map->dbsize);
    if (mmap(map->map_addr, map->dbcapacity, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED_NOREPLACE, dbfd, 0) == MAP_FAILED)
    {
        perror("nmap_openStorage mmap 2");
        _Exit(1);
    }

    if (dup2(dbfd, map->dbfd) == -1) /* should work in most cases to produce an unique descriptor by shifting the map address 16 bytes and casting it to int */
    {
        perror("nmap_openStorage dup2");
        printf("Terminal file descriptor boundary exceeded. Try increasing or decreasing the __NMAP_FD_BOUND constant.\n");
        _Exit(1);
    }

    return (void *)map;
}

void nmap_closeStorage(NMap *map)
{
    assert_non_null(map);

    lseek(map->dbfd, 0, SEEK_SET);
    write(map->dbfd, map, sizeof(NMap));
    close(map->dbfd);

    shm_unlink(map->name);

    munmap(map->map_addr, map->dbcapacity);
    munmap(map, sizeof(NMap));
}

void *nmap_optainDbDir(NMap *map, _nmap_size size)
{
    assert_non_null(map);

    if ((map->map_addr + map->dbsize) == map->dbdir)
        map->dbdir = nmap_qalloc(map, size);

    return map->dbdir;
}

const char *nmap_getDbName(struct _nmap *map)
{
    assert_non_null(map);

    return map->name;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wattributes"

_nmap_size nmap_getPageSize()
{
    return __NMAP_DEFAULT_PAGESIZE;
}

static void nmap_grow(struct _nmap *map)
{
    munmap(map->map_addr, map->dbcapacity);
    lseek(map->dbfd, map->dbcapacity *= 2, SEEK_SET);
    write(map->dbfd, &(char *){0}, 1);
    mmap(map->map_addr, map->dbcapacity, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED_NOREPLACE, map->dbfd, 0);
}

 void *nmap_qalloc(struct _nmap *map, _nmap_size size)
{
    assert_non_null(map);

    size += sizeof(_nmap_head); /* add header size */
    /* round up to multiple of page size */
    size = (size - (size % __NMAP_DEFAULT_PAGESIZE)) + __NMAP_DEFAULT_PAGESIZE;

    register _nmap_head *ret;
    ret = map->map_addr + map->dbsize;
    map->dbsize += size;

    while (map->dbsize > map->dbcapacity)
        nmap_grow(map);

    *ret = size; /* set size header */

    //printf("qalloc size: %lld\n", size);
    //printf("qalloc addr: %lld\n", ret + 1);
    //printf("qalloc size usable: %lld\n", _nmap_usableSize((ret + 1)));

    return ret + 1;
}

void *nmap_alloc(struct _nmap *map, _nmap_size size)
{
    assert_non_null(map);

    size += sizeof(_nmap_head); /* add header size */
    /* round up to multiple of page size */
    size = (size - (size % __NMAP_DEFAULT_PAGESIZE)) + __NMAP_DEFAULT_PAGESIZE;

    register _nmap_head *ret;
    if (map->dbfreelist != null && map->dbfreelist->size >= size)
    {
        // printf("\e[95mALLOCATE FREED\e[0m link: %x, size: %llu -= \e[1m%llu\e[0m = %llu, buff: \e[31m%llu\e[0m += \e[1m%llu\e[0m = %llu, ", map->dbfreelist, map->dbfreelist->size, size, (map->dbfreelist->size) - size, map->dbfreelist->buff, size, (map->dbfreelist->buff) + size);
        ret = (_nmap_head *)map->dbfreelist->buff;
        if (((map->dbfreelist->size -= size) != 0))
        {
            map->dbfreelist->buff += size; /* move buff pointer up */
        }
        else
            map->dbfreelist = map->dbfreelist->next; /* pop freelink */
    }
    else
    {
        ret = map->map_addr + map->dbsize;
        // printf("\e[96mALLOCATE NEW\e[0m dbsize: %llu += \e[1m%llu\e[0m = %llu, ", map->dbsize, size, (map->dbsize)+size);
        map->dbsize += size;

        while (map->dbsize > map->dbcapacity)
            nmap_grow(map);
    }

    *ret = size; /* set size header */

    // printf("ret: \e[31m%llu\e[0m\n", ret + 1);

    return ret + 1;
}

void *nmap_seek(NMap *map, void *addr, _nmap_size size)
{
    assert_non_null(map);
    assert_non_null(addr);

    register _nmap_size oldsize = _nmap_usableSize(addr);

    if (addr == ((map->dbsize + map->map_addr) - oldsize)) /* check if address is on top to increase size */
    {
        size = (size - (size % __NMAP_DEFAULT_PAGESIZE)) + __NMAP_DEFAULT_PAGESIZE;

        map->dbsize += size;

        while (map->dbsize > map->dbcapacity)
            nmap_grow(map);

        *(((_nmap_head *)addr) - 1) += size; /* update header */
        return addr;                         /* addr stays unchanged */
    }

    /* if addr isnt on top move the entire buff */

    size += oldsize;                                  /* add old size */
    register _nmap_head *ret = nmap_alloc(map, size); /* new header alr set in alloc function */

    pread(map->dbfd, ret, oldsize, addr - (map->map_addr)); /* copy old data to new buff (i am very proud of this approach since it reads and writes to the data base file/partition with one system call)*/

    nmap_free(map, addr); /* free old buff */

    return ret;
}

tBoolean nmap_isNewest(NMap *map, void *addr)
{
    return (addr == ((map->dbsize + map->map_addr) - _nmap_usableSize(addr)));
}

void *nmap_realloc(NMap *map, void *addr, _nmap_size size)
{
    assert_non_null(map);
    assert_non_null(addr);

    register _nmap_head *ret = nmap_alloc(map, size);
    memcpy(ret, addr, _nmap_usableSize(addr));
    nmap_free(map, addr); /* free old buff */
    return ret;
}

_nmap_size nmap_usableSize(void *addr)
{
    assert_non_null(addr);

    return _nmap_usableSize(addr);
}
#pragma GCC diagnostic pop

void nmap_free(NMap *map, void *addr)
{
    assert_non_null(map);
    assert_non_null(addr);

    register struct _freelink *link = (struct _freelink *)nmap_alloc(map, sizeof(struct _freelink));
    link->next = map->dbfreelist;
    link->buff = (((_nmap_head *)addr) - 1); /* remove header */
    link->size = *(((_nmap_head *)addr) - 1);
    // printf("\e[92mCREATE LINK\e[0m link: %x, link size: %llu, link buff: \e[31m%llu\e[0m\n", link, link->size, link->buff);
    map->dbfreelist = link;
}

#undef _nmap_usableSize