
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
							   clock.c
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
													Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "global.h"

/*======================================================================*
						   clock_handler
 *======================================================================*/
PUBLIC void clock_handler(int irq)
{
	ticks++; // += 1 ms
	/* update_curr */
	// DELTA_EXEC = 1000
	p_proc_ready->se->exec_time += 1000; // 1ms = 1000milli
	p_proc_ready->se->vruntime += calc_delta_fair(1000, p_proc_ready->se);

	/* check_preempt_tick */
	if (k_reenter != 0)
	{
		return;
	}

	u32 ideal_runtime = sched_slice(p_proc_ready->se);

	if (p_proc_ready->se->exec_time > ideal_runtime)
	{
		schedule();
		return;
	}

	if (p_proc_ready->se->exec_time < sysctl_sched_min_granularity)
	{
		return;
	}

	sched_entity *se = __pick_first_entity();

	int delta = (int)p_proc_ready->se->vruntime - (int)se->vruntime;

	if(delta < 0) return;

	if(delta > ideal_runtime){
		schedule();
	}
}

/*======================================================================*
							  milli_delay
 *======================================================================*/
PUBLIC void milli_delay(int milli_sec)
{
	int t = get_ticks();

	while (((get_ticks() - t) * 1000 / HZ) < milli_sec)
	{
	}
}
