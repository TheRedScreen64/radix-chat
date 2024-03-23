#define CLIENT_DEF

#include "SQTree.h"
#include "NString.h"
#include "../null.h"
#include "../debug.h"

struct _qTree
{
    char *key;
    char *value;
    struct _qNode *ln; /* left node */
    struct _qNode *rn; /* right node */
    int free;

    /* tree footer */
    struct _qNode *branch;
    NMap *map;
};

struct _qNode
{
    char *key;
    char *value;
    struct _qNode *ln; /* left node */
    struct _qNode *rn; /* right node */
    int free;
};

SQTree *sqtr_open(const char *name)
{
    assert_non_null(name);

    /* optain map (file memory allocator) */
    xstrcreateft(_name, (char *)name);
    xstrappends(&_name, "_sqtr");
    NMap *tmap = nmap_openStorage(xstrserialize(_name));
    free(_name._str);

    SQTree *res = (SQTree *)nmap_optainDbDir(tmap, sizeof(SQTree));
    res->free = 1;
    res->map = tmap;
    return res;
}

#define sqtr_createNode(_key, _value) ({                                                                                              \
    /* qalloc since sqtr algorithm doesn't use nmap_free internally there is no need to take the overhead of checking the freelist */ \
    register SQNode *new = (SQNode *)nmap_qalloc(tree->map, sizeof(SQNode));                                                          \
    new->key = _key;                                                                                                                  \
    new->value = _value;                                                                                                              \
    new;                                                                                                                              \
})

void sqtr_set(SQTree *tree, char *key, char *value)
{
    assert_non_null(tree);
    assert_non_null(key);
    assert_str_not_empty(key);

    register SQNode *n = (SQNode *)tree;
insert:
    for (register unsigned int i = 0; key[i] != '\00'; i++)
    {
        /* node is already inserted to tree / free node is on path -> update value */
        if (n->free == 1 || ((n->key[i] == key[i]) && strequals(n->key, key))) /* node is already inserted to tree -> update value */
        {
            if (n->free == 1)
            {
                n->key = nstr_copytomap(key, tree->map);
                n->free = 0;
            }
            n->value = nstr_copytomap(value, tree->map);
            return;
        }

        /* take right branch */
        if ((key[i / 8] >> (i % 8)) & 1) /* qtree algorithm look github/swiftense/qtree for reference */
        {
            if (n->rn != null)
            {
                n = n->rn;
                continue;
            }
            n->rn = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomap(value, tree->map));
            return;
        }

        /* take left branch */
        if (n->ln != null)
        {
            n = n->ln;
            continue;
        }
        n->ln = sqtr_createNode(
            nstr_copytomap(key, tree->map),
            nstr_copytomap(value, tree->map));
        return;
    }
    goto insert;
}

void sqtr_sets(SQTree *tree, char *key, char *value, int value_size)
{
    assert_non_null(tree);
    assert_non_null(key);
    assert_str_not_empty(key);

    register SQNode *n = (SQNode *)tree;
insert:
    for (register unsigned int i = 0; key[i] != '\00'; i++)
    {
        /* node is already inserted to tree / free node is on path -> update value */
        if (n->free == 1 || ((n->key[i] == key[i]) && strequals(n->key, key))) /* node is already inserted to tree -> update value */
        {
            if (n->free == 1)
            {
                n->key = nstr_copytomap(key, tree->map);
                n->free = 0;
            }
            n->value = nstr_copytomapws(value, value_size, tree->map);
            return;
        }

        /* take right branch */
        if ((key[i / 8] >> (i % 8)) & 1) /* qtree algorithm look github/swiftense/qtree for reference */
        {
            if (n->rn != null)
            {
                n = n->rn;
                continue;
            }
            n->rn = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomapws(value, value_size, tree->map));
            return;
        }

        /* take left branch */
        if (n->ln != null)
        {
            n = n->ln;
            continue;
        }
        n->ln = sqtr_createNode(
            nstr_copytomap(key, tree->map),
            nstr_copytomapws(value, value_size, tree->map));
        return;
    }
    goto insert;
}

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

SQNode *sqtr_optain(SQTree *tree, char *key)
{
    assert_non_null(tree);
    assert_non_null(key);
    assert_str_not_empty(key);

    register SQNode *n = (SQNode *)tree;
    // printf("map start: 0x%lx, map end: 0x%lx\n", ((struct _nmap *)tree->map)->map_addr, ((struct _nmap *)tree->map)->map_addr + ((struct _nmap *)tree->map)->dbsize);
    // printf("true 1\n");
    for (register unsigned int i = 0;; i++)
        // printf("true 1.5\n");
        // printf("n->key: 0x%lx, key: 0x%lx\n", n->key, key);
        if (((n->key[i] == key[i]) && strequals(n->key, key))) /*  node is found -> return  */
            return n;

        /* take right branch */
        else if ((key[i / 8] >> (i % 8)) & 1) /* qtree algorithm look github/swiftense/qtree for reference */
            if ((n = n->rn) != null)
                continue;
            else
                return null;

        /* take left branch */
        else if ((n = n->ln) != null)
            continue;
        else
            return null;
}

void sqtr_foreach(SQNode *branch, void (*itr)(SQNode *node))
{
    assert_non_null(tree);
    assert_non_null(itr);

    if (branch == null)
        return;
    itr(branch);
    sqtr_foreach(branch->rn, itr);
    sqtr_foreach(branch->ln, itr);
}

void sqtr_close(SQTree *tree)
{
    assert_non_null(tree);

    nmap_closeStorage(tree->map);
}

debug int sqtr_longbr(SQTree *tree)
{
    assert_non_null(tree);

    SQNode *n = (SQNode *)tree;
    int i = 0;

    for (; n != null; i++)
    {
        printf("%d\n", i);
        if (sqtr_size(n->rn, 0) > sqtr_size(n->ln, 0))
            n = n->rn;
        else
            n = n->ln;
    }

    return i;
}

debug int sqtr_size(SQNode *branch, int size)
{
    assert_non_null(branch);

    if (branch == null)
        return size;
    size++;
    sqtr_size(branch->rn, size);
    sqtr_size(branch->ln, size);
}

#undef sqtr_createNode