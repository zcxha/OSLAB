
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                              klib.asm
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                                                       Forrest Yu, 2005
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


; 导入全局变量
extern	DISP_POS

[SECTION .text]

; 导出函数
global console_putchar
global	disp_str
global	disp_color_str
global	out_byte
global	in_byte

;================================================================
;				  void putchar(char c, u8 color)
;================================================================
console_putchar:
	push ebp
	push edi
	mov ebp, esp

	mov al, [ebp + 12] ; c
	mov ah, [ebp + 16] ; color
	mov edi, [DISP_POS]

	test al, al
	jz .2
	cmp al, 0Ah
	jnz .3
	push eax
	mov eax, edi
	mov cl, 160
	div cl
	and eax, 0FFh
	inc eax
	mov cl, 160
	mul cl
	mov edi, eax
	pop eax
	jmp .2
	.3:
	mov [gs:edi], ax
	add edi, 2
	.2:
	mov [DISP_POS], edi

	pop edi
	pop ebp
	
	ret

; ========================================================================
;                  void out_byte(u16 port, u8 value);
; ========================================================================
out_byte:
	mov	edx, [esp + 4]		; port
	mov	al, [esp + 4 + 4]	; value
	out	dx, al
	nop	; 一点延迟
	nop
	ret

; ========================================================================
;                  u8 in_byte(u16 port);
; ========================================================================
in_byte:
	mov	edx, [esp + 4]		; port
	xor	eax, eax
	in	al, dx
	nop	; 一点延迟
	nop
	ret

