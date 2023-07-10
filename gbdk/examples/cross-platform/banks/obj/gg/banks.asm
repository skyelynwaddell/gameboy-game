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
	.globl _print_var
	.globl _bank_fixed
	.globl b_bank_3
	.globl _bank_3
	.globl b_bank_2
	.globl _bank_2
	.globl b_bank_1
	.globl _bank_1
	.globl _puts
	.globl _printf
	.globl _var_internal
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_MEMORY_CTL	=	0x003e
_JOY_CTL	=	0x003f
_VCOUNTER	=	0x007e
_PSG	=	0x007f
_HCOUNTER	=	0x007f
_VDP_DATA	=	0x00be
_VDP_CMD	=	0x00bf
_VDP_STATUS	=	0x00bf
_JOY_PORT1	=	0x00dc
_JOY_PORT2	=	0x00dd
_FMADDRESS	=	0x00f0
_FMDATA	=	0x00f1
_AUDIOCTRL	=	0x00f2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_RAM_CONTROL	=	0xfffc
_GLASSES_3D	=	0xfff8
_MAP_FRAME0	=	0xfffd
_MAP_FRAME1	=	0xfffe
_MAP_FRAME2	=	0xffff
_var_internal::
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
;src/banks.c:18: void bank_fixed(void) NONBANKED
;	---------------------------------
; Function bank_fixed
; ---------------------------------
_bank_fixed::
;src/banks.c:20: puts("I'm in fixed ROM");
	ld	hl, #___str_0
;src/banks.c:21: }
	jp	_puts
___str_0:
	.ascii "I'm in fixed ROM"
	.db 0x00
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/banks.c:23: void print_var(uint8_t bank)
;	---------------------------------
; Function print_var
; ---------------------------------
_print_var::
;src/banks.c:25: SWITCH_RAM(bank);
	bit	0,a
	jr	Z, 00103$
	ld	a, (_RAM_CONTROL+0)
	set	2, a
	jr	00104$
00103$:
	ld	a, (_RAM_CONTROL+0)
	res	2, a
00104$:
	ld	(_RAM_CONTROL+0), a
;src/banks.c:26: printf("Var_%u is %u\n");
	ld	hl, #___str_1
	push	hl
	call	_printf
	pop	af
;src/banks.c:27: }
	ret
___str_1:
	.ascii "Var_%u is %u"
	.db 0x0a
	.db 0x00
;src/banks.c:29: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/banks.c:31: puts("Program Start...");
	ld	hl, #___str_2
	call	_puts
;src/banks.c:33: ENABLE_RAM;
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x08
	ld	(_RAM_CONTROL+0), a
;src/banks.c:35: var_internal = 1;
	ld	hl, #0x0001
	ld	(_var_internal), hl
;src/banks.c:36: SWITCH_RAM(0);
	ld	a, (_RAM_CONTROL+0)
	and	a, #0xfb
	ld	(_RAM_CONTROL+0), a
;src/banks.c:37: var_0 = 2;
	ld	l, #0x02
	ld	(_var_0), hl
;src/banks.c:38: SWITCH_RAM(1);
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x04
	ld	(_RAM_CONTROL+0), a
;src/banks.c:39: var_1 = 3;
	ld	l, #0x03
	ld	(_var_1), hl
;src/banks.c:40: SWITCH_RAM(0);
	ld	a, (_RAM_CONTROL+0)
	and	a, #0xfb
	ld	(_RAM_CONTROL+0), a
;src/banks.c:41: var_2 = 4;
	ld	l, #0x04
	ld	(_var_2), hl
;src/banks.c:42: SWITCH_RAM(1);
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x04
	ld	(_RAM_CONTROL+0), a
;src/banks.c:43: var_3 = 5;
	ld	l, #0x05
	ld	(_var_3), hl
;src/banks.c:45: bank_fixed();
	call	_bank_fixed
;src/banks.c:46: bank_1();
	ld	e, #b_bank_1
	ld	hl, #_bank_1
	call	___sdcc_bcall_ehl
;src/banks.c:47: bank_2();
	ld	e, #b_bank_2
	ld	hl, #_bank_2
	call	___sdcc_bcall_ehl
;src/banks.c:48: bank_3();
	ld	e, #b_bank_3
	ld	hl, #_bank_3
	call	___sdcc_bcall_ehl
;src/banks.c:50: printf("Var is %u\n", var_internal);
	ld	hl, (_var_internal)
	push	hl
	ld	hl, #___str_3
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks.c:51: SWITCH_RAM(0);
	ld	a, (_RAM_CONTROL+0)
	and	a, #0xfb
	ld	(_RAM_CONTROL+0), a
;src/banks.c:52: printf("Var_0 is %u\n", var_0);
	ld	hl, (_var_0)
	push	hl
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks.c:53: SWITCH_RAM(1);
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x04
	ld	(_RAM_CONTROL+0), a
;src/banks.c:54: printf("Var_1 is %u\n", var_1);
	ld	hl, (_var_1)
	push	hl
	ld	hl, #___str_5
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks.c:55: SWITCH_RAM(0);
	ld	a, (_RAM_CONTROL+0)
	and	a, #0xfb
	ld	(_RAM_CONTROL+0), a
;src/banks.c:56: printf("Var_2 is %u\n", var_2);
	ld	hl, (_var_2)
	push	hl
	ld	hl, #___str_6
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks.c:57: SWITCH_RAM(1);
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x04
	ld	(_RAM_CONTROL+0), a
;src/banks.c:58: printf("Var_3 is %u\n", var_3);
	ld	hl, (_var_3)
	push	hl
	ld	hl, #___str_7
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks.c:60: puts("The End...");
	ld	hl, #___str_8
;src/banks.c:61: }
	jp	_puts
___str_2:
	.ascii "Program Start..."
	.db 0x00
___str_3:
	.ascii "Var is %u"
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "Var_0 is %u"
	.db 0x0a
	.db 0x00
___str_5:
	.ascii "Var_1 is %u"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Var_2 is %u"
	.db 0x0a
	.db 0x00
___str_7:
	.ascii "Var_3 is %u"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii "The End..."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
