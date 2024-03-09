#include "SQTreeSlowLocal.h"

#include "../String/String.h"
#include "../debug.h"
#include "../null.h"

#include <string.h>

SQLTree *sqtr_local_create()
{
    SQLTree *res = (SQLTree *)malloc(sizeof(SQLTree));
    res->key = "", res->rn = null, res->ln = null, res->free = 1;
    return res;
}

static void _sqtr_local_clonen(SQLNode *node1, SQLNode *node2)
{

    node2->key = node1->key;
    node2->value = node1->value;

    /* dont just copy pointers, allocate new node */
    if (node1->ln != null)
    {
        node2->ln = (SQLNode *)malloc(sizeof(SQLNode)); /* also clonen for childs*/
        _sqtr_local_clonen(node1->ln, node2->ln);
    }
    if (node1->rn != null) /* do same for right child */
    {
        node2->rn = (SQLNode *)malloc(sizeof(SQLNode));
        _sqtr_local_clonen(node1->rn, node2->rn);
    }
}

void sqtr_local_foreach(SQLNode *branch, void (*itr)(SQLNode *node))
{
    assert_non_null(branch);
    assert_non_null(itr);

    if (branch == null)
        return;
    itr(branch);
    sqtr_local_foreach(branch->rn, itr);
    sqtr_local_foreach(branch->ln, itr);
}

SQLTree *sqtr_local_clone(SQLTree *tree)
{
    assert_non_null(tree);

    SQLTree *res = (SQLTree *)malloc(sizeof(SQLTree));
    _sqtr_local_clonen(tree, res);
    return res;
}

static int sqtr_local_keyeqval(char *key1, char *key2)
{
    for (; *key1 != null; key1++, key2++)
        if (*key2 == null)
            return 0;
        else if (*key1 != *key2)
            return 0;
    if (*key2 != null)
        return 0;
    return 1;
}

int sqtr_local_empty(SQLTree *tree)
{
    assert_non_null(tree);

    if (tree->ln == null && tree->rn == null)
        return 1;
    return 0;
}

#define sqtr_createNode(_key, _value) ({                                                                                              \
    /* qalloc since sqtr algorithm doesn't use nmap_free internally there is no need to take the overhead of checking the freelist */ \
    register SQLNode *new = (SQLNode *)malloc(sizeof(SQLNode));                                                                       \
    new->key = _key;                                                                                                                  \
    new->value = _value;                                                                                                              \
    new->rn = null;                                                                                                                   \
    new->ln = null;                                                                                                                   \
    new->free = 0;                                                                                                                    \
    new;                                                                                                                              \
})

void sqtr_local_set(SQLTree *tree, char *key, char *value)
{
    assert_non_null(tree);
    assert_non_null(key);
    assert_str_not_empty(key);

    //printf("Setting %ss\n", key);

    register SQLNode *n = (SQLNode *)tree;
insert:
    for (register unsigned int i = 0; key[i] != '\00'; i++)
    {
        /* node is already inserted to tree / free node is on path -> update value */
        if (n->free == 1 || ((n->key[i] == key[i]) && strequals(n->key, key))) /* node is already inserted to tree -> update value */
        {
            //printf("overriding since %s == %s\n", n->key, key);
            if (n->free == 1)
            {
                n->key = key;
                n->free = 0;
            }
            n->value = value;
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
                key,
                value);
            return;
        }

        /* take left branch */
        if (n->ln != null)
        {
            n = n->ln;
            continue;
        }
        n->ln = sqtr_createNode(
            key,
            value);
        return;
    }
    goto insert;
}

#undef sqtr_createNode

void *sqtr_local_get(SQLTree *tree, char *key)
{
    assert_non_null(tree);
    assert_non_null(key);
    assert_str_not_empty(key);

    register SQLNode *n = (SQLNode *)tree;
// printf("map start: 0x%lx, map end: 0x%lx\n", ((struct _nmap *)tree->map)->map_addr, ((struct _nmap *)tree->map)->map_addr + ((struct _nmap *)tree->map)->dbsize);
// printf("true 1\n");
get:
    for (register unsigned int i = 0; key[i] != '\00'; i++)
    {

        // printf("true 1.5\n");
        if (((n->key[i] == key[i]) && strequals(n->key, key))) /*  node is found -> return  */
            return n->value;

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
    goto get;
}

static inline void _sqtr_local_insertn(SQLNode *start, unsigned int startb, SQLNode *insert)
{
    /* recursively insert subnodes */
    if (insert->rn != null)
    {
        _sqtr_local_insertn(start, startb, insert->rn); /* reinsert right branch of removed node */
        insert->rn = null;
    }
    if (insert->ln != null)
    {
        _sqtr_local_insertn(start, startb, insert->ln);
        insert->ln = null;
    }

    /* right shift bits */
    unsigned char shifting_bits = startb & 8;
    char *key = insert->key + (startb - shifting_bits);
    for (; *key != null; shifting_bits++)
    {
        if (shifting_bits == 8)
        {
            shifting_bits = 0;
            key++; /* increase byte right shift*/
        }
        if (((*key) >> shifting_bits) & 1)
        {
            if (start->rn == null)
            {
                start->rn = insert; /* change right node  */
                return;
            }
            start = start->rn;
            continue;
        }
        if (start->ln == null)
        {
            start->ln = insert; /* change left node  */
            return;
        }
        start = start->ln;
        continue;
    }
}

void sqtr_local_delete(SQLTree *tree, char *key)
{
    assert_non_null(tree);
    assert_non_null(key);
    assert_str_not_empty(key);

    SQLNode *next;
    char *_key = key;
    unsigned char shifting_bits = 0;
    for (; *key != null; shifting_bits++)
    {
        if (shifting_bits == 8)
        {
            shifting_bits = 0;
            key++; /* increase byte right shift*/
        }
        if (((*key) >> shifting_bits) & 1)
        {
            if (tree->rn == null)
            {
                return;
            }
            /* not directly set tree node, to reinsert leafs of node that is beeing removed */
            next = tree->rn;
            if (sqtr_local_keyeqval(next->key, _key) == 1)
            {
                /* set right node to null, to remove old node out of structure */
                tree->rn = null;
                /* reinsert nodes */
                int startb = (_key - key) + shifting_bits;
                if (next->rn != null)
                    _sqtr_local_insertn(tree, startb, next->rn); /* reinsert right branch of removed node */
                if (next->ln != null)
                    _sqtr_local_insertn(tree, startb, next->ln); /* reinsert left branch of removed node */
                return;
            }
            tree = next;
            continue;
        }
        if (tree->ln == null)
        {
            return;
        }
        /* not directly set tree node, to reinsert leafs of node that is beeing removed */
        next = tree->ln;
        if (sqtr_local_keyeqval(next->key, _key) == 1)
        {
            /* set right node to null, to remove old node out of structure */
            tree->ln = null;
            /* reinsert nodes */
            int startb = (_key - key) + shifting_bits;
            if (next->rn != null)
                _sqtr_local_insertn(tree, startb, next->rn); /* reinsert right branch of removed node */
            if (next->ln != null)
                _sqtr_local_insertn(tree, startb, next->ln); /* reinsert left branch of removed node */
            return;
        }
        tree = next;
        continue;
    }
}

char *sqtr_local_pop(SQLTree *tree, char *key)
{
    assert_non_null(tree);
    assert_non_null(key);

    SQLNode *next;
    char *_key = key;
    unsigned char shifting_bits = 0;
    for (; *key != null; shifting_bits++)
    {
        if (shifting_bits == 8)
        {
            shifting_bits = 0;
            key++; /* increase byte right shift*/
        }
        if (((*key) >> shifting_bits) & 1)
        {
            if (tree->rn == null)
            {
                return null;
            }
            /* not directly set tree node, to reinsert leafs of node that is beeing removed */
            next = tree->rn;
            if (sqtr_local_keyeqval(next->key, _key) == 1)
            {
                /* set right node to null, to remove old node out of structure */
                tree->rn = null;
                /* reinsert nodes */
                int startb = (_key - key) + shifting_bits;
                if (next->rn != null)
                    _sqtr_local_insertn(tree, startb, next->rn); /* reinsert right branch of removed node */
                if (next->ln != null)
                    _sqtr_local_insertn(tree, startb, next->ln); /* reinsert left branch of removed node */
                void *ret = next->value;
                free(next);
                return ret;
            }
            tree = next;
            continue;
        }
        if (tree->ln == null)
        {
            return null;
        }
        /* not directly set tree node, to reinsert leafs of node that is beeing removed */
        next = tree->ln;
        if (sqtr_local_keyeqval(next->key, _key) == 1)
        {
            /* set right node to null, to remove old node out of structure */
            tree->ln = null;
            /* reinsert nodes */
            int startb = (_key - key) + shifting_bits;
            if (next->rn != null)
                _sqtr_local_insertn(tree, startb, next->rn); /* reinsert right branch of removed node */
            if (next->ln != null)
                _sqtr_local_insertn(tree, startb, next->ln); /* reinsert left branch of removed node */
            void *ret = next->value;
            free(next);
            return ret;
        }
        tree = next;
        continue;
    }
}

SQLNode *sqtr_local_popl(SQLTree *tree)
{
    assert_non_null(tree);

    SQLNode *_tree = tree;
    SQLNode *previous = tree;
    for (;;)
    {
        if (tree->ln != null)
        {
            previous = tree;
            tree = tree->ln;
        }
        else if (tree->rn != null)
        {
            previous = tree;
            tree = tree->rn;
        }
        else
        {
            if (previous == tree)
            {
                return null;
            }
            else
            {
                if (previous->rn == tree)
                    previous->rn = null;
                else
                    previous->ln = null;
                // printf("returning key: %s\n", tree->key);
                return tree;
            }
        }
    }
}