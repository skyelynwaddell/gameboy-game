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
	.globl _gb_decompress
	.globl _set_tile_map_compat
	.globl _set_tile_2bpp_data
	.globl _wait_vbl_done
	.globl _buffer
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
_buffer::
	.ds 4096
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
;src/main.c:16: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:25: set_bkg_data(0, gb_decompress(monalisa_tiles_comp, buffer) >> 4, buffer);
	ld	de, #_buffer+0
	ld	c, e
	ld	b, d
	push	de
	ld	hl, #_monalisa_tiles_comp
	push	hl
	call	_gb_decompress
	ex	de, hl
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;../../../include/sms/sms.h:534: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	push	bc
	push	de
	ld	hl, #0x0000
	push	hl
	call	_set_tile_2bpp_data
;src/main.c:28: set_bkg_tiles(0,0, monalisa_mapWidth, monalisa_mapHeight, monalisa_mapPLN0);
	ld	hl, #_monalisa_mapPLN0
	push	hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x00
	push	hl
	call	_set_tile_map_compat
;src/main.c:32: while(1) {
00102$:
;src/main.c:37: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:39: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
