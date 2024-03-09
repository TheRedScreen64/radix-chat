#include "SHashmap.h"
/* amount of buckets, before hashmap is being resized */
#define DEFAULT_CAPACITY 0xFULL
#define null 0

static hasht shm_hash(sK key)
{
    /* convert str to number */
    /* divide by 8, since memory addresses are mostly 64 bit alligned */
    return strhash(key);
}

SHashmap *shm_create(void)
{
    SHashmap *hm = malloc(sizeof(SHashmap));
    hm->size = 0;
    hm->capacity = DEFAULT_CAPACITY;
    hm->table = (Node **)malloc(DEFAULT_CAPACITY * sizeof(Node *));
    memset(hm->table, 0, DEFAULT_CAPACITY * sizeof(Node *));
    return hm;
}

void shm_createob(SHashmap *hm)
{
    assert_non_null(hm);

    hm->size = 0;
    hm->capacity = DEFAULT_CAPACITY;
    hm->table = (Node **)malloc(DEFAULT_CAPACITY * sizeof(Node *));
    memset(hm->table, 0, DEFAULT_CAPACITY * sizeof(Node *));
}

#undef DEFAULT_CAPACITY

#define getBucket(p) ({ *(hm->table + (p)); })
#define setBucket(p, b) *(hm->table + (p)) = b;
#define createNode() ({ (Node *)malloc(sizeof(Node)); })

void shm_putp(SHashmap *hm, Pair *p)
{
    assert_non_null(hm);
    assert_non_null(p);

    shm_put(hm, p->key, p->value);
}

#define shm_bucket_contains(bucket)

void shm_set(SHashmap *hm, sK key, sV value)
{
    assert_non_null(hm);
    assert_non_null(key);

    /* resize map if there are more elements than buckets */
    if (hm->size++ == hm->capacity)
        shm_resize(hm);
    hasht hash = shm_hash(key);
    hasht index = hash % hm->capacity;
    // printf("index: %lld\n", index);
    Node *bucket = getBucket(index);
    if (bucket == null) /* bucket is empty */
    {
        bucket = createNode();
        bucket->key = key, bucket->value = value, bucket->next = null, bucket->hash = hash;
        setBucket(index, bucket);
    }
    else /* bucket isnt empty*/
    {
        /* check if key is already present in map */
        for (Node *n = bucket; n != null; n = n->next)
        {
            if (strequals(n->key, key))
            {
                n->value = value;
                return;
            }
        }
        /* node isn't present yet -> create it */
        Node *node = createNode();
        node->key = key, node->value = value, node->next = bucket, node->hash = hash;
        setBucket(index, node);
    }
}

void shm_put(SHashmap *hm, sK key, sV value)
{
    assert_non_null(hm);
    assert_non_null(key);

    /* resize map if there are more elements than buckets */
    if (hm->size++ == hm->capacity)
        shm_resize(hm);
    hasht hash = shm_hash(key);
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

int shm_contains(SHashmap *hm, sK key)
{
    assert_non_null(hm);
    assert_non_null(key);

    hasht index = shm_hash(key) % hm->capacity;
    Node *bucket = getBucket(index);
    /* check if bucket of index even contains nodes */
    if (bucket != null)
        for (; bucket != null; bucket = bucket->next)
            if (strequals(bucket->key, key))
                return 1;
    return 0;
}

sV shm_get(SHashmap *hm, sK key)
{
    assert_non_null(hm);
    assert_non_null(key);

    hasht index = shm_hash(key) % hm->capacity;
    Node *bucket = getBucket(index);
    /* check if bucket of index even contains nodes */
    if (bucket != null)
        for (; bucket != null; bucket = bucket->next)
            if (strequals(bucket->key, key))
                return bucket->value;
    return null;
}

void shm_remove(SHashmap *hm, sK key)
{
    assert_non_null(hm);
    assert_non_null(key);

    hasht index = shm_hash(key) % hm->capacity;
    register Node *bucket = getBucket(index);
    register Node *prev = null;
    register Node *next = null;
    for (; bucket != null; prev = bucket, bucket = next)
    {
        next = bucket->next;
        if (strequals(bucket->key, key))
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

SHashmap *shm_copy(SHashmap *hm)
{
    assert_non_null(hm);

    SHashmap *ret = malloc(sizeof(SHashmap));
    ret->size = hm->size;
    ret->capacity = hm->capacity;
    ret->table = malloc(hm->capacity * sizeof(Node *));
    /* initialize table to prevent uninitialized value error */
    memset(ret->table, 0, hm->capacity * sizeof(Node *));
    ret->_hash = shm_hash;
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
static inline void shm_insertToBucketList(Node **list, Node *node, hasht capacity)
{
    hasht hash = node->hash;
    hasht index = hash % capacity;
    Node *bucket = getBucket(index);
    node->next = bucket;
    setBucket(index, node);
}

#undef getBucket
#undef setBucket

void shm_resize(SHashmap *hm)
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
                shm_insertToBucketList(new_table, node, hm->capacity);
                if (next == null)
                {
                    break;
                }
            }
    }
    free(hm->table);
    hm->table = new_table;
}

void shm_iterate(SHashmap *hm, void (*_iterator)(Pair *p))
{
    assert_non_null(hm);
    assert_non_null(_iterator);

    shm_foreach(hm, node, _iterator(&(Pair){.key = node->key, .value = node->value}));
}

void shm_delete(SHashmap *hm)
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

void shm_printBuckets(SHashmap *hm)
{
    assert_non_null(hm);

    Node **cap = (hm->table + hm->capacity);
    /* reinsert buckets */
    int i = 0;
    for (Node **bucket = hm->table; bucket != cap; ++bucket)
    {
        ++i;
        Node *node = *bucket;
        int j = 0;
        if (node != null)
            /* next variable is required, because the node->next attribute gets overriden in insert function. */
            for (; node != null; node = node->next)
                ++j;
        if (j == 1)
            printf("%d : %d\n", i, j);
        if (j > 1)
            printf("%d : \e[1m\e[31m%d\e[0m\n", i, j);
    }
}
#undef Node