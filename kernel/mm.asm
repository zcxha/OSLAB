SELECTOR_KERNEL_DS  equ 16		; 数据段选择子
PageDirBase			equ	200000h	; 页目录开始地址:		2M
PageTblBase			equ	201000h	; 页表开始地址:			2M + 4K
FreePageBase		equ 300000h ; 是物理页集合的基地址 3M，大小为4M(一个页是4k，1k个页)

;----------------------------------------------------------------------------
; 分页机制使用的常量说明
;----------------------------------------------------------------------------
PG_P		EQU	1	; 页存在属性位
PG_RWR		EQU	0	; R/W 属性位值, 读/执行
PG_RWW		EQU	2	; R/W 属性位值, 读/写/执行
PG_USS		EQU	0	; U/S 属性位值, 系统级
PG_USU		EQU	4	; U/S 属性位值, 用户级
;----------------------------------------------------------------------------


global VAToPA
global alloc_pages
global free_pages
global map
global unmap
global get_bitmap
global init_bitmap

[section .bss]
BitMap resb 128 ; 能分配的物理帧一共128 * 4K = 512K

[section .text]	; 以下为自实现内存管理
; (old define )
; 虚拟地址到物理地址函数
; 输入：eax - 32位虚拟地址 
; 输出: eax - 32位物理地址
; 出错，即指向的页不存在与物理内存中，则ebx置为1
;(new define)
; int VAToPA(u32 VA)
; 传入32位虚拟地址，返回物理地址
; 出错则返回-1
VAToPA:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8] ; va
	push ebx
	push esi

	
	mov esi, PageDirBase
	
	shr eax, 22
	mov ebx, 4
	mul ebx ; eax为页目录项的字节下标了
	
	add esi, eax
	
	mov ecx, [esi]
	
	mov edx,ecx
	and edx, 1
	cmp edx, 1
	jne .absent
	
	; 解析出页表基址
	and ecx,0fffff000h
	
	mov eax, [ebp + 8]
	shr eax, 12
	and eax, 03ffh
	mov ebx, 4
	mul ebx ; eax - 页表项的字节下标
	mov esi, ecx
	add esi, eax
	
	mov edx, [esi]
	
	mov ecx, edx
	and ecx, 1
	cmp ecx, 1
	jne .absent
	
	mov eax, [ebp + 8]
	and eax, 0fffh ; 低12位offset
	and edx, 0fffff000h
	add eax, edx
	
	jmp .present
	
	.absent:
	
	pop esi
	pop ebx
	pop ebp
	
	mov eax, -1
	ret
	.present:
	
	pop esi
	pop ebx
	pop ebp

	ret

;(old define)
; 位图法物理帧分配
; alloc_pages 输入分配帧数量，将物理页号（页基址）集合返回到es:edi
; 输入：eax - 需要分配的物理帧数量 
; es:edi 指向一个数据结构，存储物理页号集合（每个页号4字节，为了对齐）
; 返回：见函数描述 失败则ebx写1 成功则ebx为0
;(new define)
; int alloc_pages(u32 num, (u32 *)ptr)
; 输入要分配的物理帧数量，以及对应的帧的物理页号存储指针数组
; 失败返回-1，成功返回0
alloc_pages:
	push ebp
	mov ebp, esp

	mov edi, [ebp + 12] ; ptr
	mov eax, [ebp + 8] ; num
	
	push edi
	push esi
	push ebx

	cmp eax, 1024
	ja alloc_fail
	
	mov esi, BitMap
	mov ecx, eax
	cld
	alloc_readmap:
		mov al, [ds:esi]
		push eax
		mov bh, 0
		mov bl, 00000001b
		;.....内层循环
		a0:
		pop eax
		push eax
		; 对每一个位计算是否被占用
		cmp bh, 0
		je skpsft
		shl bl, 1
		skpsft:
		and al, bl
		
		cmp al, 1
		je a1
		; 计算这个空闲页的地址并存入es:edi
		pop eax
		or al, bl
		push eax
		
		; Byte index
		mov edx, esi
		sub edx, BitMap
		mov eax, edx
		; bit index
		mov edx, 8
		mul edx
		xor edx, edx
		mov dl, bh
		add eax, edx
		
		mov edx, 4096
		mul edx ; BASE + 4096 * 位下标
		add eax, FreePageBase
		
		stosd
		dec ecx
		cmp ecx, 0
		je inloopout
		
		a1:
		inc bh
		cmp bh, 8
		je inloopout
		jmp a0
		;.....内层循环
		inloopout:
		pop eax
		mov [ds:esi], al
		
		inc esi
		cmp esi, 128 ; 扫完bitmap还没出循环说明bitmap不够了那么fail
		je alloc_fail
		
		cmp ecx, 0
		je alloc_succ
		
		jmp alloc_readmap
	alloc_succ:
		mov eax, 0
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
	alloc_fail:
		mov eax, -1
		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
	
	
;(old define)
; free_pages
; 释放物理页帧，从ds:esi中读取物理页号（页基址）集合，eax为要释放的物理帧数
; 输入：eax - 要释放的物理页数量 ds:esi存放物理页号集合，对齐见alloc定义
; 返回：无
;(new define)
; void free_pages(u32 num, (u32 *)p)
; p为物理页号数组基地址，num为要释放的页数
free_pages:
	push ebx
	push edi
	push ebp
	push esi

	mov ebp, esp


	mov esi, [ebp + 24] ; p
	mov eax, [ebp + 20] ; num



	mov edi, BitMap
	mov ecx, eax
	
	freeloop:
		; xchg bx, bx
		lodsd
		sub eax, FreePageBase
		mov ebx, 4096 * 8 ;4096 * 0  4096 * 1 4096 * 2 4096 * 3 ... 
		xor edx, edx
		div ebx ; (eax) 在第几字节 (edx) 余数edx / 4096 的商表示在这个字节的第几位
		
		mov edi, BitMap
		add edi, eax
		
		mov eax, edx
		mov ebx, 4096
		xor edx, edx
		div ebx ; 注意余数总是0的，（在这里可以写一个判断，不对齐则异常什么的）
		mov dl, al ; 在第几位
		
		; get byte
		mov al, [edi]
		; gen mask
		m0:
		cmp dl, 0
		jne m1
		mov bl, 11111110b
		jmp maskend
		m1:
		cmp dl, 1
		jne m2
		mov bl, 11111101b
		jmp maskend
		m2:
		cmp dl, 2
		jne m3
		mov bl, 11111011b
		jmp maskend
		m3:
		cmp dl, 3
		jne m4
		mov bl, 11110111b
		jmp maskend
		m4:
		cmp dl, 4
		jne m5
		mov bl, 11101111b
		jmp maskend
		m5:
		cmp dl, 5
		jne m6
		mov bl, 11011111b
		jmp maskend
		m6:
		cmp dl, 6
		jne m7
		mov bl, 10111111b
		jmp maskend
		m7:
		mov bl, 01111111b
		maskend:
		; mask byte
		and al, bl
		; write byte
		mov [edi], al
		
		loop freeloop
	
	pop esi
	pop ebp
	pop edi
	pop ebx
	ret

;(old define)
; 页表映射到物理页帧。输入虚拟页地址，物理页地址。函数将进行虚拟-物理的页映射
; 输入： eax (va) 虚拟 页地址  ebx (pa) 物理 页基址
;(new define)
; void map(u32 va, u32 pa)
; 将va映射到pa
map:
	push ebp
	push ebx
	push esi
	mov ebp, esp

	mov ebx, [ebp + 20] ; pa
	mov eax, [ebp + 16] ; va
	


	shr eax, 22
	mov edx, 4096
	mul edx
	mov ecx, eax
	
	mov eax, [ebp + 16]
	shr eax, 12
	and eax, 03ffh
	mov edx, 4
	mul edx
	
	add eax, ecx
	add eax, PageTblBase
	
	mov esi, eax
	
	or ebx, PG_P | PG_RWW | PG_USU
	mov [esi], ebx
	
	pop esi
	pop ebx
	pop ebp

	ret

;(old define)
; 输入虚拟 页地址 。函数将进行unmap 假设ds指向了页表所在的段
;（对后续开发或许有用的提示）物理页可以放入swap区域，也可以free掉。但是这个函数只进行unmap
; 输入： eax (va) 虚拟 页地址
; 返回： ebx (pa) 经过unmap，取消映射后的物理页的基址。
;(new define)
; u32 unmap(u32 va)
; 输入va，输出unmap之后的pa
unmap:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8] ; va

	push esi

	shr eax, 22
	mov ebx, 4096
	mul ebx
	mov ecx, eax
	
	mov eax, [ebp + 8] ; va
	shr eax, 12
	and eax, 03ffh
	mov ebx, 4
	mul ebx
	
	add eax, ecx
	add eax, PageTblBase
	
	mov esi, eax
	mov eax, [esi]
	mov dword [esi], 0
	
	pop esi
	pop ebp
	ret

;(new)
; void get_bitmap(u32 *p)
; 获取整个bitmap，p指向一个4元素数组，这样一共就128位
get_bitmap:
	push edi
	push esi
	push ebp
	mov ebp, esp
	
	mov edi, [ebp + 16]; 数组起始字节的位置
	mov esi, BitMap ; BitMap起始字节位置

	mov ecx, 4
	.cp:
	mov eax, [esi]
	mov [edi], eax
	add esi, 4
	add edi, 4
	loop .cp

	pop ebp
	pop esi
	pop edi
	ret

;(new)
; void init_bitmap()
; 初始化128位bitmap为全0
init_bitmap:
	push edi
	mov edi, BitMap
	mov ecx, 128
	.lp:
	mov byte [edi], 0
	inc edi
	loop .lp

	pop edi
	ret