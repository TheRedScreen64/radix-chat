/// @author Noah Nagel

#ifndef TIMEOUT_H
#define TIMEOUT_H
#ifdef __cplusplus
extern "C"
{
#endif

/// @brief initialize timeout cycle with <timeout_ms> ms timeout
struct timeout_cycle *timeout_cycle_init(long long timeout_ms);

/// @brief invoke <handler> after <t_cycles> cycles
void timeout_set(struct timeout_cycle* cycle, long long t_cycles, void (*handler)());

/// @brief dump cycle
void timeout_cycle_stop(struct timeout_cycle* cycle);

#ifdef __cplusplus
}
#endif
#endif