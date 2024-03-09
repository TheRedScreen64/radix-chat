#include "timeout.h"
#include "Vector.h"
#include "MapT.h"
#include "Hashmap.h"
#include "atomic.h"
#include "debug.h"

#include <pthread.h>

/* atomic */ struct timeout_cycle
{
    pthread_t cyc_thread;
    unsigned long long cyc_current;
    unsigned long long cyc_timeout;
    int cyc_active;
    aelock_t cyc_lock;

    Map(Hashmap, unsigned long long /* cycle number*/, void * /* handler */) cyc_tasks;
};

static void timeout_cycle(struct timeout_cycle *cycle)
{
    assert_non_null(cycle);

    for (register long long timeout = cycle->cyc_timeout; cycle->cyc_active; cycle->cyc_current++)
    {
        usleep(timeout);
        atomice_run(
            cycle->cyc_lock,
            {
                g_h:
                    register void (*handler)() = hm_pop(cycle->cyc_tasks, cycle->cyc_current);
                    if (handler != null) /* check if there are other entries with same key */
                    {
                        handler();
                        goto g_h;
                    }
            });
    }

    free(cycle);
}

struct timeout_cycle *timeout_cycle_init(long long timeout_ms)
{
    struct timeout_cycle *cycle = (struct timeout_cycle *)malloc(sizeof(struct timeout_cycle));

    cycle->cyc_active = 1;
    cycle->cyc_current = 0;
    cycle->cyc_lock = atomice_init();
    cycle->cyc_timeout = timeout_ms;

    if (pthread_create(&cycle->cyc_thread, NULL, (void *(*)(void *)) & timeout_cycle, (void *)cycle) != 0)
    {
        perror("pthread");
        return;
    }
}

void timeout_set(struct timeout_cycle *cycle, long long t_cycles, void (*handler)())
{
    assert_non_null(cycle);
    assert_non_null(handler);

    atomice_run(
        cycle->cyc_lock,
        {
            hm_put(cycle->cyc_tasks, (K)cycle->cyc_current + t_cycles, (V)handler);
        });
}

void timeout_cycle_stop(struct timeout_cycle *cycle)
{
    assert_non_null(cycle);

    cycle->cyc_active = 0;
}