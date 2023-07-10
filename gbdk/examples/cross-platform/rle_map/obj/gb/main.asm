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
	.globl b___func_map_compressed
	.globl ___func_map_compressed
	.globl b___func_map_tiles
	.globl ___func_map_tiles
	.globl _rle_decompress
	.globl _rle_init
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _datapos
	.globl _scrollpos
	.globl _data
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_data::
	.ds 18
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_scrollpos::
	.ds 1
_datapos::
	.ds 1
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
;src/main.c:8: INCBIN(map_tiles, "res/map_tiles.bin")
;	---------------------------------
; Function __func_map_tiles
; ---------------------------------
	b___func_map_tiles	= 0
___func_map_tiles::
_map_tiles::
1$:
	.incbin "res/map_tiles.bin" 
2$:
	___size_map_tiles = (2$-1$) 
	.globl ___size_map_tiles 
	.local b___func_map_tiles 
	___bank_map_tiles = b___func_map_tiles 
	.globl ___bank_map_tiles 
;src/main.c:15: INCBIN(map_compressed, "res/map.bin.rle")
;	---------------------------------
; Function __func_map_compressed
; ---------------------------------
	b___func_map_compressed	= 0
___func_map_compressed::
_map_compressed::
1$:
	.incbin "res/map.bin.rle" 
2$:
	___size_map_compressed = (2$-1$) 
	.globl ___size_map_compressed 
	.local b___func_map_compressed 
	___bank_map_compressed = b___func_map_compressed 
	.globl ___bank_map_compressed 
;src/main.c:22: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:30: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:33: set_bkg_data(0, INCBIN_SIZE(map_tiles) >> 4, map_tiles);
	ld	bc, #_map_tiles+0
	ld	de, #___size_map_tiles+0
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	push	bc
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:36: rle_init(map_compressed);
	ld	de, #_map_compressed
	push	de
	call	_rle_init
	pop	hl
;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
	ld	bc, #_data
	ld	e, #0x00
00111$:
	ld	a, e
	sub	a, #0x15
	jr	Z, 00101$
;src/main.c:42: rle_decompress(data, MAP_DATA_HEIGHT);
	push	bc
	push	de
	ld	a, #0x12
	push	af
	inc	sp
	ld	hl, #_data
	push	hl
	call	_rle_decompress
	add	sp, #3
	pop	de
	pop	bc
;src/main.c:47: set_bkg_tiles(i & (DEVICE_SCREEN_BUFFER_WIDTH-1), 0, 1, MAP_DATA_HEIGHT, data);
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	ld	a, e
	and	a, #0x1f
	push	de
	push	hl
	ld	h, #0x12
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
	inc	e
	jr	00111$
00101$:
;src/main.c:51: datapos = 0;
	ld	hl, #_datapos
	ld	(hl), #0x00
;src/main.c:52: scrollpos = 1;
	ld	hl, #_scrollpos
	ld	(hl), #0x01
;src/main.c:53: while(TRUE) {
00107$:
;src/main.c:55: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:60: scrollpos++;
	ld	hl, #_scrollpos
	inc	(hl)
;src/main.c:61: move_bkg(scrollpos, 0);
	ld	a, (hl)
;../../../include/gb/gb.h:1208: SCX_REG=x, SCY_REG=y;
	ldh	(_SCX_REG + 0), a
	push	af
	xor	a, a
	ldh	(_SCY_REG + 0), a
	pop	af
;src/main.c:65: if ((scrollpos & 0x07u) == 0) {
	and	a, #0x07
	jr	NZ, 00107$
;src/main.c:69: datapos = (scrollpos >> 3);
	ld	a, (#_scrollpos)
	swap	a
	rlca
	and	a, #0x1f
	ld	hl, #_datapos
	ld	(hl), a
;src/main.c:70: uint8_t map_x_column = (datapos + DEVICE_SCREEN_WIDTH) & (DEVICE_SCREEN_BUFFER_WIDTH-1);
	ld	a, (hl)
	add	a, #0x14
	and	a, #0x1f
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:75: if (!rle_decompress(data, MAP_DATA_HEIGHT)) {
	ld	a, #0x12
	push	af
	inc	sp
	ld	de, #_data
	push	de
	call	_rle_decompress
	add	sp, #3
	ld	a, e
	or	a, a
	jr	NZ, 00103$
;src/main.c:76: rle_init(map_compressed);
	ld	de, #_map_compressed
	push	de
	call	_rle_init
	pop	hl
;src/main.c:77: rle_decompress(data, MAP_DATA_HEIGHT);
	ld	a, #0x12
	push	af
	inc	sp
	ld	de, #_data
	push	de
	call	_rle_decompress
	add	sp, #3
00103$:
;src/main.c:83: set_bkg_tiles(map_x_column, 0, 1, MAP_DATA_HEIGHT, data);
	ld	de, #_data
	push	de
	ld	hl, #0x1201
	push	hl
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	jr	00107$
;src/main.c:86: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__scrollpos:
	.db #0x00	; 0
__xinit__datapos:
	.db #0x00	; 0
	.area _CABS (ABS)
