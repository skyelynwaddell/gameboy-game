;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module fonts
	.optsdcc -msm83
	
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
;src/fonts.c:17: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-6
;src/fonts.c:23: font_init();
	call	_font_init
;src/fonts.c:26: ibm_font = font_load(font_ibm);  /* 96 tiles */
	ld	de, #_font_ibm
	push	de
	call	_font_load
	add	sp, #4
	push	de
;src/fonts.c:27: italic_font = font_load(font_italic);   /* 93 tiles */
	ld	de, #_font_italic
	push	de
	call	_font_load
	pop	hl
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/fonts.c:30: font_color(WHITE, DKGREY);
	ld	hl, #0x103
	push	hl
	call	_font_color
	pop	hl
;src/fonts.c:32: min_font = font_load(font_min);
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/fonts.c:35: mode(get_mode() | M_NO_SCROLL);
	call	_get_mode
	ld	a, e
	set	2, a
	push	af
	inc	sp
	call	_mode
	inc	sp
;src/fonts.c:40: font_set(ibm_font);
	pop	de
	push	de
	push	de
	call	_font_set
	pop	hl
;src/fonts.c:43: printf("IBM Font #!?123\n");
	ld	de, #___str_8
	call	_puts
;src/fonts.c:46: font_set(italic_font);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_font_set
	pop	hl
;src/fonts.c:47: for (i=1; i!=5; i++) {
	ld	bc, #0x0001
00102$:
;src/fonts.c:48: printf("In italics, line %u\n", i);
	push	bc
	push	bc
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
	pop	bc
;src/fonts.c:47: for (i=1; i!=5; i++) {
	inc	bc
	ld	a, c
	sub	a, #0x05
	or	a, b
	jr	NZ, 00102$
;src/fonts.c:52: font_set(min_font);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_font_set
	pop	hl
;src/fonts.c:53: printf("Minimal 36 tile font\n");
	ld	de, #___str_6
	call	_puts
;src/fonts.c:56: font_set(ibm_font);
	pop	de
	push	de
	push	de
	call	_font_set
	pop	hl
;src/fonts.c:57: printf("\nDone!");
	ld	de, #___str_7
	push	de
	call	_printf
	pop	hl
;src/fonts.c:58: }
	add	sp, #6
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
