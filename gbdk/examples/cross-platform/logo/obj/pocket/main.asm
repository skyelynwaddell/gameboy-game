;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _fill_bkg_rect
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
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
;src/main.c:5: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:6: DISPLAY_OFF;
	call	_display_off
;src/main.c:7: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/main.c:17: set_native_tile_data(0, GBDK_2020_logo_TILE_COUNT, GBDK_2020_logo_tiles);
;../../../include/gb/gb.h:1836: set_bkg_data(first_tile, nb_tiles, data);
	ld	de, #_GBDK_2020_logo_tiles
	push	de
	ld	hl, #0x2700
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:48: GBDK_2020_logo_map);
;src/main.c:44: set_tile_map((DEVICE_SCREEN_WIDTH - (GBDK_2020_logo_WIDTH >> 3)) >> 1, 
	ld	de, #_GBDK_2020_logo_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:50: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:51: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:52: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
