/*************************************************************************//**
 *****************************************************************************
 * @file   systask.c
 * @brief  
 * @author Forrest Y. Yu
 * @date   2007
 *****************************************************************************
 *****************************************************************************/

#include "type.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "mm/aspace.h"
#include "mm/frame_allocator.h"
#include "mm/page_table.h"
#include "global.h"
#include "keyboard.h"
#include "proto.h"


/*****************************************************************************
 *                                task_sys
 *****************************************************************************/
/**
 * <Ring 1> The main loop of TASK SYS.
 * 
 *****************************************************************************/
PUBLIC void task_sys()
{
	MESSAGE msg;
	while (1) {
		send_recv(RECEIVE, ANY, &msg);
        // printl("received quest from %d. ", msg.source);
		int src = msg.source;

		switch (msg.type) {
		case GET_TICKS:
			msg.RETVAL = ticks;
			send_recv(SEND, src, &msg);
            // printl("sended response to %d. ", src);
			break;
		default:
			panic("unknown msg type");
			break;
		}
	}
}
