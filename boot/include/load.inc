
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                               load.inc
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                                                     Forrest Yu, 2005
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


BaseOfLoader		equ	 09000h	; LOADER.BIN 被加载到的位置 ----  段地址
OffsetOfLoader		equ	  0100h	; LOADER.BIN 被加载到的位置 ---- 偏移地址

BaseOfLoaderPhyAddr	equ	BaseOfLoader * 10h	; LOADER.BIN 被加载到的位置 ---- 物理地址 (= BaseOfLoader * 10h)


BaseOfKernelFile	equ	 08000h	; KERNEL.BIN 被加载到的位置 ----  段地址
OffsetOfKernelFile	equ	     0h	; KERNEL.BIN 被加载到的位置 ---- 偏移地址

BaseOfKernelFilePhyAddr	equ	BaseOfKernelFile * 10h
KernelEntryPointPhyAddr	equ	100400h	; 注意：1、必须与 MAKEFILE 中参数 -Ttext 的值相等!!
					;       2、这是个地址而非仅仅是个偏移，如果 -Ttext 的值为 0x400400，则它的值也应该是 0x400400。

PageDirBase		equ	20000000h	; 页目录开始地址:		512M
PageTblBase		equ	20001000h	; 页表开始地址:			512M + 4K


; FAT32 HDD boot
SUPER_BLK_SEG       equ 70h

; bochs:0x302800
; REAL: 0x304000
; ROOT DIR BASE LBA(sector) 注意，这里的LBA和地址，是相对于整个硬盘的LBA/地址，而不是相对于分区
ROOT_BASE_ADDR      equ 202800h+100000h ; 这里用加法，100000是DBR相对于整个硬盘的地址，4a9800是ROOTDIR相对于DBR的
ROOT_BASE           equ ROOT_BASE_ADDR / 512
