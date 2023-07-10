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
	.globl _init_gfx
	.globl b___func_blank_tile_data
	.globl ___func_blank_tile_data
	.globl b___func_logo_map
	.globl ___func_logo_map
	.globl b___func_logo_tiles_data
	.globl ___func_logo_tiles_data
	.globl _fill_rect_compat
	.globl _set_tile_map_compat
	.globl _set_tile_2bpp_data
	.globl _wait_vbl_done
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
;src/main.c:6: INCBIN(logo_tiles_data, "res/gbdk2020.bin") // Variable name to use, Path to file
;	---------------------------------
; Function __func_logo_tiles_data
; ---------------------------------
	b___func_logo_tiles_data	= 0
___func_logo_tiles_data::
_logo_tiles_data::
1$:
	.incbin "res/gbdk2020.bin" 
2$:
	___size_logo_tiles_data = (2$-1$) 
	.globl ___size_logo_tiles_data 
	.local b___func_logo_tiles_data 
	___bank_logo_tiles_data = b___func_logo_tiles_data 
	.globl ___bank_logo_tiles_data 
;src/main.c:9: INCBIN(logo_map, "res/gbdk2020_map.bin")
;	---------------------------------
; Function __func_logo_map
; ---------------------------------
	b___func_logo_map	= 0
___func_logo_map::
_logo_map::
1$:
	.incbin "res/gbdk2020_map.bin" 
2$:
	___size_logo_map = (2$-1$) 
	.globl ___size_logo_map 
	.local b___func_logo_map 
	___bank_logo_map = b___func_logo_map 
	.globl ___bank_logo_map 
;src/main.c:12: INCBIN(blank_tile_data, "res/blanktile.bin")
;	---------------------------------
; Function __func_blank_tile_data
; ---------------------------------
	b___func_blank_tile_data	= 0
___func_blank_tile_data::
_blank_tile_data::
1$:
	.incbin "res/blanktile.bin" 
2$:
	___size_blank_tile_data = (2$-1$) 
	.globl ___size_blank_tile_data 
	.local b___func_blank_tile_data 
	___bank_blank_tile_data = b___func_blank_tile_data 
	.globl ___bank_blank_tile_data 
;src/main.c:28: void init_gfx() {
;	---------------------------------
; Function init_gfx
; ---------------------------------
_init_gfx::
;src/main.c:30: set_bkg_data(0x80u, 1u, blank_tile_data); // The first 0x80u here is the tile ID
;../../../include/sms/sms.h:534: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_blank_tile_data
	push	hl
	ld	hl, #0x0001
	push	hl
	ld	l, #0x80
	push	hl
	call	_set_tile_2bpp_data
;src/main.c:31: fill_bkg_rect(0u, 0u, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0x80u);   // The last 0x80u here is the tile ID 
	ld	hl, #0x0080
	push	hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x00
	push	hl
	call	_fill_rect_compat
;src/main.c:35: set_bkg_data(0u, INCBIN_SIZE(logo_tiles_data) / TILE_BYTES, logo_tiles_data);
	ld	de, #_logo_tiles_data+0
	ld	bc, #___size_logo_tiles_data+0
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;../../../include/sms/sms.h:534: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	push	de
	push	bc
	ld	hl, #0x0000
	push	hl
	call	_set_tile_2bpp_data
;src/main.c:38: logo_map);
;src/main.c:36: set_bkg_tiles(LOGO_MAP_X, LOGO_MAP_Y,
	ld	hl, #_logo_map
	push	hl
	ld	hl, #0xc07
	push	hl
	ld	hl, #0x306
	push	hl
	call	_set_tile_map_compat
;src/main.c:42: }
	ret
;src/main.c:46: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:48: init_gfx();
	call	_init_gfx
;src/main.c:51: while(1) {
00102$:
;src/main.c:56: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:58: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
