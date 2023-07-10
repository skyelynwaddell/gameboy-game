;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module test
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _printf
	.globl _b
	.globl _a
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
_a::
	.ds 2
_b::
	.ds 2
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
;test.c:6: void main(int argc, char * argv[]) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
	inc	sp
	inc	sp
	push	de
;test.c:7: printf("Hello, world!\r\nargc: %d\r\n", argc);
	push	bc
	push	bc
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	bc
;test.c:9: for (int i = 0; i != argc; i++) 
	ld	de, #0x0000
00103$:
	ld	l, e
	ld	h, d
	cp	a, a
	sbc	hl, bc
	jr	Z, 00101$
;test.c:10: printf("argv%d = '%s'\r\n", i, argv[i]);
	ld	l, e
	ld	h, d
	add	hl, hl
	ld	a, l
	add	a, -2 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -1 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	push	bc
	push	de
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	de
	ld	hl, #___str_1
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	af
	pop	de
	pop	bc
;test.c:9: for (int i = 0; i != argc; i++) 
	inc	de
	jr	00103$
00101$:
;test.c:12: printf("a = %d b = %d\r\n&a == 0x%x", a, b, &a);
	ld	hl, #_a
	push	hl
	ld	hl, (_b)
	push	hl
	ld	hl, (_a)
	push	hl
	ld	hl, #___str_2
	push	hl
	call	_printf
;test.c:13: }
	ld	sp,ix
	pop	ix
	ret
___str_0:
	.ascii "Hello, world!"
	.db 0x0d
	.db 0x0a
	.ascii "argc: %d"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "argv%d = '%s'"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "a = %d b = %d"
	.db 0x0d
	.db 0x0a
	.ascii "&a == 0x%x"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__a:
	.dw #0x0064
__xinit__b:
	.dw #0x00c8
	.area _CABS (ABS)
