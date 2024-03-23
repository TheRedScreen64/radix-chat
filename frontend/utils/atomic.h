/// macro for simple atomic operations 
/// @author Noah Nagel

#ifndef ATOMIC_H
#define ATOMIC_H

typedef int aelock_t;

/* initialize lock */
#define atomice_init() 1

/* run atomic operation <seq> */
#define atomice_run(lock, seq)                          \
    while (!lock) /* loop to let time to modify lock */ \
        for (register int i = 0; i < 5; ++i)            \
            ;                                           \
    lock = 0;                                           \
    seq; /* execute atomic operation */                 \
    lock = 1;

#endif