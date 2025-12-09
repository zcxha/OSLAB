
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
							main.c
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
							kernel_main
 *======================================================================*/
PUBLIC int kernel_main()
{
	disp_str("-----\"kernel_main\" begins-----\n");

	TASK *p_task = task_table;
	PROCESS *p_proc = proc_table;
	char *p_task_stack = task_stack + STACK_SIZE_TOTAL;
	u16 selector_ldt = SELECTOR_LDT_FIRST;

	add_task(p_task, p_task_stack, selector_ldt, 0, 0);
	p_task_stack -= p_task->stacksize;
	p_task++;
	selector_ldt += 1 << 3;
	add_task(p_task, p_task_stack, selector_ldt, 1, 1);
	p_task_stack -= p_task->stacksize;
	p_task++;
	selector_ldt += 1 << 3;
	add_task(p_task, p_task_stack, selector_ldt, 2, 2);


	proc_table[0].se->priority = 19;
	proc_table[1].se->priority = 20;// nice0
	proc_table[2].se->priority = 21;


	sum_weight = 0;
	for(int i = 0; i < NR_TASKS; i++)
	{
		sched_entity *se = proc_table[i].se;
		se->weight = sched_prio_to_weight[se->priority];
		sum_weight += se->weight;
	}

	for(int i = 0; i < NR_TASKS; i++)
	{
		sched_entity *se = proc_table[i].se;
		se->exec_time = 0;
		se->start_time = ticks;
		se->vruntime = 0;
		se->run_node.se = proc_table[i].se;
		se->run_node.key = se->vruntime;
		rb_insert(&se->run_node);
	}

	// PROCESS* tmp = __pick_first_entity()->proc;
	// sched_entity *se1 = __pick_first_entity();
	// disp_int(se1->proc->pid);
	// __asm__("xchg %bx, %bx");
	// add_task(0) has set A to be curr
	// so deque entity

	rb_delete(&proc_table[0].se->run_node);

	k_reenter = 0;
	ticks = 0;

	/* 初始化 8253 PIT */
	out_byte(TIMER_MODE, RATE_GENERATOR);
	out_byte(TIMER0, (u8)(TIMER_FREQ / HZ));
	out_byte(TIMER0, (u8)((TIMER_FREQ / HZ) >> 8));

	put_irq_handler(CLOCK_IRQ, clock_handler); /* 设定时钟中断处理程序 */
	enable_irq(CLOCK_IRQ);					   /* 让8259A可以接收时钟中断 */

	restart();

	while (1)
	{
	}
}

/*======================================================================*
							   TestA
 *======================================================================*/
void TestA()
{
	int i = 0;
	while (1)
	{
		disp_int(proc_table[0].pid);
		proc_table[0].pid = 4;
		disp_str("A.");
		milli_delay(1);
	}
}

/*======================================================================*
							   TestB
 *======================================================================*/
void TestB()
{
	int i = 0x1000;
	while (1)
	{
		disp_str("B.");
		milli_delay(1);
	}
}

/*======================================================================*
							   TestB
 *======================================================================*/
void TestC()
{
	int i = 0x2000;
	while (1)
	{
		disp_str("C.");
		milli_delay(1);
	}
}
