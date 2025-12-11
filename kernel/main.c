
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            main.c
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
                            kernel_main
 *======================================================================*/
PUBLIC int kernel_main()
{
    disp_str("-----\"kernel_main\" begins-----\n");

    TASK *p_task = task_table;
    PROCESS *p_proc = proc_table;
    char *p_task_stack = task_stack + STACK_SIZE_TOTAL;
    u16 selector_ldt = SELECTOR_LDT_FIRST;

    int i;
    for (i = 0; i < NR_TASKS + NR_PROCS; i++)
    {

        /*---TEST---*/
        stat[i] = 0;
        /*---TEST---*/

        if (i < NR_TASKS)
        { // 添加TASK
            p_task = task_table + i;
            add_task(p_task, p_task_stack, selector_ldt, i, i, PRIVILEGE_TASK, RPL_TASK, 0x1202, 15);
        }
        else
        { // 添加用户态进程
            p_task = user_proc_table + (i - NR_TASKS);
            int prio = 20;
            if(i-NR_TASKS == 0)
            {
                prio = 15;
            }
            else if(i-NR_TASKS == 1)
            {
                prio = 25;
            }
            add_task(p_task, p_task_stack, selector_ldt, i, i, PRIVILEGE_USER, RPL_USER, 0x202, prio);
        }
        p_task_stack -= p_task->stacksize;
        selector_ldt += 1 << 3;
    }

    // 设置进程优先级
    // proc_table[0].se->priority = 15;
    // proc_table[1].se->priority = 19;
    // proc_table[2].se->priority = 20; // nice0
    // proc_table[3].se->priority = 21;

    proc_table[NR_TASKS+0].nr_tty = 0;
    proc_table[NR_TASKS+1].nr_tty = 1;
    proc_table[NR_TASKS+2].nr_tty = 1;

    sum_weight = 0;

    // 转换weight
    for (int i = 0; i < NR_TASKS + NR_PROCS; i++)
    {
        sched_entity *se = proc_table[i].se;
        se->weight = sched_prio_to_weight[se->priority];
        sum_weight += se->weight;
    }

    // 初始化se
    for (int i = 0; i < NR_TASKS + NR_PROCS; i++)
    {
        sched_entity *se = proc_table[i].se;
        se->exec_time = 0;
        se->start_time = ticks;
        se->vruntime = 0;
        se->run_node.se = proc_table[i].se;
        se->run_node.key = se->vruntime;

        rb_insert(&se->run_node);
    }

    wait_cnt = 0;

    // PROCESS* tmp = __pick_first_entity()->proc;
    // sched_entity *se1 = __pick_first_entity();
    // disp_int(se1->proc->pid);
    // __asm__("xchg %bx, %bx");
    // add_task(0) has set A to be curr
    // so deque entity

    // 因为进程开始运行了，那么就要从红黑树中删去
    rb_delete(&proc_table[0].se->run_node);

    k_reenter = 0;
    ticks = 0;

    init_clock();
    init_keyboard();

    restart();

    while (1)
    {
    }
}


/*****************************************************************************
 *                                get_ticks
 *****************************************************************************/
PUBLIC int get_ticks()
{
    MESSAGE msg;
    reset_msg(&msg);
    msg.type = GET_TICKS;
    send_recv(BOTH, TASK_SYS, &msg);
    return msg.RETVAL;
}

/*======================================================================*
                               TestA
 *======================================================================*/
void TestA()
{
    // TEST CFS SCHED MODULE
    int flag = 0;

    while (1)
    {
        if(get_ticks() >= 5000 && !flag)
        {
            flag = 1;
            for(int i = 0; i < NR_TASKS+NR_PROCS; i++)
            {
                printf("%d ", stat[i]);
            }
        }
        // printf("A");
        // milli_delay(100);
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
        // printf("B");
        // milli_delay(100);
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
        // printf("C");
        // milli_delay(100);
    }
}


/*****************************************************************************
 *                                panic
 *****************************************************************************/
PUBLIC void panic(const char *fmt, ...)
{
    int i;
    char buf[256];

    /* 4 is the size of fmt in the stack */
    va_list arg = (va_list)((char *)&fmt + 4);

    i = vsprintf(buf, fmt, arg);

    printl("%c !!panic!! %s", MAG_CH_PANIC, buf);

    /* should never arrive here */
    __asm__ __volatile__("ud2");
}
