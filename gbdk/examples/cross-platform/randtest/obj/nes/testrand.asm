;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module testrand
	.optsdcc -mmos6502
	
	.globl __TEMP
	.globl __DPTR
	.area ZP      (PAG)
__TEMP:	.ds 8
__DPTR:	.ds 2
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
; ZP ram data
;--------------------------------------------------------
	.area ZP      (PAG)
_main_sloc0_1_0:
	.ds 1
_main_sloc1_1_0:
	.ds 2
_main_sloc2_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
;--------------------------------------------------------
; uninitialized external ram data
;--------------------------------------------------------
	.area BSS
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _CODE
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _CODE
	.area _CODE
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;sloc2                     Allocated with name '_main_sloc2_1_0'
;i                         Allocated to registers 
;------------------------------------------------------------
;	src/testrand.c: 14: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/testrand.c: 16: while(TRUE) {
00103$:
;	src/testrand.c: 17: puts("press A...");
	ldx	#>___str_0
	lda	#___str_0
	jsr	_puts
;	src/testrand.c: 18: waitpad(J_A);
	lda	#0x01
	jsr	_waitpad
;	src/testrand.c: 19: initarand(sys_time);
	lda	_sys_time
	ldx	(_sys_time + 1)
	jsr	_initarand
;	src/testrand.c: 20: for (uint8_t i = 0; i != 16; i++) 
	ldx	#0x00
	stx	*_main_sloc0_1_0
00106$:
	lda	*_main_sloc0_1_0
	cmp	#0x10
	bne	00122$
	jmp	00103$
00122$:
;	src/testrand.c: 21: printf("rand=%hx arand=%hx\n", (uint8_t)rand(), (uint8_t)arand());
	jsr	_arand
	sta	*_main_sloc1_1_0
	ldx	#0x00
	stx	*(_main_sloc1_1_0 + 1)
	jsr	_rand
	sta	*_main_sloc2_1_0
	ldx	#0x00
	stx	*(_main_sloc2_1_0 + 1)
	lda	*(_main_sloc1_1_0 + 1)
	pha
	lda	*_main_sloc1_1_0
	pha
	lda	*(_main_sloc2_1_0 + 1)
	pha
	lda	*_main_sloc2_1_0
	pha
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	pla
	pla
	pla
	pla
	lda	*(__TEMP+0)
;	src/testrand.c: 20: for (uint8_t i = 0; i != 16; i++) 
	inc	*_main_sloc0_1_0
	jmp	00106$
00108$:
;	src/testrand.c: 23: }
	rts
	.area CODE
	.area RODATA
	.area RODATA
___str_0:
	.ascii "press A..."
	.db 0x00
	.area CODE
	.area RODATA
___str_1:
	.ascii "rand=%hx arand=%hx"
	.db 0x0a
	.db 0x00
	.area CODE
	.area XINIT
	.area CABS    (ABS)
