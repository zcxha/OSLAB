/*************************************************************************//**
 *****************************************************************************
 * @file   mm/main.c
 * @brief  Orange'S Memory Management.
 * @author Forrest Y. Yu
 * @date   Tue May  6 00:33:39 2008
 *****************************************************************************
 *****************************************************************************/

#include "type.h"
#include "config.h"
#include "stdio.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "fs.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "global.h"
#include "keyboard.h"
#include "proto.h"

PUBLIC void do_fork_test();

PRIVATE void init_mm();

struct mem_block {
	int base;
	int size;
	int pid;
};

#define NR_MEM_BLOCKS 64
PRIVATE struct mem_block mem_map[NR_MEM_BLOCKS];

/*****************************************************************************
 *                                task_mm
 *****************************************************************************/
/**
 * <Ring 1> The main loop of TASK MM.
 * 
 *****************************************************************************/
PUBLIC void task_mm()
{
	init_mm();

	while (1) {
		send_recv(RECEIVE, ANY, &mm_msg);
		int src = mm_msg.source;
		int reply = 1;

		int msgtype = mm_msg.type;

		switch (msgtype) {
		case FORK:
			mm_msg.RETVAL = do_fork();
			break;
		case EXIT:
			do_exit(mm_msg.STATUS);
			reply = 0;
			break;
		case EXEC:
			mm_msg.RETVAL = do_exec();
			break;
		case WAIT:
			do_wait();
			reply = 0;
			break;
		default:
			dump_msg("MM::unknown msg", &mm_msg);
			assert(0);
			break;
		}

		if (reply) {
			mm_msg.type = SYSCALL_RET;
			send_recv(SEND, src, &mm_msg);
		}
	}
}

/*****************************************************************************
 *                                init_mm
 *****************************************************************************/
/**
 * Do some initialization work.
 * 
 *****************************************************************************/
PRIVATE void init_mm()
{
	struct boot_params bp;
	get_boot_params(&bp);

	memory_size = bp.mem_size;

	/* print memory size */
	printl("{MM} memsize:%dMB\n", memory_size / (1024 * 1024));

	/* initialize memory map */
	int i;
	for (i = 0; i < NR_MEM_BLOCKS; i++) {
		mem_map[i].base = 0;
		mem_map[i].size = 0;
		mem_map[i].pid = -1;
	}
	mem_map[0].base = PROCS_BASE;
	mem_map[0].size = memory_size - PROCS_BASE;
}

/*****************************************************************************
 *                                alloc_mem
 *****************************************************************************/
/**
 * Allocate a memory block for a proc.
 * 
 * @param pid  Which proc the memory is for.
 * @param memsize  How many bytes is needed.
 * 
 * @return  The base of the memory just allocated.
 *****************************************************************************/
PUBLIC int alloc_mem(int pid, int memsize)
{
	assert(pid >= (NR_TASKS + NR_NATIVE_PROCS));
	
	int i;
	for (i = 0; i < NR_MEM_BLOCKS; i++) {
		if (mem_map[i].pid == -1 && mem_map[i].size >= memsize) {
			/* Found a free block large enough */
			int base = mem_map[i].base;
			
			/* If the block is significantly larger, split it */
			if (mem_map[i].size > memsize) {
				int j;
				for (j = 0; j < NR_MEM_BLOCKS; j++) {
					if (mem_map[j].size == 0 && mem_map[j].pid == -1) {
						mem_map[j].base = base + memsize;
						mem_map[j].size = mem_map[i].size - memsize;
						mem_map[j].pid = -1;
						break;
					}
				}
				/* If no empty slot in mem_map, we just use the whole block */
				if (j != NR_MEM_BLOCKS)
					mem_map[i].size = memsize;
			}
			
			mem_map[i].pid = pid;
			printl("{MM} alloc_mem: pid=%d, base=0x%x, size=0x%x\n", pid, base, memsize);
			return base;
		}
	}

	panic("memory allocation failed. pid:%d", pid);
	return -1;
}

/*****************************************************************************
 *                                free_mem
 *****************************************************************************/
/**
 * Free a memory block. 
 * 
 * @param pid  Whose memory is to be freed.
 * 
 * @return  Zero if success.
 *****************************************************************************/
PUBLIC int free_mem(int pid)
{
	int i;
	for (i = 0; i < NR_MEM_BLOCKS; i++) {
		if (mem_map[i].pid == pid) {
			printl("{MM} free_mem: pid=%d, base=0x%x, size=0x%x\n", pid, mem_map[i].base, mem_map[i].size);
			mem_map[i].pid = -1;
			
			/* Try to merge with adjacent free blocks */
			int j;
			for (j = 0; j < NR_MEM_BLOCKS; j++) {
				if (mem_map[j].pid == -1 && mem_map[j].size > 0) {
					/* check if j is right after i */
					if (mem_map[i].base + mem_map[i].size == mem_map[j].base) {
						mem_map[i].size += mem_map[j].size;
						mem_map[j].base = 0;
						mem_map[j].size = 0;
						/* restart merging from i */
						j = -1;
						continue;
					}
					/* check if i is right after j */
					if (mem_map[j].base + mem_map[j].size == mem_map[i].base) {
						mem_map[j].size += mem_map[i].size;
						mem_map[i].base = 0;
						mem_map[i].size = 0;
						/* i is now empty, j is the new block */
						i = j;
						/* restart merging from i */
						j = -1;
						continue;
					}
				}
			}
			return 0;
		}
	}

	return -1;
}
