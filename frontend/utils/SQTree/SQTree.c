#include "SQTree.h"
#include "NString.h"
#include "../null.h"
#include "../String/String.h"
#include "../debug.h"

SQTree *sqtr_open(const char *name)
{
    assert_non_null(name);
    assert_str_not_empty(name);

    /* optain map (file memory allocator) */
    xstrcreateft(_name, (char *)name);
    xstrappends(&_name, "_sqtr");
    NMap *tmap = nmap_openStorage(xstrserialize(_name));
    free(_name._str);

    SQTree *res = (SQTree *)nmap_optainDbDir(tmap, sizeof(SQTree));

    if (nmap_isNewest(tmap, res)) /* check if database is newly created */
    {
        res->free = 1;
        res->key = "none";
    }

    res->map = tmap;
    return res;
}

SQTree *sqtr_openOnDevice(const char *name, const char *deviceName)
{
    assert_non_null(name);
    assert_non_null(deviceName);
    assert_str_not_empty(name);
    assert_str_not_empty(deviceName);

    /* optain map (file memory allocator) */
    xstrcreateft(_name, (char *)name);
    xstrappends(&_name, "_sqtr");
    NMap *tmap = nmap_openStorageOnDevice(xstrserialize(_name), deviceName);
    free(_name._str);

    SQTree *res = (SQTree *)nmap_optainDbDir(tmap, sizeof(SQTree));

    if (nmap_isNewest(tmap, res)) /* check if database is newly created */
    {
        res->free = 1;
        res->key = "none";
    }

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

#define doTreeInsert(tree, key, onPresentButFreed, onPresentButNotFreed, onFreeSlotOnRight, onFreeSlowOnLeft)                         \
    assert_non_null(tree);                                                                                                            \
    assert_non_null(key);                                                                                                             \
    assert_str_not_empty(key);                                                                                                        \
                                                                                                                                      \
    register SQNode *n = (SQNode *)tree;                                                                                              \
    insert:                                                                                                                           \
    for (register unsigned int i = 0; key[i / 8] != '\00'; i++)                                                                           \
    {                                                                                                                                 \
        /* node is already inserted to tree / free node is on path -> update value */                                                 \
        if (n->free == 1 || ((n->key[i / 8] == key[i / 8]) && strequals(n->key, key))) /* node is already inserted to tree -> update value */ \
        {                                                                                                                             \
            if (n->free == 1)                                                                                                         \
                onPresentButFreed                                                                                                     \
                    onPresentButNotFreed                                                                                              \
        }                                                                                                                             \
                                                                                                                                      \
        /* take right branch */                                                                                                       \
        if ((key[i / 8] >> (i % 8)) & 1) /* qtree algorithm look github/swiftense/qtree for reference */                              \
        {                                                                                                                             \
            if (n->rn != null)                                                                                                        \
            {                                                                                                                         \
                n = n->rn;                                                                                                            \
                continue;                                                                                                             \
            }                                                                                                                         \
            onFreeSlotOnRight                                                                                                         \
        }                                                                                                                             \
                                                                                                                                      \
        /* take left branch */                                                                                                        \
        if (n->ln != null)                                                                                                            \
        {                                                                                                                             \
            n = n->ln;                                                                                                                \
            continue;                                                                                                                 \
        }                                                                                                                             \
        onFreeSlowOnLeft                                                                                                              \
    }                                                                                                                                 \
    goto insert;

#define doTreeSearch(tree, key, onFound /*<n>*/, onBranchEnd)                                                                  \
    assert_non_null(tree);                                                                                                     \
    assert_non_null(key);                                                                                                      \
    assert_str_not_empty(key);                                                                                                 \
    register SQNode *n = (SQNode *)tree;                                                                                       \
    search:                                                                                                                    \
    for (register unsigned int i = 0; key[i / 8] != '\00'; i++)                                                                    \
        if (((n->key[i / 8] == key[i / 8]) && strequals(n->key, key))) /*  node is found */                                            \
            onFound                                            /* take right branch */                                         \
                else if ((key[i / 8] >> (i % 8)) & 1)          /* qtree algorithm look github/swiftense/qtree for reference */ \
                if ((n = n->rn) != null) continue;                                                                             \
        else                                                                                                                   \
            onBranchEnd /* take left branch */                                                                                 \
                else if ((n = n->ln) != null) continue;                                                                        \
    else onBranchEnd goto search;

void sqtr_set(SQTree *tree, char *key, char *value)
{
    assert_non_null(value);
    doTreeInsert(
        tree, key,
        {
            n->key = nstr_copytomap(key, tree->map);
            n->free = 0;
        },
        {
            n->value = nstr_copytomap(value, tree->map);
            return;
        },
        {
            n->rn = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomap(value, tree->map));
            return;
        },
        {
            n->ln = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomap(value, tree->map));
            return;
        });
}

tBoolean sqtr_insertIfAvailable(SQTree *tree, char *key, char *value)
{
    assert_non_null(value);

    doTreeInsert(
        tree, key,
        {
            n->key = nstr_copytomap(key, tree->map);
            n->value = nstr_copytomap(value, tree->map);
            n->free = 0;
            return tTrue;
        },
        {
            return tFalse;
        },
        {
            n->rn = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomap(value, tree->map));
            return tTrue;
        },
        {
            n->ln = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomap(value, tree->map));
            return tTrue;
        });
}

void sqtr_sets(SQTree *tree, char *key, char *value, int value_size)
{
    assert_non_null(value);

    // printf("Sets key: %s (%lx)\n", key, key);

    doTreeInsert(
        tree, key, {
            n->key = nstr_copytomap(key, tree->map);
            n->free = 0;
            // printf("Sets no insert done...\n");
        },
        {
            n->value = nstr_copytomapws(value, value_size, tree->map);
            return;
        },
        {
            n->rn = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomapws(value, value_size, tree->map));

            // printf("Sets key (after insert): %s (%lx)\n", n->rn->key, n->rn->key);
            return;
        },
        {
            n->ln = sqtr_createNode(
                nstr_copytomap(key, tree->map),
                nstr_copytomapws(value, value_size, tree->map));

            // printf("Sets key (after insert): %s (%lx)\n", n->ln->key, n->ln->key);
            return;
        });
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
    doTreeSearch(tree, key, return n;, return null;);
}

void sqtr_concat(SQTree *tree, char *key, char *c)
{
    doTreeSearch(
        tree, key,
        {
            n->value = nstr_copytomapptr(c, tree->map, n->value);
            return;
        },
        return;);
}

SQNode *sqtr_pop(SQTree *tree, char *key)
{
    doTreeSearch(
        tree, key, {
            n->free = 1; /* mark as freed */
            return n;
        },
        return null;);
}

void sqtr_remove(SQTree *tree, char *key)
{
    doTreeSearch(
        tree, key, {
            n->free = 1; /* mark as freed */
            return;
        },
        return;);
}

tBoolean sqtr_available(SQTree *tree, char *key)
{
    doTreeSearch(tree, key, return tFalse;, return tTrue;);
}

void sqtr_foreach(SQNode *branch, void (*itr)(SQNode *node))
{
    assert_non_null(branch);
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
        // printf("%d\n", i);
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
#undef doTreeSearch