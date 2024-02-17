/// @author Noah Nagel

#ifndef SQLTREE_H /* just little different to bs tree */
#define SQLTREE_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <malloc.h>

    struct _qlNode
    {
        char *key;
        char *value;
        struct _qlNode *ln; /* left node */
        struct _qlNode *rn; /* right node */
    };

    typedef struct _qlNode SQLNode;
    typedef struct _qlNode SQLTree; /* Root node */
    typedef struct _qlIterator SQLIterator;

    SQLTree *sqtr_local_create();

    void _sqtr_local_clonen(SQLNode *node1, SQLNode *node2);

    SQLTree *sqtr_local_clone(SQLTree *tree);

    int sqtr_local_empty(SQLTree *tree);

    void sqtr_local_set(SQLTree *tree, char *key, char *value);

    void *sqtr_local_get(SQLTree *tree, char *key);

    void sqtr_local_delete(SQLTree *tree, char *key);

    char *sqtr_local_pop(SQLTree *tree, char *key);

    SQLNode *sqtr_local_popl(SQLTree *tree);

#define sqtr_local_free(tree)                                    \
    for (; !sqtr_local_empty(tree); free(sqtr_local_popl(tree))) \
        ;                                                        \
    free(tree);

#ifdef __cplusplus
}
#endif
#endif