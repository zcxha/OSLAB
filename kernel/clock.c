
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
							   clock.c
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
													Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#include "type.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "proto.h"
#include "global.h"

/*======================================================================*
						   clock_handler
 *======================================================================*/
PUBLIC void clock_handler(int irq)
{
	ticks++; // += 1 ms
    stat[p_proc_ready->pid]++;
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


/*======================================================================*
                           init_clock
 *======================================================================*/
PUBLIC void init_clock()
{
        /* 初始化 8253 PIT */
        out_byte(TIMER_MODE, RATE_GENERATOR);
        out_byte(TIMER0, (u8) (TIMER_FREQ/HZ) );
        out_byte(TIMER0, (u8) ((TIMER_FREQ/HZ) >> 8));

        put_irq_handler(CLOCK_IRQ, clock_handler);    /* 设定时钟中断处理程序 */
        enable_irq(CLOCK_IRQ);                        /* 让8259A可以接收时钟中断 */
}


