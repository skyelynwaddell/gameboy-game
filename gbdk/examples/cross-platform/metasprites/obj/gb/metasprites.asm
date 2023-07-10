;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module metasprites
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _hide_sprites_range
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _joypad_ex
	.globl _joypad_init
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
	add	sp, #-4
;src/metasprites.c:33: DISPLAY_OFF;
	call	_display_off
;src/metasprites.c:36: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
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
;src/metasprites.c:39: set_bkg_data(0, 1, pattern);
	ld	de, #_pattern
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_data
	add	sp, #4
;src/metasprites.c:42: set_sprite_data(TILE_NUM_START, sizeof(sprite_tiles) >> 4, sprite_tiles);
	ld	de, #_sprite_tiles
	push	de
	ld	hl, #0x3c00
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/metasprites.c:45: SHOW_BKG; SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/metasprites.c:49: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;src/metasprites.c:53: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/metasprites.c:56: joypad_init(1, &joypads);
	ld	de, #_joypads
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	call	_joypad_init
	add	sp, #3
;src/metasprites.c:59: PosX = PosY = 96 << 4;
	ld	hl, #_PosY
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
	ld	hl, #_PosX
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x06
;src/metasprites.c:60: SpdX = SpdY = 0;
	xor	a, a
	ld	hl, #_SpdY
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ld	hl, #_SpdX
	ld	(hl+), a
	ld	(hl), a
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
	ld	de, #_joypads
	call	_joypad_ex
;src/metasprites.c:68: PosF = 0;
	ld	hl, #_PosF
	ld	(hl), #0x00
;src/metasprites.c:70: if (joypads.joy0 & J_UP) {
	ld	hl, #(_joypads + 1)
	ld	c, (hl)
;src/metasprites.c:71: SpdY -= 2;
	ld	hl, #_SpdY
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/metasprites.c:73: PosF |= ACC_Y;
	ld	a, (#_PosF)
	or	a, #0x02
	ldhl	sp,	#3
	ld	(hl), a
;src/metasprites.c:70: if (joypads.joy0 & J_UP) {
	bit	2, c
	jr	Z, 00108$
;src/metasprites.c:71: SpdY -= 2;
	dec	de
	dec	de
	ld	hl, #_SpdY
	ld	a, e
	ld	(hl+), a
;src/metasprites.c:72: if (SpdY < -32) SpdY = -32;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0xe0
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00270$
	bit	7, d
	jr	NZ, 00271$
	cp	a, a
	jr	00271$
00270$:
	bit	7, d
	jr	Z, 00271$
	scf
00271$:
	jr	NC, 00102$
	ld	hl, #_SpdY
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0xff
00102$:
;src/metasprites.c:73: PosF |= ACC_Y;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_PosF),a
	jr	00109$
00108$:
;src/metasprites.c:74: } else if (joypads.joy0 & J_DOWN) {
	bit	3, c
	jr	Z, 00109$
;src/metasprites.c:75: SpdY += 2;
	inc	de
	inc	de
	ld	hl, #_SpdY
	ld	a, e
	ld	(hl+), a
;src/metasprites.c:76: if (SpdY > 32) SpdY = 32;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x20
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00273$
	bit	7, d
	jr	NZ, 00274$
	cp	a, a
	jr	00274$
00273$:
	bit	7, d
	jr	Z, 00274$
	scf
00274$:
	jr	NC, 00104$
	ld	hl, #_SpdY
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00104$:
;src/metasprites.c:77: PosF |= ACC_Y;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_PosF),a
00109$:
;src/metasprites.c:80: if (joypads.joy0 & J_LEFT) {
	ld	a, (#(_joypads + 1) + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/metasprites.c:81: SpdX -= 2;
	ld	a, (#_SpdX)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (#_SpdX + 1)
	ldhl	sp,	#2
	ld	(hl), a
;src/metasprites.c:83: PosF |= ACC_X;
	ld	a, (#_PosF)
	or	a, #0x01
	ldhl	sp,	#3
	ld	(hl), a
;src/metasprites.c:80: if (joypads.joy0 & J_LEFT) {
	push	hl
	ldhl	sp,	#2
	bit	1, (hl)
	pop	hl
	jr	Z, 00117$
;src/metasprites.c:81: SpdX -= 2;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	dec	bc
	ld	hl, #_SpdX
	ld	a, c
	ld	(hl+), a
;src/metasprites.c:82: if (SpdX < -32) SpdX = -32;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0xe0
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00276$
	bit	7, d
	jr	NZ, 00277$
	cp	a, a
	jr	00277$
00276$:
	bit	7, d
	jr	Z, 00277$
	scf
00277$:
	jr	NC, 00111$
	ld	hl, #_SpdX
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0xff
00111$:
;src/metasprites.c:83: PosF |= ACC_X;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_PosF),a
	jr	00118$
00117$:
;src/metasprites.c:84: } else if (joypads.joy0 & J_RIGHT) {
	push	hl
	ldhl	sp,	#2
	bit	0, (hl)
	pop	hl
	jr	Z, 00118$
;src/metasprites.c:85: SpdX += 2;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	hl, #_SpdX
	ld	a, c
	ld	(hl+), a
;src/metasprites.c:86: if (SpdX > 32) SpdX = 32;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x20
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00279$
	bit	7, d
	jr	NZ, 00280$
	cp	a, a
	jr	00280$
00279$:
	bit	7, d
	jr	Z, 00280$
	scf
00280$:
	jr	NC, 00113$
	ld	hl, #_SpdX
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00113$:
;src/metasprites.c:87: PosF |= ACC_X;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_PosF),a
00118$:
;src/metasprites.c:92: if ((joypads.joy0 & J_A) && (!jitter)) {
	ld	a, (#(_joypads + 1) + 0)
	bit	4, a
	jr	Z, 00120$
	ld	a, (#_jitter)
	or	a, a
	jr	NZ, 00120$
;src/metasprites.c:93: hide = (!hide);
	ld	hl, #_hide
	ld	a, (hl)
	sub	a,#0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/metasprites.c:94: jitter = 20;
	ld	hl, #_jitter
	ld	(hl), #0x14
00120$:
;src/metasprites.c:98: if ((joypads.joy0 & J_B) && (!jitter) && (!hide)) {
	ld	a, (#(_joypads + 1) + 0)
	bit	5, a
	jr	Z, 00125$
	ld	a, (#_jitter)
	or	a, a
	jr	NZ, 00125$
	ld	a, (#_hide)
	or	a, a
	jr	NZ, 00125$
;src/metasprites.c:99: idx++; if (idx >= (sizeof(sprite_metasprites) >> 1)) idx = 0;
	ld	hl, #_idx
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	C, 00123$
	ld	(hl), #0x00
00123$:
;src/metasprites.c:100: jitter = 10;
	ld	hl, #_jitter
	ld	(hl), #0x0a
00125$:
;src/metasprites.c:104: if (jitter) jitter--;
	ld	hl, #_jitter
	ld	a, (hl)
	or	a, a
	jr	Z, 00129$
	dec	(hl)
00129$:
;src/metasprites.c:106: PosX += SpdX, PosY += SpdY; 
	ld	hl, #_SpdX
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_PosX
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
	ld	hl, #_SpdY
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_PosY
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
;src/metasprites.c:108: uint8_t hiwater = 0;
	ld	b, #0x00
;src/metasprites.c:112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	ld	hl, #_idx
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	c, l
	ld	e, h
;src/metasprites.c:111: if (hide)
	ld	a, (#_hide)
	or	a, a
	jr	Z, 00131$
;src/metasprites.c:112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	ld	a, #<(_sprite_metasprites)
	add	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #>(_sprite_metasprites)
	adc	a, e
	ld	h, a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
;../../../include/gb/metasprites.h:243: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), c
	inc	hl
	ld	(hl), a
;../../../include/gb/metasprites.h:244: __hide_metasprite(base_sprite);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	___hide_metasprite
	inc	sp
	pop	bc
;src/metasprites.c:112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	jr	00132$
00131$:
;src/metasprites.c:114: hiwater = move_metasprite(sprite_metasprites[idx], TILE_NUM_START, SPR_NUM_START, (PosX >> 4), (PosY >> 4));
	ld	hl, #_PosY
	ld	a, (hl+)
	ld	b, a
	ld	d, (hl)
	srl	d
	rr	b
	srl	d
	rr	b
	srl	d
	rr	b
	srl	d
	rr	b
	ldhl	sp,	#3
	ld	(hl), b
	ld	hl, #_PosX
	ld	a, (hl+)
	ld	b, a
	ld	d, (hl)
	srl	d
	rr	b
	srl	d
	rr	b
	srl	d
	rr	b
	srl	d
	rr	b
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
	ld	a, (hl+)
	ld	c, (hl)
;../../../include/gb/metasprites.h:140: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), c
;../../../include/gb/metasprites.h:141: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;../../../include/gb/metasprites.h:142: return __move_metasprite(base_sprite, x, y);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
	ld	b, e
;src/metasprites.c:114: hiwater = move_metasprite(sprite_metasprites[idx], TILE_NUM_START, SPR_NUM_START, (PosX >> 4), (PosY >> 4));
00132$:
;src/metasprites.c:117: hide_sprites_range(hiwater, MAX_HARDWARE_SPRITES);        
	ld	a, #0x28
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_hide_sprites_range
	pop	hl
;src/metasprites.c:120: if (!(PosF & ACC_Y)) {
	ld	a, (#_PosF)
	ldhl	sp,	#1
	ld	(hl), a
	push	hl
	bit	1, (hl)
	pop	hl
	jr	NZ, 00139$
;src/metasprites.c:121: if (SpdY != 0) {
	ld	hl, #_SpdY + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00139$
;src/metasprites.c:122: if (SpdY < 0) SpdY++;
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (#_SpdY + 1)
	ldhl	sp,	#3
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00134$
	ld	hl, #_SpdY
	inc	(hl)
	jr	NZ, 00139$
	inc	hl
	inc	(hl)
	jr	00139$
00134$:
;src/metasprites.c:123: else SpdY --;
	ld	hl, #_SpdY
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00139$:
;src/metasprites.c:128: if (!(PosF & ACC_X)) {
	push	hl
	ldhl	sp,	#3
	bit	0, (hl)
	pop	hl
	jr	NZ, 00146$
;src/metasprites.c:129: if (SpdX != 0) {
	ld	hl, #_SpdX + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00146$
;src/metasprites.c:130: if (SpdX < 0) SpdX++;
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00141$
	dec	hl
	inc	(hl)
	jr	NZ, 00146$
	inc	hl
	inc	(hl)
	jr	00146$
00141$:
;src/metasprites.c:131: else SpdX --;
	ld	hl, #_SpdX
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00146$:
;src/metasprites.c:136: wait_vbl_done();
	call	_wait_vbl_done
	jp	00148$
;src/metasprites.c:138: }
	add	sp, #4
	ret
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
