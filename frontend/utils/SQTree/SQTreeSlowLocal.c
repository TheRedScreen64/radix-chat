#include "SQTreeSlowLocal.h"

#include <string.h>

#include "../null.h"

SQLTree *sqtr_local_create()
{
    SQLTree *res = (SQLTree *)malloc(sizeof(SQLTree));
    res->key = null, res->rn = null, res->ln = null;
    return res;
}

void _sqtr_local_clonen(SQLNode *node1, SQLNode *node2)
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

SQLTree *sqtr_local_clone(SQLTree *tree)
{
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
    if (tree->ln == null && tree->rn == null)
        return 1;
    return 0;
}

void sqtr_local_set(SQLTree *tree, char *key, char *value)
{
    if (tree == null || key == null)
        return;
    // printf("set\n");
    // printf("%lld -> %s\n", key, key);
    char *_key = key;
    /* right shift bits */
    unsigned char shifting_bits = 0;
    for (; *key != 0; shifting_bits++)
    {
        // printf("tree: %lld\n", tree);
        // printf("key: %lld\n", tree->key);
        // printf("key: %s\n", tree->key);
        if (tree->key != null && sqtr_local_keyeqval(tree->key, _key) == 1)
        {
            tree->value = value;
            return;
        }
        if (shifting_bits == 8)
        {
            shifting_bits = 0;
            key++; /* increase byte right shift*/
        }
        if (((*key) >> shifting_bits) & 1)
        {
            if (tree->rn == null) /* if right node is null -> set right node to insert node */
            {
                SQLNode *insert = (SQLNode *)malloc(sizeof(SQLNode));
                // printf("New Tree: %lld\n", insert);
                insert->rn = null;
                insert->ln = null;
                insert->key = key;
                insert->value = value;
                tree->rn = insert;
                return;
            }
            /* not directly set tree node, to reinsert leafs of node that is beeing removed */
            tree = tree->rn;
            continue;
        }
        if (tree->ln == null) /* if left node is null -> set left node to insert node */
        {
            SQLNode *insert = (SQLNode *)malloc(sizeof(SQLNode));
            // printf("New Tree: %lld\n", insert);
            insert->rn = null;
            insert->ln = null;
            insert->key = key;
            insert->value = value;
            tree->ln = insert;
            return;
        }
        tree = tree->ln;
        continue;
    }
}

void *sqtr_local_get(SQLTree *tree, char *key)
{
    char *_key = key;
    /* right shift bits */
    unsigned char shifting_bits = 0;
    for (; *key != 0; shifting_bits++)
    {
        if (tree->key != null && strcmp(tree->key, _key) == 0)
        {
            return tree->value;
        }
        if (shifting_bits == 8)
        {
            shifting_bits = 0;
            key++; /* increase byte right shift*/
        }
        if (((*key) >> shifting_bits) & 1)
        {
            if (tree->rn == null)
            {
                /* return if branch ends */
                return null;
            }
            /* not directly set tree node, to reinsert leafs of node that is beeing removed */
            tree = tree->rn;
            continue;
        }
        if (tree->ln == null)
        {
            return null;
        }
        tree = tree->ln;
        continue;
    }
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
                return tree;
            }
        }
    }
}