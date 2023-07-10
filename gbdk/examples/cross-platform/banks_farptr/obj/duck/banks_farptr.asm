;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module banks_farptr
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _run
	.globl b_some_bank2_proc1
	.globl _some_bank2_proc1
	.globl b_some_bank2_proc0
	.globl _some_bank2_proc0
	.globl _to_far_ptr
	.globl ___call__banked
	.globl _printf
	.globl _res
	.globl _farptr_var2
	.globl _farptr_var1
	.globl _farptr_var0
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_farptr_var0::
	.ds 4
_farptr_var1::
	.ds 4
_farptr_var2::
	.ds 4
_res::
	.ds 2
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
;src/banks_farptr.c:20: void run() {
;	---------------------------------
; Function run
; ---------------------------------
_run::
;src/banks_farptr.c:22: farptr_var0 = to_far_ptr(some_bank2_proc1, BANK(some_bank2_proc1));
	ld	e, #<(___bank_some_bank2_proc1)
	ld	d, #0x00
	ld	bc, #_some_bank2_proc1
	push	de
	push	bc
	call	_to_far_ptr
	add	sp, #4
	ld	c, l
	ld	b, h
	ld	hl, #_farptr_var0
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/banks_farptr.c:23: farptr_var1 = to_far_ptr(some_bank2_proc1, BANK(some_bank2_proc1));
	ld	e, #<(___bank_some_bank2_proc1)
	ld	d, #0x00
	ld	bc, #_some_bank2_proc1
	push	de
	push	bc
	call	_to_far_ptr
	add	sp, #4
	ld	c, l
	ld	b, h
	ld	hl, #_farptr_var1
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/banks_farptr.c:24: farptr_var2 = to_far_ptr(some_bank2_proc0, BANK(some_bank2_proc0));
	ld	e, #<(___bank_some_bank2_proc0)
	ld	d, #0x00
	ld	bc, #_some_bank2_proc0
	push	de
	push	bc
	call	_to_far_ptr
	add	sp, #4
	ld	c, l
	ld	b, h
	ld	hl, #_farptr_var2
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/banks_farptr.c:27: printf("FAR PTR0: %x:%x\n", (int)FAR_SEG(farptr_var0), (int)FAR_OFS(farptr_var0));
	ld	hl, #_farptr_var0
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_farptr_var0 + 2
	ld	a, (hl+)
	ld	l, (hl)
;	spillPairReg hl
	ld	e, a
	ld	d, l
	push	bc
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #6
;src/banks_farptr.c:28: printf("FAR PTR1: %x:%x\n", (int)FAR_SEG(farptr_var1), (int)FAR_OFS(farptr_var1));
	ld	hl, #_farptr_var1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_farptr_var1 + 2
	ld	a, (hl+)
	ld	l, (hl)
;	spillPairReg hl
	ld	e, a
	ld	d, l
	push	bc
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #6
;src/banks_farptr.c:31: FAR_CALL(farptr_var2, void (*)(void));
	ld	hl, #_farptr_var2
	ld	d, h
	ld	e, l
	ld	hl, #___call_banked_ptr
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl), a
	call	___call__banked
;src/banks_farptr.c:34: res = some_bank2_proc1(100, 50);
	ld	de, #0x0032
	push	de
	ld	de, #0x0064
	push	de
	ld	e, #b_some_bank2_proc1
	ld	hl, #_some_bank2_proc1
	call	___sdcc_bcall_ehl
	add	sp, #4
	ld	hl, #_res
	ld	a, c
	ld	(hl+), a
;src/banks_farptr.c:35: printf("CALL DIR: %d\n", res);
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:38: res = FAR_CALL(farptr_var1, some_bank2_proc_t, 100, 50);
	ld	hl, #_farptr_var1
	ld	d, h
	ld	e, l
	ld	hl, #___call_banked_ptr
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #___call__banked
	ld	de, #0x0032
	push	de
	ld	de, #0x0064
	push	de
	call	___sdcc_call_hl
	add	sp, #4
	ld	hl, #_res
	ld	a, c
	ld	(hl+), a
;src/banks_farptr.c:40: printf("CALL IND: %d\n", res);
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:41: }
	ret
___str_0:
	.ascii "FAR PTR0: %x:%x"
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "FAR PTR1: %x:%x"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "CALL DIR: %d"
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "CALL IND: %d"
	.db 0x0a
	.db 0x00
;src/banks_farptr.c:43: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/banks_farptr.c:44: ENABLE_RAM;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/banks_farptr.c:45: printf("START (bank=%d)\n", (int)CURRENT_BANK);
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:46: run();
	call	_run
;src/banks_farptr.c:47: printf("DONE! (bank=%d)\n", (int)CURRENT_BANK);
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:48: }
	ret
___str_4:
	.ascii "START (bank=%d)"
	.db 0x0a
	.db 0x00
___str_5:
	.ascii "DONE! (bank=%d)"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
