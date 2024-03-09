/// @author Noah Nagel

#ifndef SQLTREE_H /* just little different to bs tree */
#define SQLTREE_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <malloc.h>

#include "../Vector.h"

    struct _qlNode
    {
        char *key;
        char *value;
        struct _qlNode *ln; /* left node */
        struct _qlNode *rn; /* right node */
        int free;
    };

    typedef struct _qlNode SQLNode;
    typedef struct _qlNode SQLTree; /* Root node */
    typedef struct _qlIterator SQLIterator;

    SQLTree *sqtr_local_create();

    SQLTree *sqtr_local_clone(SQLTree *tree);

    int sqtr_local_empty(SQLTree *tree);

    void sqtr_local_set(SQLTree *tree, char *key, char *value);

    void sqtr_local_foreach(SQLNode *branch, void (*itr)(SQLNode *node));

    void *sqtr_local_get(SQLTree *tree, char *key);

    void sqtr_local_delete(SQLTree *tree, char *key);

    char *sqtr_local_pop(SQLTree *tree, char *key);

    SQLNode *sqtr_local_popl(SQLTree *tree);

#define sqtr_local_free(tree)                                    \
    for (; !sqtr_local_empty(tree); free(sqtr_local_popl(tree))) \
        ;                                                        \
    free(tree);

#define sqtr_local_foreach_nr(tree, itr_func, itr_node_name)          \
    Vector(SQLNode *) itr_node_name##_stack = vect_create(SQLNode *); \
    register SQLNode *itr_node_name = tree;                           \
    while (itr_node_name != 0 || itr_node_name##_stack._size != 0)    \
    {                                                                 \
        while (itr_node_name != 0)                                    \
        {                                                             \
            vect_pushback(itr_node_name##_stack, itr_node_name);      \
            itr_node_name = itr_node_name->ln;                        \
        }                                                             \
        itr_node_name = vect_pop(itr_node_name##_stack);              \
        itr_func;                                                     \
        itr_node_name = itr_node_name->rn;                            \
    }

#ifdef __cplusplus
}
#endif
#endif