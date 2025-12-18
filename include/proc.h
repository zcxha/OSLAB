
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
							   proc.h
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
													Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

typedef struct s_stackframe
{					/* proc_ptr points here				↑ Low			*/
	u32 gs;			/* ┓						│			*/
	u32 fs;			/* ┃						│			*/
	u32 es;			/* ┃						│			*/
	u32 ds;			/* ┃						│			*/
	u32 edi;		/* ┃						│			*/
	u32 esi;		/* ┣ pushed by save()				│			*/
	u32 ebp;		/* ┃						│			*/
	u32 kernel_esp; /* <- 'popad' will ignore it			│			*/
	u32 ebx;		/* ┃						↑栈从高地址往低地址增长*/
	u32 edx;		/* ┃						│			*/
	u32 ecx;		/* ┃						│			*/
	u32 eax;		/* ┛						│			*/
	u32 retaddr;	/* return address for assembly code save()	│			*/
    u32 err_code;   /* err code pushed by CPU when exception occurs */
	u32 eip;		/*  ┓						│			*/
	u32 cs;			/*  ┃						│			*/
	u32 eflags;		/*  ┣ these are pushed by CPU during interrupt	│			*/
	u32 esp;		/*  ┃						│			*/
	u32 ss;			/*  ┛						┷High			*/
} STACK_FRAME;

typedef struct sched_entity {
	u32 exec_time;
	u32 priority;
	u32 vruntime;
	u32 weight;
	u32 start_time;
	struct s_proc *proc;
	struct rbnode run_node;
}sched_entity;

typedef struct s_proc
{
	STACK_FRAME regs; /* process registers saved in stack frame */

	u16 ldt_sel;			   /* gdt selector giving ldt base and limit */
    pte* pg_dir_base; // TODO本该是pg_table 但是不完整类型，见你的导入顺序。
    DESCRIPTOR ldts[LDT_SIZE]; /* local descriptors for code and data */

	struct sched_entity *se; /* sched_entity */

	u32 pid;		 /* process id passed in from MM */
	char p_name[16]; /* name of the process */
	struct s_proc *pre;
	struct s_proc *nxt;


	int  p_flags;              /**
				    * process flags.
				    * A proc is runnable iff p_flags==0
				    */

	MESSAGE * p_msg;
	int p_recvfrom;
	int p_sendto;

	int has_int_msg;           /**
				    * nonzero if an INTERRUPT occurred when
				    * the task is not ready to deal with it.
				    */

	struct s_proc * q_sending;   /**
				    * queue of procs sending messages to
				    * this proc
				    */
	struct s_proc * next_sending;/**
				    * next proc in the sending
				    * queue (q_sending)
				    */

                    /*
                        这个进程页目录基地址，在进程切换的时候会负责切换CR3
                    */
    int nr_tty;
} PROCESS;

typedef struct s_task
{
	task_f initial_eip;
	int stacksize;
	char name[32];
} TASK;

#define proc2pid(x) (x - proc_table)

/* Number of tasks */
#define NR_TASKS 3
#define NR_PROCS 3

/* stacks of tasks */
#define STACK_SIZE_TTY   0x8000
#define STACK_SIZE_SYS	 0x8000
#define STACK_SIZE_HD    0x8000
#define STACK_SIZE_TESTA 0x8000
#define STACK_SIZE_TESTB 0x8000
#define STACK_SIZE_TESTC 0x8000


#define STACK_SIZE_TOTAL (STACK_SIZE_TESTA + \
						  STACK_SIZE_TESTB + \
						  STACK_SIZE_TESTC + \
                            STACK_SIZE_TTY + \
                            STACK_SIZE_SYS + \
                            STACK_SIZE_HD)