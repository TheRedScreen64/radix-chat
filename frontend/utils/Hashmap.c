#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <immintrin.h>

#include "debug.h"
#include "null.h"

#define Node struct _hashnode

/* amount of buckets, before hashmap is being resized */
#define DEFAULT_CAPACITY 0xFULL

typedef struct _hashmap Hashmap;
typedef struct _pair Pair;
typedef unsigned long long hasht;
typedef void *K;
typedef void *V;

struct _hashmap
{
    unsigned long long size;
    unsigned long long capacity;
    struct _hashnode **table;
};

struct _hashnode
{
    void *key;
    void *value;
    hasht hash;
    struct _hashnode *next;
};

struct _pair
{
    void *key;
    void *value;
};

static hasht hm_hash(K key)
{
    /* divide by 8, since memory addresses are mostly 64 bit alligned */
    return ((hasht)key / 8);
}

Hashmap *hm_create()
{
    Hashmap *ret = _malloc(sizeof(Hashmap));
    ret->size = 0;
    ret->capacity = DEFAULT_CAPACITY;
    ret->table = (Node **)malloc(DEFAULT_CAPACITY * sizeof(Node *));
    return ret;
}

#undef DEFAULT_CAPACITY

#define getBucket(p) ({ *(hm->table + (p)); })
#define setBucket(p, b) *(hm->table + (p)) = b;
#define createNode() ({ (Node *)malloc(sizeof(Node)); })

void hm_putp(Hashmap *hm, Pair *p)
{
    assert_non_null(hm);
    assert_non_null(p);

    hm_put(hm, p->key, p->value);
}

void hm_put(Hashmap *hm, K key, V value)
{
    assert_non_null(hm);

    /* resize map if there are more elements than buckets */
    if (hm->size++ == hm->capacity)
        hm_resize(hm);
    hasht hash = hm_hash(key);
    hasht index = hash % hm->capacity;
    // printf("index: %lld\n", index);
    Node *bucket = getBucket(index);
    if (bucket == null)
    {
        bucket = createNode();
        bucket->key = key, bucket->value = value, bucket->next = null, bucket->hash = hash;
        setBucket(index, bucket);
    }
    else
    {
        // printf("true \n");
        Node *node = createNode();
        node->key = key, node->value = value, node->next = bucket, node->hash = hash;
        setBucket(index, node);
        // printf("%lld\n", getBucket(index)->key);
    }
}

void hm_set(Hashmap *hm, K key, V value)
{
    assert_non_null(hm);

    /* resize map if there are more elements than buckets */
    if (hm->size++ == hm->capacity)
        hm_resize(hm);
    hasht hash = hm_hash(key);
    hasht index = hash % hm->capacity;
    // printf("index: %lld\n", index);
    Node *bucket = getBucket(index);
    if (bucket == null)
    {
        bucket = createNode();
        bucket->key = key, bucket->value = value, bucket->next = null, bucket->hash = hash;
        setBucket(index, bucket);
    }
    else
    {
        /* check if key is already present in map */
        for (Node *n = bucket; n != null; n = n->next)
        {
            if (n->key == key)
            {
                n->value = value;
                return;
            }
        }

        /* node isn't present yet -> create it */
        // printf("true \n");
        Node *node = createNode();
        node->key = key, node->value = value, node->next = bucket, node->hash = hash;
        setBucket(index, node);
        // printf("%lld\n", getBucket(index)->key);
    }
}

int hm_contains(Hashmap *hm, K key)
{
    assert_non_null(hm);

    hasht index = hm_hash(key) % hm->capacity;
    Node *bucket = getBucket(index);
    /* check if bucket of index even contains nodes */
    if (bucket != null)
        for (; bucket != null; bucket = bucket->next)
            if (bucket->key == key)
                return 1;
    return 0;
}

V hm_get(Hashmap *hm, K key)
{
    assert_non_null(hm);

    hasht index = hm_hash(key) % hm->capacity;
    Node *bucket = getBucket(index);
    /* check if bucket of index even contains nodes */
    if (bucket != null)
        for (; bucket != null; bucket = bucket->next)
            if (bucket->key == key)
                return bucket->value;
    return null;
}

V hm_pop(Hashmap *hm, K key)
{
    assert_non_null(hm);

    hasht index = hm_hash(key) % hm->capacity;
    register Node *bucket = getBucket(index);
    register Node *prev = null;
    register Node *next = null;
    register V ret;
    for (; bucket != null; prev = bucket, bucket = next)
    {
        next = bucket->next;
        if (bucket->key == key) /* stop on first entry */
        {
            ret = bucket->value;
            if (prev == null) /* if there is no previous element, set first element of bucket to next node */
            {
                setBucket(index, bucket->next);
                free(bucket);
                break;
            }
            /* close gap if there is an previous node */
            prev->next = bucket->next;
            free(bucket);
            break;
        }
    }
    return ret;
}

void hm_remove(Hashmap *hm, K key)
{
    assert_non_null(hm);

    hasht index = hm_hash(key) % hm->capacity;
    register Node *bucket = getBucket(index);
    register Node *prev = null;
    register Node *next = null;
    for (; bucket != null; prev = bucket, bucket = next)
    {
        next = bucket->next;
        if (bucket->key == key)
        {
            if (prev == null) /* if there is no previous element, set first element of bucket to next node */
            {
                setBucket(index, bucket->next);
                free(bucket);
                return;
            }
            /* close gap if there is an previous node */
            prev->next = bucket->next;
            free(bucket);
            return;
        }
    }
}

#undef setBucket
#define setBucket(p, b) *p = b;

Hashmap *hm_copy(Hashmap *hm)
{
    assert_non_null(hm);

    Hashmap *ret = malloc(sizeof(Hashmap));
    ret->size = hm->size;
    ret->capacity = hm->capacity;
    ret->table = malloc(hm->capacity * sizeof(Node *));
    /* initialize table to prevent uninitialized value error */
    memset(ret->table, 0, hm->capacity);
    Node **cap = (hm->table + hm->capacity);
    Node **new_bucket = ret->table;
    for (Node **original_bucket = hm->table; original_bucket != cap; ++original_bucket, ++new_bucket)
    {
        Node *original_node = *original_bucket;
        if (original_node != null)
        {
            for (; original_node != null; original_node = original_node->next)
            {
                Node *new_node = createNode();
                new_node->key = original_node->key, new_node->value = original_node->value;
                new_node->hash = original_node->hash, new_node->next = null;
                if (*new_bucket == null)
                {
                    setBucket(new_bucket, new_node);
                }
                else
                {
                    new_node->next = *new_bucket;
                    setBucket(new_bucket, new_node);
                }
            }
        }
    }
    return ret;
}

#undef setBucket
#undef getBucket
#undef createNode

#define getBucket(p) ({ *(list + (p)); })
#define setBucket(p, b) *(list + (p)) = b;
static inline void hm_insertToBucketList(Node **list, Node *node, hasht capacity)
{
    hasht hash = node->hash;
    hasht index = hash % capacity;
    Node *bucket = getBucket(index);
    node->next = bucket;
    setBucket(index, node);
}

#undef getBucket
#undef setBucket

void hm_resize(Hashmap *hm)
{
    assert_non_null(hm);

    Node **cap = (hm->table + hm->capacity);
    hm->capacity <<= 1; /* double amounts of buckets */
    Node **new_table = (Node **)malloc(hm->capacity * sizeof(Node *));
    memset(new_table, 0, hm->capacity * sizeof(Node *));
    /* reinsert buckets */
    for (Node **bucket = hm->table; bucket != cap; ++bucket)
    {
        Node *node = *bucket;
        if (node != null)
            /* next variable is required, because the node->next attribute gets overriden in insert function. */
            for (Node *next;; node = next)
            {
                next = node->next;
                hm_insertToBucketList(new_table, node, hm->capacity);
                if (next == null)
                {
                    break;
                }
            }
    }
    free(hm->table);
    hm->table = new_table;
}

void hm_iterate(Hashmap *hm, void (*_iterator)(Pair *p))
{
    assert_non_null(hm);
    assert_non_null(_iterator);

    Node **cap = (hm->table + hm->capacity);
    for (Node **bucket = hm->table; bucket != cap; ++bucket)
    {
        Node *node = *bucket;
        if (node != null)
            for (; node != null; node = node->next)
                _iterator(&(Pair){.key = node->key, .value = node->value});
    }
}

void hm_delete(Hashmap *hm)
{
    assert_non_null(hm);

    Node **cap = (hm->table + hm->capacity);
    for (Node **bucket = hm->table; bucket != cap; ++bucket)
    {
        Node *node = *bucket;
        if (node != null)
            for (Node *next; node != null; node = next)
            {
                next = node->next;
                free(node);
            }
    }
    free(hm->table);
    free(hm);
}
#undef Node