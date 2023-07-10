;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module fonts
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _font_color
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _get_mode
	.globl _mode
	.globl _puts
	.globl _printf
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
;src/fonts.c:17: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;src/fonts.c:23: font_init();
	call	_font_init
;src/fonts.c:26: ibm_font = font_load(font_ibm);  /* 96 tiles */
	ld	hl, #_font_ibm
	push	hl
	call	_font_load
	pop	af
	ex	(sp), hl
;src/fonts.c:27: italic_font = font_load(font_italic);   /* 93 tiles */
	ld	hl, #_font_italic
	push	hl
	call	_font_load
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
;src/fonts.c:30: font_color(WHITE, DKGREY);
	ld	hl, #0x103
	push	hl
	call	_font_color
;src/fonts.c:32: min_font = font_load(font_min);
	ld	hl, #_font_min
	ex	(sp),hl
	call	_font_load
	pop	af
	ld	-2 (ix), l
	ld	-1 (ix), h
;src/fonts.c:35: mode(get_mode() | M_NO_SCROLL);
	call	_get_mode
	ld	a, l
	set	2, a
	push	af
	inc	sp
	call	_mode
	inc	sp
;src/fonts.c:40: font_set(ibm_font);
	pop	hl
	push	hl
	push	hl
	call	_font_set
	pop	af
;src/fonts.c:43: printf("IBM Font #!?123\n");
	ld	hl, #___str_8
	call	_puts
;src/fonts.c:46: font_set(italic_font);
	pop	de
	pop	hl
	push	hl
	push	de
	push	hl
	call	_font_set
	pop	af
;src/fonts.c:47: for (i=1; i!=5; i++) {
	ld	bc, #0x0001
00102$:
;src/fonts.c:48: printf("In italics, line %u\n", i);
	push	bc
	push	bc
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	bc
;src/fonts.c:47: for (i=1; i!=5; i++) {
	inc	bc
	ld	a, c
	sub	a, #0x05
	or	a, b
	jr	NZ, 00102$
;src/fonts.c:52: font_set(min_font);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	call	_font_set
	pop	af
;src/fonts.c:53: printf("Minimal 36 tile font\n");
	ld	hl, #___str_6
	call	_puts
;src/fonts.c:56: font_set(ibm_font);
	pop	hl
	push	hl
	push	hl
	call	_font_set
;src/fonts.c:57: printf("\nDone!");
	ld	hl, #___str_7
	ex	(sp),hl
	call	_printf
;src/fonts.c:58: }
	ld	sp,ix
	pop	ix
	ret
___str_4:
	.ascii "In italics, line %u"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Minimal 36 tile font"
	.db 0x00
___str_7:
	.db 0x0a
	.ascii "Done!"
	.db 0x00
___str_8:
	.ascii "Font demo."
	.db 0x0a
	.db 0x0a
	.ascii "IBM Font #!?123"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
