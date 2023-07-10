;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module banks
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _bank_fixed
	.globl b_func_4
	.globl _func_4
	.globl b_func_3
	.globl _func_3
	.globl b_func_2
	.globl _func_2
	.globl b_func_1
	.globl _func_1
	.globl _puts
	.globl _printf
	.globl _SWITCH_ROM
	.globl _wait_vbl_done
	.globl _some_const_var_0
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_MEMORY_CTL	=	0x003e
_JOY_CTL	=	0x003f
_VCOUNTER	=	0x007e
_PSG	=	0x007f
_HCOUNTER	=	0x007f
_VDP_DATA	=	0x0098
_VDP_CMD	=	0x0099
_VDP_STATUS	=	0x0099
_JOY_PORT1	=	0x00dc
_JOY_PORT2	=	0x00dd
_FMADDRESS	=	0x00f0
_FMDATA	=	0x00f1
_AUDIOCTRL	=	0x00f2
_MAP_FRAME0	=	0x00fc
_MAP_FRAME1	=	0x00fd
_MAP_FRAME2	=	0x00fe
_MAP_FRAME3	=	0x00ff
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
;src/banks.c:17: void bank_fixed(void) NONBANKED
;	---------------------------------
; Function bank_fixed
; ---------------------------------
_bank_fixed::
;src/banks.c:19: puts("I'm in fixed ROM");
	ld	hl, #___str_0
;src/banks.c:20: }
	jp	_puts
_some_const_var_0:
	.db #0x00	; 0
___str_0:
	.ascii "I'm in fixed ROM"
	.db 0x00
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/banks.c:22: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/banks.c:29: printf("Program Start...\n\n");
	ld	hl, #___str_2
	call	_puts
;src/banks.c:32: bank_fixed();
	call	_bank_fixed
;src/banks.c:34: func_1();
	ld	e, #b_func_1
	ld	hl, #_func_1
	call	___sdcc_bcall_ehl
;src/banks.c:35: func_2();
	ld	e, #b_func_2
	ld	hl, #_func_2
	call	___sdcc_bcall_ehl
;src/banks.c:36: func_3();
	ld	e, #b_func_3
	ld	hl, #_func_3
	call	___sdcc_bcall_ehl
;src/banks.c:37: func_4();
	ld	e, #b_func_4
	ld	hl, #_func_4
	call	___sdcc_bcall_ehl
;src/banks.c:39: printf("\n");
	ld	hl, #___str_4
	call	_puts
;src/banks.c:43: printf("Const0= %u nonbanked\n", some_const_var_0);
	ld	a, (_some_const_var_0+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_5
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks.c:45: SWITCH_ROM(BANK(some_const_var_1));
	ld	l, #<(___bank_some_const_var_1)
;	spillPairReg hl
;	spillPairReg hl
	call	_SWITCH_ROM
;src/banks.c:46: printf("Const1= %u in bank %hu\n", some_const_var_1, BANK(some_const_var_1));
	ld	d, #<(___bank_some_const_var_1)
	ld	a, (_some_const_var_1+0)
	ld	c, a
	ld	b, #0x00
	push	de
	inc	sp
	push	bc
	ld	hl, #___str_6
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:47: SWITCH_ROM(BANK(some_const_var_2));
	ld	l, #<(___bank_some_const_var_2)
;	spillPairReg hl
;	spillPairReg hl
	call	_SWITCH_ROM
;src/banks.c:48: printf("Const2= %u in bank %hu\n", some_const_var_2, BANK(some_const_var_2));
	ld	d, #<(___bank_some_const_var_2)
	ld	a, (_some_const_var_2+0)
	ld	c, a
	ld	b, #0x00
	push	de
	inc	sp
	push	bc
	ld	hl, #___str_7
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:49: SWITCH_ROM(BANK(some_const_var_3));
	ld	l, #<(___bank_some_const_var_3)
;	spillPairReg hl
;	spillPairReg hl
	call	_SWITCH_ROM
;src/banks.c:50: printf("Const3= %u in bank %hu\n", some_const_var_3, BANK(some_const_var_3));
	ld	d, #<(___bank_some_const_var_3)
	ld	a, (_some_const_var_3+0)
	ld	c, a
	ld	b, #0x00
	push	de
	inc	sp
	push	bc
	ld	hl, #___str_8
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:56: _saved_bank = _current_bank;
	ld	a, (__current_bank+0)
	ld	-1 (ix), a
;src/banks.c:59: SWITCH_ROM(BANK(some_const_var_4));
	ld	de, #___bank_some_const_var_4+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	call	_SWITCH_ROM
;src/banks.c:60: printf("Const4= %u in bank %hu\n", some_const_var_4, BANK(some_const_var_4));
	ld	a, (_some_const_var_4+0)
	ld	c, a
	ld	b, #0x00
	ld	a, e
	push	af
	inc	sp
	push	bc
	ld	hl, #___str_9
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:63: SWITCH_ROM(_saved_bank);
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_SWITCH_ROM
;src/banks.c:68: puts("The End...");
	ld	hl, #___str_12
	call	_puts
;src/banks.c:71: while(1) {
00102$:
;src/banks.c:74: wait_vbl_done();
	call	_wait_vbl_done
	jr	00102$
;src/banks.c:76: }
	inc	sp
	pop	ix
	ret
___str_2:
	.ascii "Program Start..."
	.db 0x0a
	.db 0x00
___str_4:
	.db 0x00
___str_5:
	.ascii "Const0= %u nonbanked"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Const1= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_7:
	.ascii "Const2= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii "Const3= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_9:
	.ascii "Const4= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_12:
	.db 0x0a
	.ascii "The End..."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
