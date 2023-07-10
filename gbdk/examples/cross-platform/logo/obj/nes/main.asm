;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module main
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
	.globl _fill_bkg_rect
	.globl _set_bkg_attributes
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _set_bkg_palette
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area ZP      (PAG)
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
;__1310720006              Allocated to registers 
;__1310720007              Allocated to registers 
;__1310720008              Allocated to registers 
;first_tile                Allocated to registers 
;nb_tiles                  Allocated to registers 
;data                      Allocated to registers 
;------------------------------------------------------------
;	src/main.c: 5: void main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/main.c: 6: DISPLAY_OFF;
	jsr	_display_off
;	src/main.c: 7: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x00
	stx	_fill_bkg_rect_PARM_5
	txa
	jsr	_fill_bkg_rect
;	src/main.c: 15: set_bkg_palette(0, GBDK_2020_logo_PALETTE_COUNT, GBDK_2020_logo_palettes);
	lda	#_GBDK_2020_logo_palettes
	sta	_set_bkg_palette_PARM_3
	lda	#>_GBDK_2020_logo_palettes
	sta	(_set_bkg_palette_PARM_3 + 1)
	lda	#0x00
	ldx	#0x03
	jsr	_set_bkg_palette
;	src/main.c: 17: set_native_tile_data(0, GBDK_2020_logo_TILE_COUNT, GBDK_2020_logo_tiles);
	lda	#_GBDK_2020_logo_tiles
	sta	_set_bkg_data_PARM_3
	lda	#>_GBDK_2020_logo_tiles
	sta	(_set_bkg_data_PARM_3 + 1)
;	../../../include/nes/nes.h: 877: set_bkg_data(first_tile, nb_tiles, data);
	lda	#0x00
	ldx	#0x28
	jsr	_set_bkg_data
;	src/main.c: 34: GBDK_2020_logo_map_attributes);
	lda	#_GBDK_2020_logo_map_attributes
	sta	_set_bkg_attributes_PARM_5
	lda	#>_GBDK_2020_logo_map_attributes
	sta	(_set_bkg_attributes_PARM_5 + 1)
	ldx	#0x0a
	stx	_set_bkg_attributes_PARM_3
	dex
	stx	_set_bkg_attributes_PARM_4
	lda	#0x03
	tax
	jsr	_set_bkg_attributes
;	src/main.c: 42: GBDK_2020_logo_map);
	lda	#_GBDK_2020_logo_map
	sta	_set_bkg_tiles_PARM_5
	lda	#>_GBDK_2020_logo_map
	sta	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#0x14
	stx	_set_bkg_tiles_PARM_3
	ldx	#0x12
	stx	_set_bkg_tiles_PARM_4
	lda	#0x06
	tax
	jsr	_set_bkg_tiles
;	src/main.c: 50: SHOW_BKG;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
;	src/main.c: 51: DISPLAY_ON;
	jsr	_display_on
00105$:
;	src/main.c: 52: }
	rts
	.area CODE
	.area RODATA
	.area XINIT
	.area CABS    (ABS)
