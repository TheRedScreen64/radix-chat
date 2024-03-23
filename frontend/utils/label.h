/// @author Noah Nagel
/// temporary workaround system used in StringIterator.c 
/// (I know this is bad practice, just did it for the fun)
#ifndef LABEL_H
#define LABEL_H

/*
 * this is just an temporary workaround system,
 * only use on functions with no optimization
 */

/* create static label with id */
#define sticlbl_create(id) \
    asm volatile(#id ":");

/* get address of static label */
#define sticlbl_getaddr(id) ({                              \
    register void *label_address;                           \
    asm volatile("mov $" #id ", %0" : "=r"(label_address)); \
    label_address;                                          \
})

/* jump to label */
#define sticlbl_jump(id) \
    asm volatile("jmp " #id);

/* jump to address */
#define sticlbl_jumpa(addr) \
    asm volatile("jmp *%0" ::"r"(addr));

/* create infinite loop not detected by compiler */
#define sticlbl_loop(n, c) \
    sticlbl_create(n)      \
        c;                 \
    sticlbl_jump(n)

#endif