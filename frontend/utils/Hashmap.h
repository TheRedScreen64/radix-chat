/// Hashmap in Format <Int64, Int64> 
/// @author Noah Nagel

#ifndef HASHMAP_H
#define HASHMAP_H

#ifdef __cplusplus
extern "C"
{
#endif
  
#define Node struct _hashnode
#define null 0

/* amount of buckets, before hashmap is being resized */ 
#define DEFAULT_CAPACITY 0xFULL
  
typedef struct _hashmap Hashmap;
typedef struct _pair Pair;
typedef unsigned long long hasht;
typedef void *K;
typedef void *V;
  
struct _pair
{
    void *key;
    void *value;
};
/* static */ hasht hm_hash(K key);

/// @brief Creates new Hashmap
/// @return new Hashmap
Hashmap *hm_create();

/// @brief Puts a new Pair into the hashmap (even if the Hashmap already contains the Pair)
/// @param hm used Hashmap
/// @param p used Pair
void hm_putp(Hashmap *hm, Pair *p);

/// @brief Direcly put a pair into the hashmap by using Key and Value (even if the Hashmap already contains the Pair)
/// @param hm used Hashmap
/// @param key used Key
/// @param value associated with Key
void hm_put(Hashmap *hm, K key, V value);

/// @brief same as hm_put but checks if <key> is already present and updates value in case 
void hm_set(Hashmap *hm, K key, V value);

/// @brief Checks if a Hashmap contains a given Key
/// @param hm used Hashmap
/// @param key that is being checked
/// @return 1 if <hm> contains <key> 0 if not
int hm_contains(Hashmap *hm, K key);

V hm_get(Hashmap *hm, K key);

/// @brief pops value out of map, can be called multiple times if one key has multiple values
V hm_pop(Hashmap *hm, K key);

/// @brief Removes the Node associated with a Key from the Hashmap
/// @param hm used Hashmap
/// @param key used Key
void hm_remove(Hashmap *hm, K key);

/// @brief Copies a given Hashmap
Hashmap *hm_copy(Hashmap *hm);


/// @brief Doubles the Amount of Buckets in the Hashmap (automatically gets called when map is full)
/// @param hm used Hashmap
void hm_resize(Hashmap *hm);

/// @brief Iterates over a Hashmap
/// @param hm used Hashmap
/// @param _iterator used Iterator
void hm_iterate(Hashmap *hm, void (*_iterator)(Pair *p));

/// @brief Delets the entire Hashmap using free function
/// @param hm Hashmap that is being deleted
void hm_delete(Hashmap *hm);


#ifdef __cplusplus
}
#endif

#endif