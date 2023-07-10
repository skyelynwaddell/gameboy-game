;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module metasprites
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _hide_sprites_range
	.globl _fill_rect_compat
	.globl _set_tile_2bpp_data
	.globl _joypad_ex
	.globl _joypad_init
	.globl _wait_vbl_done
	.globl _idx
	.globl _jitter
	.globl _hide
	.globl _PosF
	.globl _SpdY
	.globl _SpdX
	.globl _PosY
	.globl _PosX
	.globl _joypads
	.globl _pattern
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
_joypads::
	.ds 5
_PosX::
	.ds 2
_PosY::
	.ds 2
_SpdX::
	.ds 2
_SpdY::
	.ds 2
_PosF::
	.ds 1
_hide::
	.ds 1
_jitter::
	.ds 1
_idx::
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
;src/metasprites.c:32: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-5
	add	hl, sp
	ld	sp, hl
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
	jp	PO, 00273$
	ei
00273$:
;src/metasprites.c:36: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x00
	push	hl
	call	_fill_rect_compat
;src/metasprites.c:39: set_bkg_data(0, 1, pattern);
;../../../include/sms/sms.h:534: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_pattern
	push	hl
	ld	hl, #0x0001
	push	hl
	ld	l, h
	push	hl
	call	_set_tile_2bpp_data
;src/metasprites.c:42: set_sprite_data(TILE_NUM_START, sizeof(sprite_tiles) >> 4, sprite_tiles);
;../../../include/sms/sms.h:537: set_tile_2bpp_data((uint8_t)(start) + 0x100u, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_sprite_tiles
	push	hl
	ld	hl, #0x003c
	push	hl
	ld	hl, #0x0100
	push	hl
	call	_set_tile_2bpp_data
;src/metasprites.c:49: SPRITES_8x16;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x02
	ld	(_shadow_VDP_R1+0), a
	ld	a,i
	di
	push	af
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00275$
	ei
00275$:
;src/metasprites.c:53: DISPLAY_ON;
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
	jp	PO, 00277$
	ei
00277$:
;src/metasprites.c:56: joypad_init(1, &joypads);
	ld	hl, #_joypads
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	call	_joypad_init
;src/metasprites.c:59: PosX = PosY = 96 << 4;
	ld	hl, #0x0600
	ld	(_PosY), hl
	ld	(_PosX), hl
;src/metasprites.c:60: SpdX = SpdY = 0;
	ld	h, l
	ld	(_SpdY), hl
	ld	(_SpdX), hl
;src/metasprites.c:62: hide = 0; jitter = 0; idx = 0;
	ld	hl, #_hide
	ld	(hl), #0x00
	ld	hl, #_jitter
	ld	(hl), #0x00
	ld	hl, #_idx
	ld	(hl), #0x00
;src/metasprites.c:64: while(1) {        
00148$:
;src/metasprites.c:66: joypad_ex(&joypads);
	ld	hl, #_joypads
	call	_joypad_ex
;src/metasprites.c:68: PosF = 0;
	ld	hl, #_PosF
	ld	(hl), #0x00
;src/metasprites.c:70: if (joypads.joy0 & J_UP) {
	ld	a, (#(_joypads + 1) + 0)
	ld	-1 (ix), a
;src/metasprites.c:71: SpdY -= 2;
	ld	hl, (_SpdY)
	ex	(sp), hl
;src/metasprites.c:73: PosF |= ACC_Y;
	ld	a, (_PosF+0)
	or	a, #0x02
	ld	-3 (ix), a
;src/metasprites.c:70: if (joypads.joy0 & J_UP) {
	bit	0, -1 (ix)
	jr	Z, 00108$
;src/metasprites.c:71: SpdY -= 2;
	pop	hl
	push	hl
	dec	hl
	dec	hl
	ld	(_SpdY), hl
;src/metasprites.c:72: if (SpdY < -32) SpdY = -32;
	ld	a, (_SpdY+0)
	sub	a, #0xe0
	ld	a, (_SpdY+1)
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00102$
	ld	hl, #0xffe0
	ld	(_SpdY), hl
00102$:
;src/metasprites.c:73: PosF |= ACC_Y;
	ld	a, -3 (ix)
	ld	(_PosF+0), a
	jr	00109$
00108$:
;src/metasprites.c:74: } else if (joypads.joy0 & J_DOWN) {
	bit	1, -1 (ix)
	jr	Z, 00109$
;src/metasprites.c:75: SpdY += 2;
	ld	a, -5 (ix)
	add	a, #0x02
	ld	-2 (ix), a
	ld	a, -4 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(_SpdY), hl
;src/metasprites.c:76: if (SpdY > 32) SpdY = 32;
	ld	hl, (_SpdY)
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, #0x20
	cp	a, -2 (ix)
	ld	a, #0x00
	sbc	a, -1 (ix)
	jp	PO, 00280$
	xor	a, #0x80
00280$:
	jp	P, 00104$
	ld	hl, #0x0020
	ld	(_SpdY), hl
00104$:
;src/metasprites.c:77: PosF |= ACC_Y;
	ld	a, -3 (ix)
	ld	(_PosF+0), a
00109$:
;src/metasprites.c:80: if (joypads.joy0 & J_LEFT) {
	ld	hl, #(_joypads + 1)
	ld	c, (hl)
;src/metasprites.c:81: SpdX -= 2;
	ld	hl, (_SpdX)
	ld	-2 (ix), l
	ld	-1 (ix), h
;src/metasprites.c:83: PosF |= ACC_X;
	ld	a, (_PosF+0)
	ld	e, a
	set	0, e
;src/metasprites.c:80: if (joypads.joy0 & J_LEFT) {
	bit	2, c
	jr	Z, 00117$
;src/metasprites.c:81: SpdX -= 2;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	dec	hl
	dec	hl
	ld	(_SpdX), hl
;src/metasprites.c:82: if (SpdX < -32) SpdX = -32;
	ld	a, (_SpdX+0)
	sub	a, #0xe0
	ld	a, (_SpdX+1)
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00111$
	ld	hl, #0xffe0
	ld	(_SpdX), hl
00111$:
;src/metasprites.c:83: PosF |= ACC_X;
	ld	a, e
	ld	(#_PosF), a
	jr	00118$
00117$:
;src/metasprites.c:84: } else if (joypads.joy0 & J_RIGHT) {
	bit	3, c
	jr	Z, 00118$
;src/metasprites.c:85: SpdX += 2;
	ld	c, -2 (ix)
	ld	b, -1 (ix)
	inc	bc
	inc	bc
	ld	(_SpdX), bc
;src/metasprites.c:86: if (SpdX > 32) SpdX = 32;
	ld	hl, (_SpdX)
	ld	a, #0x20
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00283$
	xor	a, #0x80
00283$:
	jp	P, 00113$
	ld	hl, #0x0020
	ld	(_SpdX), hl
00113$:
;src/metasprites.c:87: PosF |= ACC_X;
	ld	a, e
	ld	(#_PosF), a
00118$:
;src/metasprites.c:92: if ((joypads.joy0 & J_A) && (!jitter)) {
	ld	a, (#(_joypads + 1) + 0)
	bit	4, a
	jr	Z, 00120$
	ld	a, (_jitter+0)
	or	a, a
	jr	NZ, 00120$
;src/metasprites.c:93: hide = (!hide);
	ld	a, (_hide+0)
	sub	a,#0x01
	ld	a, #0x00
	rla
	ld	(_hide+0), a
;src/metasprites.c:94: jitter = 20;
	ld	hl, #_jitter
	ld	(hl), #0x14
00120$:
;src/metasprites.c:98: if ((joypads.joy0 & J_B) && (!jitter) && (!hide)) {
	ld	a, (#(_joypads + 1) + 0)
	bit	5, a
	jr	Z, 00125$
	ld	a, (_jitter+0)
	or	a, a
	jr	NZ, 00125$
	ld	a, (_hide+0)
	or	a, a
	jr	NZ, 00125$
;src/metasprites.c:99: idx++; if (idx >= (sizeof(sprite_metasprites) >> 1)) idx = 0;
	ld	iy, #_idx
	inc	0 (iy)
	ld	a, (_idx+0)
	sub	a, #0x05
	jr	C, 00123$
	ld	0 (iy), #0x00
00123$:
;src/metasprites.c:100: jitter = 10;
	ld	hl, #_jitter
	ld	(hl), #0x0a
00125$:
;src/metasprites.c:104: if (jitter) jitter--;
	ld	a, (_jitter+0)
	or	a, a
	jr	Z, 00129$
	ld	hl, #_jitter
	dec	(hl)
00129$:
;src/metasprites.c:106: PosX += SpdX, PosY += SpdY; 
	ld	bc, (_SpdX)
	ld	a, c
	ld	iy, #_PosX
	add	a, 0 (iy)
	ld	(_PosX+0), a
	ld	a, b
	adc	a, 1 (iy)
	ld	(_PosX+1), a
	ld	bc, (_SpdY)
	ld	a, c
	ld	iy, #_PosY
	add	a, 0 (iy)
	ld	(_PosY+0), a
	ld	a, b
	adc	a, 1 (iy)
	ld	(_PosY+1), a
;src/metasprites.c:108: uint8_t hiwater = 0;
	ld	b, #0x00
;src/metasprites.c:112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	ld	a, (_idx+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	c, l
	ld	e, h
;src/metasprites.c:111: if (hide)
	ld	a, (_hide+0)
	or	a, a
	jr	Z, 00131$
;src/metasprites.c:112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	ld	hl, #_sprite_metasprites+0
	ld	a, c
	ld	d, e
	ld	e, a
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	(___current_metasprite), de
;../../../include/sms/metasprites.h:113: __hide_metasprite(base_sprite);
	push	bc
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	___hide_metasprite
	pop	bc
;src/metasprites.c:112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	jr	00132$
00131$:
;src/metasprites.c:114: hiwater = move_metasprite(sprite_metasprites[idx], TILE_NUM_START, SPR_NUM_START, (PosX >> 4), (PosY >> 4));
	ld	hl, (_PosY)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	d, l
	ld	hl, (_PosX)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	b, l
	ld	a, #<(_sprite_metasprites)
	add	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #>(_sprite_metasprites)
	adc	a, e
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;../../../include/sms/metasprites.h:97: __current_metasprite = metasprite; 
	ld	(___current_metasprite), hl
;../../../include/sms/metasprites.h:98: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;../../../include/sms/metasprites.h:99: return __move_metasprite(base_sprite, x, y); 
	ld	e, b
	push	de
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	ld	b, l
;src/metasprites.c:114: hiwater = move_metasprite(sprite_metasprites[idx], TILE_NUM_START, SPR_NUM_START, (PosX >> 4), (PosY >> 4));
00132$:
;src/metasprites.c:117: hide_sprites_range(hiwater, MAX_HARDWARE_SPRITES);        
	ld	a, #0x40
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_hide_sprites_range
;src/metasprites.c:120: if (!(PosF & ACC_Y)) {
	ld	a, (_PosF+0)
	ld	e, a
	bit	1, e
	jr	NZ, 00139$
;src/metasprites.c:121: if (SpdY != 0) {
	ld	a, (_SpdY+1)
	ld	hl, #_SpdY
	or	a, (hl)
	jr	Z, 00139$
;src/metasprites.c:122: if (SpdY < 0) SpdY++;
	ld	hl, (_SpdY)
	bit	7, h
	jr	Z, 00134$
	ld	hl, (_SpdY)
	inc	hl
	ld	(_SpdY), hl
	jr	00139$
00134$:
;src/metasprites.c:123: else SpdY --;
	ld	hl, (_SpdY)
	dec	hl
	ld	(_SpdY), hl
00139$:
;src/metasprites.c:128: if (!(PosF & ACC_X)) {
	bit	0, e
	jr	NZ, 00146$
;src/metasprites.c:129: if (SpdX != 0) {
	ld	a, (_SpdX+1)
	ld	hl, #_SpdX
	or	a, (hl)
	jr	Z, 00146$
;src/metasprites.c:130: if (SpdX < 0) SpdX++;
	ld	hl, (_SpdX)
	bit	7, h
	jr	Z, 00141$
	ld	hl, (_SpdX)
	inc	hl
	ld	(_SpdX), hl
	jr	00146$
00141$:
;src/metasprites.c:131: else SpdX --;
	ld	hl, (_SpdX)
	dec	hl
	ld	(_SpdX), hl
00146$:
;src/metasprites.c:136: wait_vbl_done();
	call	_wait_vbl_done
;src/metasprites.c:138: }
	jp	00148$
_pattern:
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
