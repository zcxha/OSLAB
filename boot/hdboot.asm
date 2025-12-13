; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                               hdboot.asm
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                                                     Forrest Yu, 2008
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

org  0x7c00			; bios always loads boot sector to 0000:7C00

	jmp	boot_start

%include		"load.inc"

STACK_BASE		equ	0x7C00	; base address of stack when booting
TRANS_SECT_NR		equ	2
SECT_BUF_SIZE		equ	TRANS_SECT_NR * 512

disk_address_packet:	db	0x10		; [ 0] Packet size in bytes.
			db	0		; [ 1] Reserved, must be 0.
			db	TRANS_SECT_NR	; [ 2] Nr of blocks to transfer.
			db	0		; [ 3] Reserved, must be 0.
			dw	0		; [ 4] Addr of transfer - Offset
			dw	SUPER_BLK_SEG	; [ 6] buffer.          - Seg
			dd	0		; [ 8] LBA. Low  32-bits.
			dd	0		; [12] LBA. High 32-bits.

	
err:
	mov	dh, 3			; "Error 0  "
	call	disp_str		; display the string
	jmp	$

boot_start:
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	ss, ax
	mov	sp, STACK_BASE

	call	clear_screen

	mov	dh, 0			; "Booting  "
	call	disp_str		; display the string

    ; 假设根目录占8sector
    mov ecx, 4
    xchg bx, bx
    mov	dword [disk_address_packet +  8], ROOT_BASE
    .getent:
    xor esi, esi
	call	read_sector
	mov	ax, SUPER_BLK_SEG
	mov	fs, ax
    cmp word [fs: 0], 0
    je err
    mov edi, 0
    .inner:
    mov esi, LoaderFileName
    cld
    lodsd
    cmp eax, [fs:edi]
    jne .innerloop
    cld
    lodsd
    cmp eax, [fs:(edi+4)]
    jne .innerloop
    cld
    lodsd
    cmp eax, [fs:(edi + 8)]
    jne .innerloop

    jmp .succ
    .innerloop:
    add edi, 0x20
    cmp edi, 0x400
    jge .outerloop
    jmp .inner

    .outerloop:
    add dword [disk_address_packet + 8], TRANS_SECT_NR
    dec ecx
    cmp ecx, 0
    jg .getent; while ecx > 0

    ; 查找完根目录还没找到说明找失败了。
    .fail:
    mov dh, 2
    call    disp_str

    jmp $

    ; fs:edi 指向目录项 [0x14-0x15] [0x1a-0x1b]
    ;[1c~1f] byte len
    .succ:
    ; mov dx, fs:[edi+0x14] 假定loader在低16位的簇块中
    xor eax, eax
    xor edx, edx
    mov ax, [fs:(edi+0x1a)]; 获取目录项指向数据cluster地址
    sub ax, 2
    mov ecx, 8
    mul ecx
    xchg bx, bx
    add eax, ROOT_BASE
    ; 此时eax为loader的数据地址lba(sector)
    push eax

    ; 加载文件长度
    mov eax, [fs:(edi+0x1c)]

    ; 计算读多少次
    mov ebx, SECT_BUF_SIZE
    div ebx
    cmp edx, 0
    je .noadd
    inc eax
    .noadd:
    mov word [disk_address_packet + 4], OffsetOfLoader
    mov word [disk_address_packet + 6], BaseOfLoader
    mov ecx, eax
    pop eax
    mov dword [disk_address_packet + 8], eax
    .rdld:
    call read_sector
    add word [disk_address_packet + 4], SECT_BUF_SIZE
    add dword [disk_address_packet + 8], TRANS_SECT_NR
    loop .rdld
    
    mov dh, 1
    call disp_str
    xchg bx, bx
    jmp BaseOfLoader:OffsetOfLoader

    jmp $

;============================================================================
;字符串
;----------------------------------------------------------------------------
LoaderFileName		db	"HDLDR   BIN", 0x20	; 目录项前12字节
; 为简化代码, 下面每个字符串的长度均为 MessageLength
MessageLength		equ	9
BootMessage:		db	"Booting  "; 9字节, 不够则用空格补齐. 序号 0
Message1		db	"HD Boot  "; 9字节, 不够则用空格补齐. 序号 1
Message2		db	"No LOADER"; 9字节, 不够则用空格补齐. 序号 2
Message3		db	"Error 0  "; 9字节, 不够则用空格补齐. 序号 3
;============================================================================

clear_screen:
	mov	ax, 0x600		; AH = 6,  AL = 0
	mov	bx, 0x700		; 黑底白字(BL = 0x7)
	mov	cx, 0			; 左上角: (0, 0)
	mov	dx, 0x184f		; 右下角: (80, 50)
	int	0x10			; int 0x10
	ret

;----------------------------------------------------------------------------
; 函数名: disp_str
;----------------------------------------------------------------------------
; 作用:
;	显示一个字符串, 函数开始时 dh 中应该是字符串序号(0-based)
disp_str:
	mov	ax, MessageLength
	mul	dh
	add	ax, BootMessage
	mov	bp, ax			; ┓
	mov	ax, ds			; ┣ ES:BP = 串地址
	mov	es, ax			; ┛
	mov	cx, MessageLength	; CX = 串长度
	mov	ax, 0x1301		; AH = 0x13,  AL = 0x1
	mov	bx, 0x7			; 页号为0(BH = 0) 黑底白字(BL = 0x7)
	mov	dl, 0
	int	0x10			; int 0x10
	ret

;----------------------------------------------------------------------------
; read_sector
;----------------------------------------------------------------------------
; Entry:
;     - fields disk_address_packet should have been filled
;       before invoking the routine
; Exit:
;     - es:bx -> data read
; registers changed:
;     - eax, ebx, dl, si, es
read_sector:
	xor	ebx, ebx

	mov	ah, 0x42
	mov	dl, 0x80
	mov	si, disk_address_packet
	int	0x13
	mov	ax, [disk_address_packet + 6]
	mov	es, ax
	mov	bx, [disk_address_packet + 4]

	ret

times 	510-($-$$) db 0 ; 填充剩下的空间，使生成的二进制代码恰好为512字节
dw 	0xaa55		; 结束标志
