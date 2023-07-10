;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module testrand
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _waitpad
	.globl _arand
	.globl _initarand
	.globl _rand
	.globl _puts
	.globl _printf
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/testrand.c:14: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/testrand.c:16: while(TRUE) {
00103$:
;src/testrand.c:17: puts("press A...");
	ld	de, #___str_0
	call	_puts
;src/testrand.c:18: waitpad(J_A);
	ld	a, #0x10
	call	_waitpad
;src/testrand.c:19: initarand(sys_time);
	ld	hl, #_sys_time
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_initarand
	pop	hl
;src/testrand.c:20: for (uint8_t i = 0; i != 16; i++) 
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0x10
	jr	Z, 00103$
;src/testrand.c:21: printf("rand=%hx arand=%hx\n", (uint8_t)rand(), (uint8_t)arand());
	push	bc
	call	_arand
	pop	bc
	ld	d, #0x00
	push	bc
	push	de
	call	_rand
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	push	de
	push	hl
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #6
	pop	bc
;src/testrand.c:20: for (uint8_t i = 0; i != 16; i++) 
	inc	c
;src/testrand.c:23: }
	jr	00106$
___str_0:
	.ascii "press A..."
	.db 0x00
___str_1:
	.ascii "rand=%hx arand=%hx"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
