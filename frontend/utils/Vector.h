/// @author Noah Nagel

#ifndef VECTOR_H
#define VECTOR_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <malloc.h>

#define VECT_INIT_CAP 8

    typedef struct _Vect_str Vect_str;
    struct _Vect_str
    {
        char **_vect;
        unsigned int _size;
    };

    typedef struct _Vect_int Vect_int;
    struct _Vect_int
    {
        int *_vect;
        unsigned int _size;
    };

    typedef struct _Vect_ulong Vect_ulong;
    struct _Vect_ulong
    {
        unsigned long long *_vect;
        unsigned int _size;
    };

    typedef struct _Vect_double Vect_double;
    struct _Vect_double
    {
        double *_vect;
        unsigned int _size;
    };

/* vector type */
#define Vector(type)        \
    struct                  \
    {                       \
        type *_vect;        \
        unsigned int _size; \
    }

/* creates vector of <type> */
#define vect_create(type)                               \
    {                                                   \
        ._size = 0,                                     \
        ._vect = malloc(sizeof(type *) * VECT_INIT_CAP) \
    }

#define vect_initializeBuff(buff, type) \
    buff->_size = 0,                    \
    buff->_vect = malloc(sizeof(type *) * VECT_INIT_CAP)

#define vect_set(vect, type) \
    vect._size = 0,          \
    vect._vect = malloc(sizeof(type *) * VECT_INIT_CAP)

/* get average of vector */
#define vect_average(vect, type) ({ \
    double avrg = 0;                \
    vect_foreach(vect, type, t)     \
        avrg += (double)*t;         \
    avrg / vect._size;              \
})

/* get sum of vector */
#define vect_sum(vect, type) ({ \
    double total = 0;           \
    vect_foreach(vect, type, t) \
        total += (double)*t;    \
    total;                      \
})

/* adds <item> to <vect> */
#define vect_pushback(vect, item)                                                 \
    {                                                                             \
        if (vect._size == malloc_usable_size(vect._vect) / sizeof(item))          \
            vect._vect = realloc(vect._vect, malloc_usable_size(vect._vect) * 2); \
        *(vect._vect + (vect._size++)) = item;                                    \
    }

#define vect_pop(vect) (vect._size > 0 ? vect._vect[--(vect._size)] : 0)

/* adds <item> to <vect> */
#define vect_pushbackBuff(vect, item)                                            \
    if (vect->_size == malloc_usable_size(vect->_vect) / sizeof(item))           \
        vect->_vect = realloc(vect->_vect, malloc_usable_size(vect->_vect) * 2); \
    *(vect->_vect + (vect->_size++)) = item;

/* frees vector */
#define vect_free(vect) \
    free(vect._vect)

/* returns item at given <index> */
#define vect_get(vect, index) \
    *(vect._vect + index)

#define vect_foreach(vect, type, iterator) \
    type *end = vect._vect + vect._size;   \
    for (type *iterator = vect._vect; iterator < end; ++iterator)

/* keep in mind that the iterator is a pointer of type */
#define vect_foreachBuff(vect, type, iterator)        \
    type *iterator##_end = vect->_vect + vect->_size; \
    for (type *iterator = vect->_vect; iterator < iterator##_end; ++iterator)

/* call after an element was poped during iteration */
#define vect_iteratorPostPop() end--

/* get index of iterator pointer */
#define vect_getIndex(vect, pointer) (pointer - vect->_vect)

#define vect_popAtIndex(vect, type, i) ({                                                \
    type elem = vect->_vect[i];                                                          \
    /* Shift elements to the left to overwrite the popped element */                     \
    memmove(&vect->_vect[i], &vect->_vect[i + 1], (vect->_size - i - 1) * sizeof(type)); \
    /* Update the size if needed */                                                      \
    /*if ((vect->_size--) == malloc_usable_size(vect->_vect) / 2)  */                    \
    /*realloc(vect->_vect, vect->_size / 2);      */                                     \
    elem;                                                                                \
})

#ifdef __cplusplus
    extern "C"
}
#endif
#endif