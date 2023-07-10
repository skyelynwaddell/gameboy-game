;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _fill_rect_compat
	.globl _set_tile_map
	.globl _set_native_tile_data
	.globl _set_palette
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
;src/main.c:5: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;../../../include/sms/sms.h:222: __WRITE_VDP_REG(VDP_R1, __READ_VDP_REG(VDP_R1) &= (~R1_DISP_ON));
	ld	a, (_shadow_VDP_R1+0)
	and	a, #0xbf
	ld	(_shadow_VDP_R1+0), a
	ld	a,i
	di
	push	af
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00105$
	ei
00105$:
;src/main.c:7: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x1820
	push	hl
	ld	hl, #0x00
	push	hl
	call	_fill_rect_compat
;src/main.c:9: set_palette(0, GBDK_2020_logo_PALETTE_COUNT, GBDK_2020_logo_palettes);
	ld	hl, #_GBDK_2020_logo_palettes
	push	hl
	ld	hl, #0x100
	push	hl
	call	_set_palette
;src/main.c:17: set_native_tile_data(0, GBDK_2020_logo_TILE_COUNT, GBDK_2020_logo_tiles);
	ld	hl, #_GBDK_2020_logo_tiles
	push	hl
	ld	hl, #0x0029
	push	hl
	ld	l, h
	push	hl
	call	_set_native_tile_data
;src/main.c:48: GBDK_2020_logo_map);
;src/main.c:44: set_tile_map((DEVICE_SCREEN_WIDTH - (GBDK_2020_logo_WIDTH >> 3)) >> 1, 
	ld	hl, #_GBDK_2020_logo_map
	push	hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x306
	push	hl
	call	_set_tile_map
;src/main.c:51: DISPLAY_ON;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x40
	ld	(_shadow_VDP_R1+0), a
	ld	a,i
	di
	push	af
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	pop	af
	ret	PO
	ei
;src/main.c:52: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
