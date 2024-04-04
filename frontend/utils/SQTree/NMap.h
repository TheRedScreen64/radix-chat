/// @author Noah Nagel

#ifndef NMAP_H
#define NMAP_H
#ifdef __cplusplus
extern "C"
{
#endif

#include "../boolean.h"

#define __NMAP_DEFAULT_PAGESIZE (sizeof(void *) * 3) /* this needs to be in an between of not to small to make the free list \
                                         insufficient to not too large for slowing down cache speeds (24 is a good in between), it should also be 64 bit aligned */

    typedef unsigned long long _nmap_size;
    typedef struct _nmap NMap;

    /**
     * @brief attaches storage to current proccess
     * @param name of storage
     * @return the storage attached corresponding to <name>
     */
    extern NMap *nmap_openStorage(const char *name);

    /**
     * @brief attaches storage on a custom device e.g. a file/partition/disk
     * @param name of storage, changing it after creation will result in undefined behavior
     * @param device
     * @return the storage attached on <device> corresponding to <name>
     */
    extern NMap *nmap_openStorageOnDevice(const char *name, const char *device);

    /**
     * @param map storage that should be detached from current proccess
     */
    extern void nmap_closeStorage(NMap *map);

    /**
     * @return current page size property for nmap build
     */
    extern _nmap_size nmap_getPageSize();

    /**
     * @brief returns the address of the database directory, a constant memory block that should be optained after firstly opening the database if needed,
     *        it can be used to store information like memory addresses that provide your database structure after reattaching the storage on a new proccess
     * @param map used storage
     * @param size of the database directory size
     * @return the addr of the directory (intitialized to 0 upon first opening)
     */
    extern void *nmap_optainDbDir(NMap *map, _nmap_size size);

    /**
     * @param map used storage
     * @return name corresponding to <map>
     */
    extern const char *nmap_getDbName(struct _nmap *map);

    /**
     * @brief quick allocate
     * @param map used storage
     * @param size that should be allocated
     * @return new memory block of <size> that is initialized to 0
     */
    extern void *nmap_qalloc(struct _nmap *map, _nmap_size size);

    /**
     * @brief malloc equivalent of nmap allocator
     * @param map used storage
     * @param size that should be allocated
     * @return addr of allocated block
     */
    extern void *nmap_alloc(NMap *map, _nmap_size size);

    /**
     * @brief free equivalent of nmap allocater
     * @param map used storage
     * @param addr that should be marked as freed
     */
    extern void nmap_free(NMap *map, void *addr);

    /**
     * @brief better version of nmap_realloc, better performance due to use of low level systemcalls instead of memcpy
     * @param map used storage
     * @param addr addr of block
     * @param size the block should be grown by
     * @return addr of grown block
     */
    extern void *nmap_seek(NMap *map, void *addr, _nmap_size size);

    /**
     * @brief checks if address is the most recently allocated block on map
     * @param map
     * @param addr
     */
    extern tBoolean nmap_isNewest(NMap *map, void *addr);

    /**
     * @brief realloc equivalent of nmap allocator in most cases nmap_seek offers better performance, just use on very small buffers
     * @param map used storage
     * @param addr addr of old block
     * @param size size of new block
     * @return addr of reallocated block
     */
    extern void *nmap_realloc(NMap *map, void *addr, _nmap_size size);

    /**
     * @param addr of memory block allocated using nmap_alloc, or nmap_seek
     * @return usable size of memory block
     */
    extern _nmap_size nmap_usableSize(void *addr);

#ifdef __cplusplus
}
#endif
#endif