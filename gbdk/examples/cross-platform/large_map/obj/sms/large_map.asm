;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module large_map
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_camera
	.globl _set_tile_submap_compat
	.globl _set_tile_2bpp_data
	.globl _joypad
	.globl _wait_vbl_done
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
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/large_map.c:66: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ld	hl, (_camera_y)
	ld	de, #0x00e0
	call	__moduint
	ld	a, (_camera_x+0)
;../../../include/sms/sms.h:195: __WRITE_VDP_REG(VDP_RSCX, -x);
	ld	hl, #_shadow_VDP_RSCX
	neg
	ld	(hl), a
	ld	a,i
	di
	push	af
	ld	a, (_shadow_VDP_RSCX+0)
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00185$
	ei
00185$:
;../../../include/sms/sms.h:196: __WRITE_VDP_REG(VDP_RSCY, y);
	ld	hl, #_shadow_VDP_RSCY
	ld	(hl), e
	ld	a,i
	di
	push	af
	ld	a, (_shadow_VDP_RSCY+0)
	out	(_VDP_CMD), a
	ld	a, #0x89
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00187$
	ei
00187$:
;src/large_map.c:68: map_pos_y = (uint8_t)(camera_y >> 3u);
	ld	hl, (_camera_y)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	a, l
	ld	(#_map_pos_y), a
;src/large_map.c:72: update_row_top(map_pos_y),
	ld	a, (_map_pos_y+0)
	ld	c, a
;src/large_map.c:69: if (map_pos_y != old_map_pos_y) { 
	ld	a, (_map_pos_y+0)
	ld	hl, #_old_map_pos_y
	sub	a, (hl)
	jp	Z,00107$
;src/large_map.c:73: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ld	a, (_map_pos_x+0)
	ld	e, a
	ld	d, #0x00
	ld	a, (_map_pos_x+0)
	ld	b, a
;src/large_map.c:72: update_row_top(map_pos_y),
	ld	a, (_map_pos_x+0)
	ld	-1 (ix), a
;src/large_map.c:73: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ld	hl, #0x00f7
	cp	a, a
	sbc	hl, de
	ld	a, #0xf7
	sub	a, b
	ld	e, a
	ld	a, #0x21
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00189$
	xor	a, #0x80
00189$:
	rlca
	and	a,#0x01
	ld	b, a
;src/large_map.c:70: if (camera_y < old_camera_y) {
	ld	hl, #_old_camera_y
	ld	a, (_camera_y+0)
	sub	a, (hl)
	inc	hl
	ld	a, (_camera_y+1)
	sbc	a, (hl)
	jr	NC, 00104$
;src/large_map.c:76: bigmap_mapWidth);
	ld	hl, #_bigmap_mapPLN0+0
;src/large_map.c:73: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ld	a, b
	or	a, a
	jr	Z, 00126$
	ld	e, #0x21
00126$:
	ld	a, e
;../../../include/sms/sms.h:590: set_tile_submap_compat(x, y, w, h, map_w, map);
	push	hl
	ld	h, #0xf7
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	b, a
	push	bc
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_set_tile_submap_compat
;src/large_map.c:76: bigmap_mapWidth);
	jr	00105$
00104$:
;src/large_map.c:78: if ((bigmap_mapHeight - DEVICE_SCREEN_HEIGHT) > map_pos_y)
	ld	a, (#_map_pos_y)
	sub	a, #0x2a
	jr	NC, 00105$
;src/large_map.c:84: bigmap_mapWidth);     
	ld	hl, #_bigmap_mapPLN0+0
;src/large_map.c:81: MIN(DEVICE_SCREEN_WIDTH + 1, bigmap_mapWidth-map_pos_x),
	ld	a, b
	or	a, a
	jr	Z, 00128$
	ld	e, #0x21
00128$:
	ld	b, e
;src/large_map.c:61: return map_pos_y + DEVICE_SCREEN_HEIGHT;
	ld	a, c
	add	a, #0x18
;../../../include/sms/sms.h:590: set_tile_submap_compat(x, y, w, h, map_w, map);
	push	hl
	ld	h, #0xf7
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_set_tile_submap_compat
;src/large_map.c:84: bigmap_mapWidth);     
00105$:
;src/large_map.c:72: update_row_top(map_pos_y),
	ld	a, (_map_pos_y+0)
	ld	c, a
;src/large_map.c:86: old_map_pos_y = map_pos_y; 
	ld	hl, #_old_map_pos_y
	ld	(hl), c
00107$:
;src/large_map.c:89: map_pos_x = (uint8_t)(camera_x >> 3u);
	ld	hl, (_camera_x)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	a, l
	ld	(#_map_pos_x), a
;src/large_map.c:90: if (map_pos_x != old_map_pos_x) {
	ld	a, (_map_pos_x+0)
	ld	hl, #_old_map_pos_x
	sub	a, (hl)
	jp	Z,00114$
;src/large_map.c:72: update_row_top(map_pos_y),
	ld	a, (_map_pos_x+0)
	ld	b, a
;src/large_map.c:95: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ld	a, (_map_pos_y+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_map_pos_y+0)
	ld	e, a
	ld	a, #0x42
	sub	a, l
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	sbc	a, a
	sub	a, h
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x42
	sub	a, e
	ld	e, a
;src/large_map.c:39: return map_pos_x + 1;
;src/large_map.c:95: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ld	a, #0x19
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00191$
	xor	a, #0x80
00191$:
	rlca
	and	a,#0x01
	ld	-1 (ix), a
;src/large_map.c:91: if (camera_x < old_camera_x) {
	ld	hl, #_old_camera_x
	ld	a, (_camera_x+0)
	sub	a, (hl)
	inc	hl
	ld	a, (_camera_x+1)
	sbc	a, (hl)
	jr	NC, 00111$
;src/large_map.c:97: bigmap_mapWidth);     
;src/large_map.c:95: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ld	a, -1 (ix)
	or	a, a
	jr	Z, 00130$
	ld	e, #0x19
00130$:
;src/large_map.c:39: return map_pos_x + 1;
	ld	a, b
	inc	a
;../../../include/sms/sms.h:590: set_tile_submap_compat(x, y, w, h, map_w, map);
	ld	hl, #_bigmap_mapPLN0
	push	hl
	ld	h, #0xf7
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, e
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_submap_compat
;src/large_map.c:97: bigmap_mapWidth);     
	jr	00112$
00111$:
;src/large_map.c:99: if ((bigmap_mapWidth - DEVICE_SCREEN_WIDTH) > map_pos_x)
	ld	hl, #_map_pos_x
	ld	a, (hl)
	sub	a, #0xd7
	jr	NC, 00112$
;src/large_map.c:105: bigmap_mapWidth);
;src/large_map.c:103: MIN(DEVICE_SCREEN_HEIGHT + 1, bigmap_mapHeight - map_pos_y),
	ld	a, -1 (ix)
	or	a, a
	jr	Z, 00132$
	ld	e, #0x19
00132$:
;src/large_map.c:47: return map_pos_x + DEVICE_SCREEN_WIDTH;
	ld	a, b
	add	a, #0x20
;../../../include/sms/sms.h:590: set_tile_submap_compat(x, y, w, h, map_w, map);
	ld	hl, #_bigmap_mapPLN0
	push	hl
	ld	h, #0xf7
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, e
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_submap_compat
;src/large_map.c:105: bigmap_mapWidth);
00112$:
;src/large_map.c:107: old_map_pos_x = map_pos_x;
	ld	a, (_map_pos_x+0)
	ld	(_old_map_pos_x+0), a
00114$:
;src/large_map.c:110: old_camera_x = camera_x, old_camera_y = camera_y;
	ld	hl, (_camera_x)
	ld	(_old_camera_x), hl
	ld	hl, (_camera_y)
	ld	(_old_camera_y), hl
;src/large_map.c:111: }
	inc	sp
	pop	ix
	ret
;src/large_map.c:113: void main(){
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
	jp	PO, 00182$
	ei
00182$:
;src/large_map.c:115: set_bkg_data(0, 241u, bigmap_tiles);
;../../../include/sms/sms.h:534: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_bigmap_tiles
	push	hl
	ld	hl, #0x00f1
	push	hl
	ld	l, h
	push	hl
	call	_set_tile_2bpp_data
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
;../../../include/sms/sms.h:590: set_tile_submap_compat(x, y, w, h, map_w, map);
	ld	hl, #_bigmap_mapPLN0
	push	hl
	ld	hl, #0xf718
	push	hl
	ld	hl, #0x2000
	push	hl
	xor	a, a
	push	af
	inc	sp
	call	_set_tile_submap_compat
;src/large_map.c:121: camera_x = camera_y = 0;
	ld	hl, #0x0000
	ld	(_camera_y), hl
	ld	(_camera_x), hl
;src/large_map.c:122: old_camera_x = camera_x; old_camera_y = camera_y;
	ld	(_old_camera_x), hl
	ld	(_old_camera_y), hl
;src/large_map.c:124: redraw = FALSE;
;../../../include/sms/sms.h:195: __WRITE_VDP_REG(VDP_RSCX, -x);
	ld	a,#0x00
	ld	(#_redraw),a
	ld	(#_shadow_VDP_RSCX), a
	ld	a,i
	di
	push	af
	ld	a, #0x00
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00184$
	ei
00184$:
;../../../include/sms/sms.h:196: __WRITE_VDP_REG(VDP_RSCY, y);
	ld	a, #0x00
	ld	(#_shadow_VDP_RSCY), a
	ld	a,i
	di
	push	af
	ld	a, #0x00
	out	(_VDP_CMD), a
	ld	a, #0x89
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00186$
	ei
00186$:
;src/large_map.c:131: HIDE_LEFT_COLUMN;
	ld	a, (_shadow_VDP_R0+0)
	or	a, #0x20
	ld	(_shadow_VDP_R0+0), a
	ld	a,i
	di
	push	af
	ld	a, (_shadow_VDP_R0+0)
	out	(_VDP_CMD), a
	ld	a, #0x80
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00188$
	ei
00188$:
;src/large_map.c:134: DISPLAY_ON;
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
	jp	PO, 00190$
	ei
00190$:
;src/large_map.c:135: while (TRUE) {
00123$:
;src/large_map.c:136: joy = joypad();
	call	_joypad
	ld	a, l
	ld	(_joy+0), a
;src/large_map.c:138: if (joy & J_UP) {
	ld	a, (_joy+0)
	ld	c, a
	bit	0, c
	jr	Z, 00108$
;src/large_map.c:139: if (camera_y) {
	ld	a, (_camera_y+1)
	ld	hl, #_camera_y
	or	a, (hl)
	jr	Z, 00109$
;src/large_map.c:140: camera_y--;
	ld	hl, (_camera_y)
	dec	hl
	ld	(_camera_y), hl
;src/large_map.c:141: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
	jr	00109$
00108$:
;src/large_map.c:143: } else if (joy & J_DOWN) {
	bit	1, c
	jr	Z, 00109$
;src/large_map.c:144: if (camera_y < camera_max_y) {
	ld	hl, (_camera_y)
	ld	de, #0x0150
	cp	a, a
	sbc	hl, de
	jr	NC, 00109$
;src/large_map.c:145: camera_y++;
	ld	hl, (_camera_y)
	inc	hl
	ld	(_camera_y), hl
;src/large_map.c:146: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
00109$:
;src/large_map.c:150: if (joy & J_LEFT) {
	bit	2, c
	jr	Z, 00117$
;src/large_map.c:151: if (camera_x) {
	ld	a, (_camera_x+1)
	ld	hl, #_camera_x
	or	a, (hl)
	jr	Z, 00118$
;src/large_map.c:152: camera_x--;
	ld	hl, (_camera_x)
	dec	hl
	ld	(_camera_x), hl
;src/large_map.c:153: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
	jr	00118$
00117$:
;src/large_map.c:155: } else if (joy & J_RIGHT) {
	bit	3, c
	jr	Z, 00118$
;src/large_map.c:156: if (camera_x < camera_max_x) {
	ld	hl, (_camera_x)
	ld	de, #0x06b8
	cp	a, a
	sbc	hl, de
	jr	NC, 00118$
;src/large_map.c:157: camera_x++;
	ld	hl, (_camera_x)
	inc	hl
	ld	(_camera_x), hl
;src/large_map.c:158: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
00118$:
;src/large_map.c:161: if (redraw) {
	ld	a, (_redraw+0)
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
