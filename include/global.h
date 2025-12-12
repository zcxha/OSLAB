
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            global.h
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                                    Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/* EXTERN is defined as extern except in global.c */
#ifdef	GLOBAL_VARIABLES_HERE
#undef	EXTERN
#define	EXTERN
#endif

EXTERN	int		ticks;

EXTERN	int		disp_pos;
EXTERN	u8		gdt_ptr[6];	// 0~15:Limit  16~47:Base
EXTERN	DESCRIPTOR	gdt[GDT_SIZE];
EXTERN	u8		idt_ptr[6];	// 0~15:Limit  16~47:Base
EXTERN	GATE		idt[IDT_SIZE];

EXTERN	u32		k_reenter;

EXTERN	TSS		tss;
EXTERN	PROCESS*	p_proc_ready;

EXTERN  int     nr_current_console;

EXTERN  u32             wait_cnt;

extern PROCESS proc_table[];
extern PROCESS* wait_table[];
extern  sched_entity se_table[];
extern	char		task_stack[];
extern  TASK            task_table[];
extern  TASK            user_proc_table[];
extern	irq_handler	irq_table[];
extern  TTY     tty_table[];
extern CONSOLE  console_table[];

/*---TEST---*/
extern int stat[];
/*---TEST---*/

extern const int sched_prio_to_weight[];
extern u32 sysctl_sched_latency;
extern u32 sysctl_sched_min_granularity;
extern u32 sched_nr_latency;

extern u32 nr_running;
extern u32 sum_weight;
extern u32 has_preempt;