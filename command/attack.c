#include "type.h"
#include "stdio.h"

int main(int argc, char * argv[])
{
	printf("Attack Simulation Started.\n");
	printf("I am a benign process, but the Kernel is rigged to flag me as malicious.\n");
	printf("Watch the log for Red Warnings!\n");
	
	while(1) {
		/* Infinite loop to keep process alive for Dynamic Check */
	}
	return 0;
}
