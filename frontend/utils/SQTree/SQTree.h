/// @author Noah Nagel

#ifndef SQTREE_H /* just little different to bs tree */
#define SQTREE_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <sys/ioctl.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

#include "../String/String.h"
#include "../debug.h"

#ifndef CLIENT_DEF
    struct _qNode
    {
        char *key;
        char *value;
    };
#endif

    typedef struct _qNode SQNode;
    typedef struct _qTree SQTree; /* Root node */

    SQTree *sqtr_open(const char *name);

    void sqtr_foreach(SQNode *branch, void (*itr)(SQNode *node));

    void sqtr_set(SQTree *tree, char *key, char *value);

    void sqtr_sets(SQTree *tree, char* key, char *value, int value_size);

    SQNode *sqtr_optain(SQTree *tree, char *key);

    void sqtr_close(SQTree *tree);

    debug int sqtr_size(SQNode *branch, int size);
    
    debug int sqtr_longbr(SQTree *tree);

#ifdef __cplusplus
}
#endif
#endif