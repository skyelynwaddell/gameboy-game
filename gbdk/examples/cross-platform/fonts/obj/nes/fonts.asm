;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module fonts
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
	.globl _font_color
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _get_mode
	.globl _mode
	.globl _printf
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area ZP      (PAG)
_main_sloc0_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
;--------------------------------------------------------
; uninitialized external ram data
;--------------------------------------------------------
	.area BSS
_main_ibm_font_65536_74:
	.ds 2
_main_italic_font_65536_74:
	.ds 2
_main_min_font_65536_74:
	.ds 2
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
;ibm_font                  Allocated with name '_main_ibm_font_65536_74'
;italic_font               Allocated with name '_main_italic_font_65536_74'
;min_font                  Allocated with name '_main_min_font_65536_74'
;i                         Allocated to registers 
;------------------------------------------------------------
;	src/fonts.c: 17: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/fonts.c: 23: font_init();
	jsr	_font_init
;	src/fonts.c: 26: ibm_font = font_load(font_ibm);  /* 96 tiles */
	ldx	#>_font_ibm
	lda	#_font_ibm
	jsr	_font_load
	sta	_main_ibm_font_65536_74
	stx	(_main_ibm_font_65536_74 + 1)
;	src/fonts.c: 27: italic_font = font_load(font_italic);   /* 93 tiles */
	ldx	#>_font_italic
	lda	#_font_italic
	jsr	_font_load
	sta	_main_italic_font_65536_74
	stx	(_main_italic_font_65536_74 + 1)
;	src/fonts.c: 30: font_color(WHITE, DKGREY);
	lda	#0x03
	ldx	#0x01
	jsr	_font_color
;	src/fonts.c: 32: min_font = font_load(font_min);
	ldx	#>_font_min
	lda	#_font_min
	jsr	_font_load
	sta	_main_min_font_65536_74
	stx	(_main_min_font_65536_74 + 1)
;	src/fonts.c: 35: mode(get_mode() | M_NO_SCROLL);
	jsr	_get_mode
	ora	#0x04
	jsr	_mode
;	src/fonts.c: 40: font_set(ibm_font);
	ldx	(_main_ibm_font_65536_74 + 1)
	lda	_main_ibm_font_65536_74
	jsr	_font_set
;	src/fonts.c: 41: printf("Font demo.\n\n");
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	lda	*(__TEMP+0)
;	src/fonts.c: 43: printf("IBM Font #!?123\n");
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	lda	*(__TEMP+0)
;	src/fonts.c: 46: font_set(italic_font);
	ldx	(_main_italic_font_65536_74 + 1)
	lda	_main_italic_font_65536_74
	jsr	_font_set
;	src/fonts.c: 47: for (i=1; i!=5; i++) {
	ldx	#0x01
	stx	*_main_sloc0_1_0
	dex
	stx	*(_main_sloc0_1_0 + 1)
00102$:
;	src/fonts.c: 48: printf("In italics, line %u\n", i);
	lda	*(_main_sloc0_1_0 + 1)
	pha
	lda	*_main_sloc0_1_0
	pha
	lda	#>___str_2
	pha
	lda	#___str_2
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	pla
	pla
	lda	*(__TEMP+0)
;	src/fonts.c: 47: for (i=1; i!=5; i++) {
	inc	*_main_sloc0_1_0
	bne	00115$
	inc	*(_main_sloc0_1_0 + 1)
00115$:
	lda	*_main_sloc0_1_0
	cmp	#0x05
	beq	00116$
	jmp	00117$
00116$:
	lda	*(_main_sloc0_1_0 + 1)
	cmp	#0x00
	beq	00118$
00117$:
	jmp	00102$
00118$:
;	src/fonts.c: 52: font_set(min_font);
	ldx	(_main_min_font_65536_74 + 1)
	lda	_main_min_font_65536_74
	jsr	_font_set
;	src/fonts.c: 53: printf("Minimal 36 tile font\n");
	lda	#>___str_3
	pha
	lda	#___str_3
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	lda	*(__TEMP+0)
;	src/fonts.c: 56: font_set(ibm_font);
	ldx	(_main_ibm_font_65536_74 + 1)
	lda	_main_ibm_font_65536_74
	jsr	_font_set
;	src/fonts.c: 57: printf("\nDone!");
	lda	#>___str_4
	pha
	lda	#___str_4
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	lda	*(__TEMP+0)
00104$:
;	src/fonts.c: 58: }
	rts
	.area CODE
	.area RODATA
	.area RODATA
___str_0:
	.ascii "Font demo."
	.db 0x0a
	.db 0x0a
	.db 0x00
	.area CODE
	.area RODATA
___str_1:
	.ascii "IBM Font #!?123"
	.db 0x0a
	.db 0x00
	.area CODE
	.area RODATA
___str_2:
	.ascii "In italics, line %u"
	.db 0x0a
	.db 0x00
	.area CODE
	.area RODATA
___str_3:
	.ascii "Minimal 36 tile font"
	.db 0x0a
	.db 0x00
	.area CODE
	.area RODATA
___str_4:
	.db 0x0a
	.ascii "Done!"
	.db 0x00
	.area CODE
	.area XINIT
	.area CABS    (ABS)
