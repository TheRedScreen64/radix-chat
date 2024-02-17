/// @author Noah Nagel

#define __NMAP_DEFAULT_MAIN_BUFFER_SIZE (64)
#define __NMAP_DEFAULT_PAGESIZE sizeof(void *) /* make allocations 64 bit alligned */
typedef unsigned long long _nmap_ptr;
#define nmap_array(type) unsigned long long
#define nmap_ptr(type) unsigned long long
/* get size on nmap of datatype <type> */
#define nmap_sizeof(type) ((sizeof(type) - (sizeof(type) % __NMAP_DEFAULT_PAGESIZE)) + __NMAP_DEFAULT_PAGESIZE)
typedef unsigned long long _nmap_size;
typedef struct _nmap NMap;
