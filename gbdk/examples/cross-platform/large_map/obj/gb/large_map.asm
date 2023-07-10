;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module large_map
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_camera
	.globl _set_bkg_submap
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _joypad
	.globl _redraw
	.globl _old_map_pos_y
	.globl _old_map_pos_x
	.globl _map_pos_y
	.globl _map_pos_x
	.globl _old_camera_y
	.globl _old_camera_x
	.globl _camera_y
	.globl _camera_x
	.globl _joy
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_joy::
	.ds 1
_camera_x::
	.ds 2
_camera_y::
	.ds 2
_old_camera_x::
	.ds 2
_old_camera_y::
	.ds 2
_map_pos_x::
	.ds 1
_map_pos_y::
	.ds 1
_old_map_pos_x::
	.ds 1
_old_map_pos_y::
	.ds 1
_redraw::
	.ds 1
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
;src/large_map.c:64: void set_camera() {
;	---------------------------------
; Function set_camera
; ---------------------------------
_set_camera::
	dec	sp
;src/large_map.c:66: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ld	hl, #_camera_y
	ld	c, (hl)
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;../../../include/gb/gb.h:1208: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/large_map.c:68: map_pos_y = (uint8_t)(camera_y >> 3u);
	ld	hl, #_camera_y
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_map_pos_y
	ld	(hl), c
;src/large_map.c:69: if (map_pos_y != old_map_pos_y) { 
	ld	a, (hl)
	ld	hl, #_old_map_pos_y
	sub	a, (hl)
	jp	Z,00107$
;src/large_map.c:73: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ld	hl, #_map_pos_x
	ld	e, (hl)
	ld	d, #0x00
	ld	b, (hl)
;src/large_map.c:72: update_row_top(map_pos_y),
	ld	hl, #_map_pos_y
	ld	c, (hl)
;src/large_map.c:73: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ld	a, #0xf7
	sub	a, e
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	sbc	a, a
	sub	a, d
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0xf7
	sub	a, b
	ld	b, a
	ld	e, h
	ld	d, #0x00
	ld	a, #0x15
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00181$
	bit	7, d
	jr	NZ, 00182$
	cp	a, a
	jr	00182$
00181$:
	bit	7, d
	jr	Z, 00182$
	scf
00182$:
	ld	a, #0x00
	rla
	ldhl	sp,	#0
	ld	(hl), a
;src/large_map.c:70: if (camera_y < old_camera_y) {
	ld	de, #_camera_y
	ld	hl, #_old_camera_y
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00104$
;src/large_map.c:75: bigmap_map,
;src/large_map.c:73: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00122$
	ld	b, #0x15
00122$:
;src/large_map.c:71: set_bkg_submap(map_pos_x,
	ld	a, #0xf7
	push	af
	inc	sp
	ld	de, #_bigmap_mapPLN0
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	push	bc
	ld	a, (#_map_pos_x)
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
	jr	00105$
00104$:
;src/large_map.c:78: if ((bigmap_mapHeight - DEVICE_SCREEN_HEIGHT) > map_pos_y)
	ld	a, (#_map_pos_y)
	sub	a, #0x30
	jr	NC, 00105$
;src/large_map.c:83: bigmap_map,
;src/large_map.c:81: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00124$
	ld	e, #0x15
	jr	00125$
00124$:
	ld	e, b
00125$:
;src/large_map.c:61: return map_pos_y + DEVICE_SCREEN_HEIGHT;
	ld	a, c
	add	a, #0x12
;src/large_map.c:79: set_bkg_submap(map_pos_x,
	ld	h, #0xf7
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	bc, #_bigmap_mapPLN0
	push	bc
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, e
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	ld	a, (#_map_pos_x)
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
00105$:
;src/large_map.c:86: old_map_pos_y = map_pos_y; 
	ld	a, (#_map_pos_y)
	ld	(#_old_map_pos_y),a
00107$:
;src/large_map.c:89: map_pos_x = (uint8_t)(camera_x >> 3u);
	ld	hl, #_camera_x
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_map_pos_x
	ld	(hl), c
;src/large_map.c:90: if (map_pos_x != old_map_pos_x) {
	ld	a, (hl)
	ld	hl, #_old_map_pos_x
	sub	a, (hl)
	jp	Z,00114$
;src/large_map.c:95: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ld	hl, #_map_pos_y
	ld	e, (hl)
	ld	d, #0x00
	ld	c, (hl)
;src/large_map.c:92: set_bkg_submap(update_column_left(map_pos_x),
	ld	hl, #_map_pos_x
	ld	b, (hl)
;src/large_map.c:95: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ld	a, #0x42
	sub	a, e
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	sbc	a, a
	sub	a, d
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x42
	sub	a, c
	ld	c, a
	ld	e, h
	ld	d, #0x00
	ld	a, #0x13
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00184$
	bit	7, d
	jr	NZ, 00185$
	cp	a, a
	jr	00185$
00184$:
	bit	7, d
	jr	Z, 00185$
	scf
00185$:
	ld	a, #0x00
	rla
	ldhl	sp,	#0
	ld	(hl), a
;src/large_map.c:91: if (camera_x < old_camera_x) {
	ld	de, #_camera_x
	ld	hl, #_old_camera_x
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00111$
;src/large_map.c:96: bigmap_map,
;src/large_map.c:95: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00126$
	ld	a, #0x13
	jr	00127$
00126$:
	ld	a, c
00127$:
;src/large_map.c:92: set_bkg_submap(update_column_left(map_pos_x),
	ld	h, #0xf7
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	de, #_bigmap_mapPLN0
	push	de
	ld	h, a
	ld	l, #0x01
	push	hl
	ld	a, (#_map_pos_y)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
	jr	00112$
00111$:
;src/large_map.c:99: if ((bigmap_mapWidth - DEVICE_SCREEN_WIDTH) > map_pos_x)
	ld	a, (#_map_pos_x)
	sub	a, #0xe3
	jr	NC, 00112$
;src/large_map.c:104: bigmap_map,
;src/large_map.c:103: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00128$
	ld	c, #0x13
00128$:
;src/large_map.c:47: return map_pos_x + DEVICE_SCREEN_WIDTH;
	ld	a, b
	add	a, #0x14
;src/large_map.c:100: set_bkg_submap(update_column_right(map_pos_x),
	ld	h, #0xf7
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	de, #_bigmap_mapPLN0
	push	de
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_map_pos_y
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
00112$:
;src/large_map.c:107: old_map_pos_x = map_pos_x;
	ld	a, (#_map_pos_x)
	ld	(#_old_map_pos_x),a
00114$:
;src/large_map.c:110: old_camera_x = camera_x, old_camera_y = camera_y;
	ld	a, (#_camera_x)
	ld	(#_old_camera_x),a
	ld	a, (#_camera_x + 1)
	ld	(#_old_camera_x + 1),a
	ld	a, (#_camera_y)
	ld	(#_old_camera_y),a
	ld	a, (#_camera_y + 1)
	ld	(#_old_camera_y + 1),a
;src/large_map.c:111: }
	inc	sp
	ret
;src/large_map.c:113: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/large_map.c:114: DISPLAY_OFF;
	call	_display_off
;src/large_map.c:115: set_bkg_data(0, 241u, bigmap_tiles);
	ld	de, #_bigmap_tiles
	push	de
	ld	hl, #0xf100
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/large_map.c:117: map_pos_x = map_pos_y = 0; 
	ld	hl, #_map_pos_y
	ld	(hl), #0x00
	ld	hl, #_map_pos_x
	ld	(hl), #0x00
;src/large_map.c:118: old_map_pos_x = old_map_pos_y = 255;
	ld	hl, #_old_map_pos_y
	ld	(hl), #0xff
	ld	hl, #_old_map_pos_x
	ld	(hl), #0xff
;src/large_map.c:119: set_bkg_submap(map_pos_x, map_pos_y, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, bigmap_map, bigmap_mapWidth);
	ld	a, #0xf7
	push	af
	inc	sp
	ld	de, #_bigmap_mapPLN0
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_submap
	add	sp, #7
;src/large_map.c:121: camera_x = camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
;src/large_map.c:122: old_camera_x = camera_x; old_camera_y = camera_y;
	xor	a, a
	ld	hl, #_old_camera_x
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ld	hl, #_old_camera_y
	ld	(hl+), a
	ld	(hl), a
;src/large_map.c:124: redraw = FALSE;
	ld	hl, #_redraw
	ld	(hl), #0x00
;../../../include/gb/gb.h:1208: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/large_map.c:133: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/large_map.c:134: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/large_map.c:135: while (TRUE) {
00123$:
;src/large_map.c:136: joy = joypad();
	call	_joypad
	ld	hl, #_joy
	ld	(hl), a
;src/large_map.c:138: if (joy & J_UP) {
	ld	c, (hl)
	bit	2, c
	jr	Z, 00108$
;src/large_map.c:139: if (camera_y) {
	ld	hl, #_camera_y + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00109$
;src/large_map.c:140: camera_y--;
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/large_map.c:141: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
	jr	00109$
00108$:
;src/large_map.c:143: } else if (joy & J_DOWN) {
	bit	3, c
	jr	Z, 00109$
;src/large_map.c:144: if (camera_y < camera_max_y) {
	ld	hl, #_camera_y
	ld	a, (hl+)
	ld	e, (hl)
	sub	a, #0x80
	ld	a, e
	sbc	a, #0x01
	jr	NC, 00109$
;src/large_map.c:145: camera_y++;
	dec	hl
	inc	(hl)
	jr	NZ, 00180$
	inc	hl
	inc	(hl)
00180$:
;src/large_map.c:146: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
00109$:
;src/large_map.c:150: if (joy & J_LEFT) {
	bit	1, c
	jr	Z, 00117$
;src/large_map.c:151: if (camera_x) {
	ld	hl, #_camera_x + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00118$
;src/large_map.c:152: camera_x--;
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/large_map.c:153: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
	jr	00118$
00117$:
;src/large_map.c:155: } else if (joy & J_RIGHT) {
	bit	0, c
	jr	Z, 00118$
;src/large_map.c:156: if (camera_x < camera_max_x) {
	ld	hl, #_camera_x
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x18
	ld	a, b
	sbc	a, #0x07
	jr	NC, 00118$
;src/large_map.c:157: camera_x++;
	dec	hl
	inc	(hl)
	jr	NZ, 00183$
	inc	hl
	inc	(hl)
00183$:
;src/large_map.c:158: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
00118$:
;src/large_map.c:161: if (redraw) {
	ld	a, (#_redraw)
	or	a, a
	jr	Z, 00120$
;src/large_map.c:162: wait_vbl_done();
	call	_wait_vbl_done
;src/large_map.c:163: set_camera();
	call	_set_camera
;src/large_map.c:164: redraw = FALSE;
	ld	hl, #_redraw
	ld	(hl), #0x00
	jp	00123$
00120$:
;src/large_map.c:165: } else wait_vbl_done();
	call	_wait_vbl_done
;src/large_map.c:167: }
	jp	00123$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
