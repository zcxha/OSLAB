
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            global.c
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                                    Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#define GLOBAL_VARIABLES_HERE

#include "type.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "proto.h"
#include "mm/aspace.h"
#include "mm/frame_allocator.h"
#include "mm/page_table.h"
#include "drv/hd.h"
#include "global.h"

PUBLIC	PROCESS			proc_table[NR_TASKS + NR_PROCS];
PUBLIC  PROCESS*         wait_table[NR_TASKS + NR_PROCS];// TODO: 采用动态数据结构



PUBLIC	char			task_stack[STACK_SIZE_TOTAL];

PUBLIC	TASK	task_table[NR_TASKS] = {
	{task_tty, STACK_SIZE_TTY, "TTY"},
    {task_sys, STACK_SIZE_SYS, "SYS"},
    {task_hd, STACK_SIZE_HD, "HD"}
};

PUBLIC	TASK	user_proc_table[NR_PROCS] = {
                    {TestA, STACK_SIZE_TESTA, "TestA"},
					{TestB, STACK_SIZE_TESTB, "TestB"},
					{TestC, STACK_SIZE_TESTC, "TestC"}};

PUBLIC  sched_entity se_table[NR_TASKS+NR_PROCS];

PUBLIC	irq_handler		irq_table[NR_IRQ];

PUBLIC	TTY		tty_table[NR_CONSOLES];
PUBLIC	CONSOLE		console_table[NR_CONSOLES];

PUBLIC	system_call		sys_call_table[NR_SYS_CALL] = {sys_printx, sys_sendrec};

/*---TEST---*/
PUBLIC int stat[NR_TASKS+NR_PROCS];
/*---TEST---*/

PUBLIC const int sched_prio_to_weight[40] = {
 /* -20 */     88761,     71755,     56483,     46273,     36291,
 /* -15 */     29154,     23254,     18705,     14949,     11916,
 /* -10 */      9548,      7620,      6100,      4904,      3906,
 /*  -5 */      3121,      2501,      1991,      1586,      1277,
 /*   0 */      1024,       820,       655,       526,       423,
 /*   5 */       335,       272,       215,       172,       137,
 /*  10 */       110,        87,        70,        56,        45,
 /*  15 */        36,        29,        23,        18,        15,
};

/*
 * Targeted preemption latency for CPU-bound tasks:
 *
 * NOTE: this latency value is not the same as the concept of
 * 'timeslice length' - timeslices in CFS are of variable length
 * and have no persistent notion like in traditional, time-slice
 * based scheduling concepts.
 *
 * (to see the precise effective timeslice length of your workload,
 *  run vmstat and monitor the context-switches (cs) field)
 *
 * (default: 6ms * (1 + ilog(ncpus)), units: nanoseconds)
 */
PUBLIC u32 sysctl_sched_latency			= 60000;

// 按照当前系统xxms一次中断的话，就是要触发latency次才完成一轮循环。

/*
 * Minimal preemption granularity for CPU-bound tasks:
 *
 * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
 */
PUBLIC u32 sysctl_sched_min_granularity			= 7500;

/*
 * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
 */
PUBLIC u32 sched_nr_latency = 8;

/* CFS rq */
PUBLIC u32 nr_running = 0;
PUBLIC u32 sum_weight = 0;
PUBLIC u32 has_preempt = 0;

/* Frame Tracker */
PUBLIC FrameTracker phy_frames[FRAME_COUNT];