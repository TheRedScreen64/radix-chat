/// @author Noah Nagel
/// Simple Database Interface built on NMap System

#ifndef SQTREE_H /* just little different to bs tree */
#define SQTREE_H

#ifdef __cplusplus
extern "C"
{
#endif
#include "NMap.h"
#include "../boolean.h"
#include "../debug.h"
#include "../Vector.h"
#include "../String/String.h"

    typedef struct _qNode
    {
        char *key;
        char *value;
        struct _qNode *ln; /* left node */
        struct _qNode *rn; /* right node */
        int free;
    } SQNode;

    typedef struct _qTree
    {
        char *key;
        char *value;
        struct _qNode *ln; /* left node */
        struct _qNode *rn; /* right node */
        int free;

        /* tree footer */
        struct _qNode *branch;
        NMap *map;
    } SQTree;

    typedef struct _qPair
    {
        char *key;
        char *value;
    } SQPair;

    extern SQTree *sqtr_open(const char *name);

    extern SQTree *sqtr_openOnDevice(const char *name, const char *deviceName);

    extern void sqtr_foreach(SQNode *branch, void (*itr)(SQNode *node));

    extern void sqtr_set(SQTree *tree, char *key, char *value);

    /**
     * @brief appends <c> to the value corresponding to <key> (only works with null terminated strings)
     * @param tree
     * @param key
     */
    extern void sqtr_concat(SQTree *tree, char *key, char *c);

    /**
     * @brief deletes an element
     * @param tree
     * @param key
     * @return temporary node pointer persistent till the next tree operation or null if node wasn't present in tree
     */
    extern SQNode *sqtr_pop(SQTree *tree, char *key);

    /**
     * @brief deletes an element
     * @param tree
     * @param key
     */
    extern void sqtr_remove(SQTree *tree, char *key);

    /**
     * @param tree
     * @param key
     * @return false if key is already present in tree, otherwise true
     */
    extern tBoolean sqtr_available(SQTree *tree, char *key);

    /**
     * @brief inserts a pair into the tree if the key isn't present currently
     * @param tree
     * @param key
     * @param value
     * @return false if key is already present in tree, otherwise true
     */
    extern tBoolean sqtr_insertIfAvailable(SQTree *tree, char *key, char *value);

    /**
     * @brief insert for values that aren't \00 terminated, used for structs or binary file data
     * @param tree
     * @param key
     * @param value
     * @param value_size
     */
    extern void sqtr_sets(SQTree *tree, char *key, char *value, int value_size);

    extern SQNode *sqtr_optain(SQTree *tree, char *key);

    extern void sqtr_walkdir(SQTree *tree, char *dir);

    extern void sqtr_close(SQTree *tree);

    extern debug int sqtr_size(SQNode *branch, int size);

    extern debug int sqtr_longbr(SQTree *tree);

    /**
     * @brief foreach method that does not depend on recursion
     */
#define sqtr_foreach_nr(tree, itr_func, itr_node_name)              \
    Vector(SQNode *) itr_node_name##_stack = vect_create(SQNode *); \
    register SQNode *itr_node_name = (SQNode *)tree;                \
    while (itr_node_name != 0 || itr_node_name##_stack._size != 0)  \
    {                                                               \
        while (itr_node_name != 0)                                  \
        {                                                           \
            vect_pushback(itr_node_name##_stack, itr_node_name);    \
            itr_node_name = itr_node_name->ln;                      \
        }                                                           \
        itr_node_name = vect_pop(itr_node_name##_stack);            \
        if (!itr_node_name->free)                                   \
        {                                                           \
            itr_func;                                               \
        }                                                           \
        itr_node_name = itr_node_name->rn;                          \
    }

    /**
     * @brief foreach method that only matches nodes which keys start with <dir>
     */
#define sqtr_walkdir(tree, dir, itr_func, itr_node_name)        \
    assert_non_null(tree);                                      \
    assert_non_null(dir);                                       \
                                                                \
    register SQNode *n = (SQNode *)tree;                        \
    for (register unsigned int i = 0; dir[i / 8] != '\00'; i++) \
    {                                                           \
        if (strstartswith(n->key, dir))                         \
        {                                                       \
            SQNode *itr_node_name = n;                          \
            itr_func;                                           \
        }                                                       \
        if ((dir[i / 8] >> (i % 8)) & 1)                        \
            if ((n = n->rn) != 0)                               \
                continue;                                       \
            else                                                \
                break;                                          \
        else if ((n = n->ln) != 0)                              \
            continue;                                           \
        else                                                    \
            break;                                              \
    }                                                           \
    /* after end of directory string just do foreach */         \
    sqtr_foreach_nr(                                            \
        n, if (strstartswith(n->key, dir)) {SQNode* itr_node_name = current; itr_func; }, current);

#ifdef __cplusplus
}
#endif
#endif