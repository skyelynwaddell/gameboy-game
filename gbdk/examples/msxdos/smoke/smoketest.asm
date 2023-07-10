;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module smoketest
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl b_banked_func
	.globl _banked_func
	.globl _set_tile_map
	.globl _set_sprite_1bpp_data
	.globl _set_native_tile_data
	.globl _joypad
	.globl _SWITCH_ROM
	.globl _wait_vbl_done
	.globl _tick
	.globl _anim
	.globl _yspd
	.globl _xspd
	.globl _y
	.globl _x
	.globl _joy
	.globl _tilemapw
	.globl _tilemap
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_MEMORY_CTL	=	0x003e
_JOY_CTL	=	0x003f
_VCOUNTER	=	0x007e
_PSG	=	0x007f
_HCOUNTER	=	0x007f
_VDP_DATA	=	0x0098
_VDP_CMD	=	0x0099
_VDP_STATUS	=	0x0099
_JOY_PORT1	=	0x00dc
_JOY_PORT2	=	0x00dd
_FMADDRESS	=	0x00f0
_FMDATA	=	0x00f1
_AUDIOCTRL	=	0x00f2
_MAP_FRAME0	=	0x00fc
_MAP_FRAME1	=	0x00fd
_MAP_FRAME2	=	0x00fe
_MAP_FRAME3	=	0x00ff
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_joy::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_x::
	.ds 2
_y::
	.ds 2
_xspd::
	.ds 1
_yspd::
	.ds 1
_anim::
	.ds 1
_tick::
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
;smoketest.c:20: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;smoketest.c:23: DISPLAY_ON;
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
	jp	PO, 00261$
	ei
00261$:
;smoketest.c:27: SWITCH_ROM(BANK(earth_data));
	ld	l, #<(___bank_earth_data)
;	spillPairReg hl
;	spillPairReg hl
	call	_SWITCH_ROM
;smoketest.c:28: if (banked_func(0xBE, 0xEF) == 0xBEEF) {
	ld	hl, #0xefbe
	push	hl
	ld	e, #b_banked_func
	ld	hl, #_banked_func
	call	___sdcc_bcall_ehl
	pop	af
	ld	a, e
	sub	a, #0xef
	jr	NZ, 00102$
	ld	a, d
	sub	a, #0xbe
	jr	NZ, 00102$
;smoketest.c:29: set_bkg_data(2, earth_data_size >> 4, earth_data);
	ld	bc, #_earth_data
	ld	hl, (_earth_data_size)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
;../../../include/msx/msx.h:495: set_native_tile_data(start, ntiles, src);
	push	bc
	push	hl
	ld	hl, #0x0002
	push	hl
	call	_set_native_tile_data
;smoketest.c:30: set_sprite_data(0, earth_data_size >> 4, earth_data);
	ld	bc, #_earth_data
	ld	hl, (_earth_data_size)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
;../../../include/msx/msx.h:498: set_sprite_1bpp_data(start, ntiles, src);
	push	bc
	push	hl
	ld	hl, #0x0000
	push	hl
	call	_set_sprite_1bpp_data
;../../../include/msx/msx.h:653: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
;smoketest.c:32: set_sprite_tile(1, 2);
00102$:
;smoketest.c:35: set_bkg_tiles(4, 10, 4, 2, tilemap);
	ld	hl, #_tilemap
	push	hl
	ld	hl, #0x204
	push	hl
	ld	hl, #0xa04
	push	hl
	call	_set_tile_map
;smoketest.c:37: set_tile_map(4, 16, 4, 2, tilemapw);
	ld	hl, #_tilemapw
	push	hl
	ld	hl, #0x204
	push	hl
	ld	hl, #0x1004
	push	hl
	call	_set_tile_map
;smoketest.c:39: while(TRUE) {
00148$:
;smoketest.c:40: joy = joypad();
	call	_joypad
	ld	a, l
	ld	(_joy+0), a
;smoketest.c:42: if (joy & J_LEFT) {            
	ld	a, (_joy+0)
	ld	c, a
	bit	4, c
	jr	Z, 00116$
;smoketest.c:43: if (xspd > -32) xspd -= 2; 
	ld	a, #0xe0
	ld	hl, #_xspd
	sub	a, (hl)
	jp	PO, 00265$
	xor	a, #0x80
00265$:
	jp	P, 00117$
	ld	iy, #_xspd
	dec	0 (iy)
	dec	0 (iy)
	jr	00117$
00116$:
;smoketest.c:44: } else if (joy & J_RIGHT) {
	bit	7, c
	jr	Z, 00113$
;smoketest.c:45: if (xspd < 32) xspd += 2;
	ld	a, (_xspd+0)
	xor	a, #0x80
	sub	a, #0xa0
	jr	NC, 00117$
	ld	iy, #_xspd
	inc	0 (iy)
	inc	0 (iy)
	jr	00117$
00113$:
;smoketest.c:47: if (xspd < 0) xspd++; else if (xspd > 0) xspd--;            
	ld	a, (_xspd+0)
	bit	7, a
	jr	Z, 00110$
	ld	hl, #_xspd
	inc	(hl)
	jr	00117$
00110$:
	xor	a, a
	ld	hl, #_xspd
	sub	a, (hl)
	jp	PO, 00267$
	xor	a, #0x80
00267$:
	jp	P, 00117$
	ld	hl, #_xspd
	dec	(hl)
00117$:
;smoketest.c:50: if (joy & J_UP) {
	bit	5, c
	jr	Z, 00131$
;smoketest.c:51: if (yspd > -32) yspd -= 2; 
	ld	a, #0xe0
	ld	hl, #_yspd
	sub	a, (hl)
	jp	PO, 00269$
	xor	a, #0x80
00269$:
	jp	P, 00132$
	ld	iy, #_yspd
	dec	0 (iy)
	dec	0 (iy)
	jr	00132$
00131$:
;smoketest.c:52: } else if (joy & J_DOWN) {
	bit	6, c
	jr	Z, 00128$
;smoketest.c:53: if (yspd < 32) yspd += 2;
	ld	a, (_yspd+0)
	xor	a, #0x80
	sub	a, #0xa0
	jr	NC, 00132$
	ld	iy, #_yspd
	inc	0 (iy)
	inc	0 (iy)
	jr	00132$
00128$:
;smoketest.c:55: if (yspd < 0) yspd++; else if (yspd > 0) yspd--;
	ld	a, (_yspd+0)
	bit	7, a
	jr	Z, 00125$
	ld	hl, #_yspd
	inc	(hl)
	jr	00132$
00125$:
	xor	a, a
	ld	hl, #_yspd
	sub	a, (hl)
	jp	PO, 00271$
	xor	a, #0x80
00271$:
	jp	P, 00132$
	ld	hl, #_yspd
	dec	(hl)
00132$:
;smoketest.c:58: x += xspd;
	ld	a, (_xspd+0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, (_x)
	add	hl, bc
	ld	(_x), hl
;smoketest.c:59: if (x < (8 << 4)) x = 8 << 4; else if (x > (30 * 8) << 4) x = (30 * 8) << 4;
	ld	a, (_x+0)
	sub	a, #0x80
	ld	a, (_x+1)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00136$
	ld	hl, #0x0080
	ld	(_x), hl
	jr	00137$
00136$:
	ld	hl, (_x)
	xor	a, a
	cp	a, l
	ld	a, #0x0f
	sbc	a, h
	jp	PO, 00272$
	xor	a, #0x80
00272$:
	jp	P, 00137$
	ld	hl, #0x0f00
	ld	(_x), hl
00137$:
;smoketest.c:62: y += yspd;
	ld	a, (_yspd+0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, (_y)
	add	hl, bc
	ld	(_y), hl
;smoketest.c:63: if (y < 0) y = 0; else if (y > (22 * 8) << 4) y = (22 * 8) << 4;
	ld	hl, (_y)
	bit	7, h
	jr	Z, 00141$
	ld	hl, #0x0000
	ld	(_y), hl
	jr	00142$
00141$:
	xor	a, a
	cp	a, l
	ld	a, #0x0b
	sbc	a, h
	jp	PO, 00273$
	xor	a, #0x80
00273$:
	jp	P, 00142$
	ld	hl, #0x0b00
	ld	(_y), hl
00142$:
;smoketest.c:65: tick++; tick &= 7;
	ld	hl, #_tick
	inc	(hl)
	ld	a, (_tick+0)
	and	a, #0x07
	ld	(_tick+0), a
;smoketest.c:66: if (!tick) {
	ld	a, (_tick+0)
	or	a, a
	jr	NZ, 00146$
;smoketest.c:67: anim++; if (anim == 7) anim = 0;
	ld	iy, #_anim
	inc	0 (iy)
	ld	a, (_anim+0)
	sub	a, #0x07
	jr	NZ, 00144$
	ld	0 (iy), #0x00
00144$:
;smoketest.c:68: set_sprite_tile(0, anim << 2);
	ld	a, (_anim+0)
	add	a, a
	add	a, a
	ld	c, a
;../../../include/msx/msx.h:653: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;smoketest.c:69: set_sprite_tile(1, (anim << 2) + 2);
	ld	a, (_anim+0)
	add	a, a
	add	a, a
	add	a, #0x02
	ld	c, a
;../../../include/msx/msx.h:653: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), c
;smoketest.c:69: set_sprite_tile(1, (anim << 2) + 2);
00146$:
;smoketest.c:72: move_sprite(0, x >> 4, y >> 4);
	ld	hl, (_y)
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	b, l
	ld	hl, (_x)
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
;../../../include/msx/msx.h:688: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM+0
;../../../include/msx/msx.h:689: itm->y=y, itm->x=x;
	ld	(hl), b
	inc	hl
	ld	(hl), c
;smoketest.c:73: move_sprite(1, (x >> 4) + 8, y >> 4);
	ld	hl, (_y)
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	b, l
	ld	hl, (_x)
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	a, l
	add	a, #0x08
	ld	c, a
;../../../include/msx/msx.h:688: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;../../../include/msx/msx.h:689: itm->y=y, itm->x=x;
	ld	(hl), b
	inc	hl
	ld	(hl), c
;smoketest.c:86: wait_vbl_done();
	call	_wait_vbl_done
;smoketest.c:88: }
	jp	00148$
_tilemap:
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x08	; 8
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x09	; 9
_tilemapw:
	.dw #0x0002
	.dw #0x0004
	.dw #0x0006
	.dw #0x0008
	.dw #0x0003
	.dw #0x0005
	.dw #0x0007
	.dw #0x0009
	.area _CODE
	.area _INITIALIZER
__xinit__x:
	.dw #0x0080
__xinit__y:
	.dw #0x0000
__xinit__xspd:
	.db #0x00	;  0
__xinit__yspd:
	.db #0x00	;  0
__xinit__anim:
	.db #0x00	; 0
__xinit__tick:
	.db #0x00	; 0
	.area _CABS (ABS)
