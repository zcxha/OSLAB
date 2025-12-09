
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                               proc.c
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

/* The idea is to set a period in which each task runs once.
 *
 * When there are too many tasks (sched_nr_latency) we have to stretch
 * this period because otherwise the slices get too small.
 *
 * p = (nr <= nl) ? l : l*nr/nl
 */
u32 __sched_period(unsigned long nr_running)
{
    if (nr_running > sched_nr_latency)
        return nr_running * sysctl_sched_min_granularity;
    else
        return sysctl_sched_latency;
}

u32 sched_slice(sched_entity *se)
{
    u32 slice = __sched_period(nr_running);
    return (slice * se->weight / sum_weight) / 10;
}

// 根据weight和传入的delta计算fair delta
u32 calc_delta_fair(u32 delta, sched_entity *se)
{
    if (se->priority != 20)
    {
        delta = delta * 1024 / se->weight;
    }
    return delta;
}
// schedule
PUBLIC void schedule()
{
    // 1. insert curr to rbtree
    // 2. pick nxt task and pop it out from rb
    // 3. update curr running proc
    // 4. context switch? auto
    p_proc_ready->se->exec_time = 0;
    p_proc_ready->se->run_node.key = p_proc_ready->se->vruntime;

    rb_insert(&p_proc_ready->se->run_node);
    sched_entity *se = __pick_first_entity();

    rb_delete(&se->run_node);
    p_proc_ready = se->proc;
}

/*
    add task to proc/se table idx
    主要功能就是设置相关字段、设置一下与se的绑定关系，然后设置第一次add的proc为proc_ready
*/
PUBLIC void add_task(TASK *p_task, char *p_task_stack, u16 selector_ldt,
                     u32 table_idx, u32 pid, u8 privilege, u8 rpl, int eflags /*, int prio*/)
{
    nr_running++;
    PROCESS *p_proc = &proc_table[table_idx];

    strcpy(p_proc->p_name, p_task->name); // name of the process
    p_proc->pid = pid;                    // pid

    p_proc->se = &se_table[table_idx];
    se_table[table_idx].proc = p_proc;
    // se_table[table_idx].priority = prio;

    p_proc->ldt_sel = selector_ldt;

    memcpy(&p_proc->ldts[0], &gdt[SELECTOR_KERNEL_CS >> 3],
           sizeof(DESCRIPTOR));
    p_proc->ldts[0].attr1 = DA_C | privilege << 5;
    memcpy(&p_proc->ldts[1], &gdt[SELECTOR_KERNEL_DS >> 3],
           sizeof(DESCRIPTOR));
    p_proc->ldts[1].attr1 = DA_DRW | privilege << 5;
    p_proc->regs.cs = ((8 * 0) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
    p_proc->regs.ds = ((8 * 1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
    p_proc->regs.es = ((8 * 1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
    p_proc->regs.fs = ((8 * 1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
    p_proc->regs.ss = ((8 * 1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
    p_proc->regs.gs = (SELECTOR_KERNEL_GS & SA_RPL_MASK) | rpl;

    p_proc->regs.eip = (u32)p_task->initial_eip;
    p_proc->regs.esp = (u32)p_task_stack;
    p_proc->regs.eflags = eflags; /* IF=1, IOPL=1 */
    if (!p_proc_ready)            // 在这里开始设置当前正在运行的进程。，、？
    {
        p_proc_ready = p_proc;
        p_proc_ready->nxt = p_proc;
        p_proc_ready->pre = p_proc;
    }
    else
    {
        PROCESS *tmp = p_proc_ready->nxt;
        tmp->pre = p_proc;
        p_proc->nxt = tmp;

        p_proc_ready->nxt = p_proc;
        p_proc->pre = p_proc_ready;
    }
    /* TODO: 新添加任务的vruntime不应该设置为0，否则会占用很长时间吧 */
    // .se.vruntime = __pick_first_entity().key
    // sumweight += weight
}

// 从当前进程开始扫描，扫描到pid等于的进程然后将其删除（TODO:注意此处存在没有释放资源的问题，不过没有实现内存分配器所以无所谓）
PUBLIC void rm_task(u32 pid)
{
    nr_running--;
    PROCESS *p = p_proc_ready;
    do
    {
        if (p->pid == pid)
        {
            // remove
            PROCESS *pre = p->pre;
            PROCESS *nxt = p->nxt;
            pre->nxt = nxt;
            nxt->pre = pre;

            if (pre == p)
            {
                p_proc_ready = 0;
            }
            // 删除当前进程
            if (p == p_proc_ready && pre != p)
            {
                p_proc_ready = pre;
            }
            break;
        }
        p = p->nxt;
    } while (p != p_proc_ready);
}

/*======================================================================*
                           sys_get_ticks
 *======================================================================*/
PUBLIC int sys_get_ticks()
{
    return ticks;
}
