;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module bank2code
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_some_bank2_proc1
	.globl _some_bank2_proc1
	.globl b___func_some_bank2_proc1
	.globl ___func_some_bank2_proc1
	.globl b_some_bank2_proc0
	.globl _some_bank2_proc0
	.globl b___func_some_bank2_proc0
	.globl ___func_some_bank2_proc0
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
	.area _CODE_2
;src/bank2code.c:7: static int local_bank2_proc(int param1, int param2) {
;	---------------------------------
; Function local_bank2_proc
; ---------------------------------
_local_bank2_proc:
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
;src/bank2code.c:8: printf("  sum: %d (bank=%d)\n", param1 + param2, (int)CURRENT_BANK);
	ldh	a, (__current_bank + 0)
	ld	e, a
	ld	d, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	push	bc
	push	de
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #6
	pop	bc
;src/bank2code.c:9: return (param1 + param2) << 1;
	sla	c
	rl	b
;src/bank2code.c:10: }
	ret
___str_0:
	.ascii "  sum: %d (bank=%d)"
	.db 0x0a
	.db 0x00
;src/bank2code.c:12: BANKREF(some_bank2_proc0)
;	---------------------------------
; Function __func_some_bank2_proc0
; ---------------------------------
	b___func_some_bank2_proc0	= 2
___func_some_bank2_proc0::
	.local b___func_some_bank2_proc0 
	___bank_some_bank2_proc0 = b___func_some_bank2_proc0 
	.globl ___bank_some_bank2_proc0 
;src/bank2code.c:13: void some_bank2_proc0() __banked {
;	---------------------------------
; Function some_bank2_proc0
; ---------------------------------
	b_some_bank2_proc0	= 2
_some_bank2_proc0::
;src/bank2code.c:14: printf("some_bank2_proc0\n");
	ld	de, #___str_2
;src/bank2code.c:15: }
	jp	_puts
___str_2:
	.ascii "some_bank2_proc0"
	.db 0x00
;src/bank2code.c:17: BANKREF(some_bank2_proc1)
;	---------------------------------
; Function __func_some_bank2_proc1
; ---------------------------------
	b___func_some_bank2_proc1	= 2
___func_some_bank2_proc1::
	.local b___func_some_bank2_proc1 
	___bank_some_bank2_proc1 = b___func_some_bank2_proc1 
	.globl ___bank_some_bank2_proc1 
;src/bank2code.c:18: int some_bank2_proc1(int param1, int param2) __banked {
;	---------------------------------
; Function some_bank2_proc1
; ---------------------------------
	b_some_bank2_proc1	= 2
_some_bank2_proc1::
;src/bank2code.c:19: printf("some_bank2_proc1\n");
	ld	de, #___str_4
	call	_puts
;src/bank2code.c:20: return local_bank2_proc(param1, param2);
	ldhl	sp,	#8
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#6
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;src/bank2code.c:21: }
	jp	_local_bank2_proc
___str_4:
	.ascii "some_bank2_proc1"
	.db 0x00
	.area _CODE_2
	.area _INITIALIZER
	.area _CABS (ABS)
