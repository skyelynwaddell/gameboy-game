;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module metasprites
	.optsdcc -mmos6502
	
	.globl __TEMP
	.globl __DPTR
	.area ZP      (PAG)
__TEMP:	.ds 8
__DPTR:	.ds 2
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _pattern
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
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area ZP      (PAG)
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
;--------------------------------------------------------
; uninitialized external ram data
;--------------------------------------------------------
	.area BSS
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
_main_hiwater_131073_88:
	.ds 1
_main___1966090013_196609_96:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _CODE
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _CODE
	.area _CODE
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;__1966080009              Allocated to registers 
;hiwater                   Allocated with name '_main_hiwater_131073_88'
;__1966090006              Allocated to registers 
;__1966090007              Allocated to registers 
;metasprite                Allocated to registers a x 
;base_sprite               Allocated to registers 
;__1966090010              Allocated to registers 
;__1966090011              Allocated to registers 
;__1966090012              Allocated to registers 
;__1966090013              Allocated with name '_main___1966090013_196609_96'
;__1966090014              Allocated to registers 
;metasprite                Allocated to registers a x 
;base_tile                 Allocated to registers 
;base_sprite               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;------------------------------------------------------------
;	src/metasprites.c: 32: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/metasprites.c: 33: DISPLAY_OFF;
	jsr	_display_off
;	src/metasprites.c: 36: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x00
	stx	_fill_bkg_rect_PARM_5
	txa
	jsr	_fill_bkg_rect
;	src/metasprites.c: 39: set_bkg_data(0, 1, pattern);
	lda	#_pattern
	sta	_set_bkg_data_PARM_3
	lda	#>_pattern
	sta	(_set_bkg_data_PARM_3 + 1)
	lda	#0x00
	ldx	#0x01
	jsr	_set_bkg_data
;	src/metasprites.c: 42: set_sprite_data(TILE_NUM_START, sizeof(sprite_tiles) >> 4, sprite_tiles);
	lda	#_sprite_tiles
	sta	_set_sprite_data_PARM_3
	lda	#>_sprite_tiles
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#0x00
	ldx	#0x3c
	jsr	_set_sprite_data
;	src/metasprites.c: 45: SHOW_BKG; SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	src/metasprites.c: 49: SPRITES_8x16;
	lda	_shadow_PPUCTRL
	ora	#0x20
	sta	_shadow_PPUCTRL
;	src/metasprites.c: 53: DISPLAY_ON;
	jsr	_display_on
;	src/metasprites.c: 56: joypad_init(1, &joypads);
	lda	#_joypads
	sta	_joypad_init_PARM_2
	lda	#>_joypads
	sta	(_joypad_init_PARM_2 + 1)
	lda	#0x01
	jsr	_joypad_init
;	src/metasprites.c: 59: PosX = PosY = 96 << 4;
	ldx	#0x00
	stx	_PosY
	ldx	#0x06
	stx	(_PosY + 1)
	ldx	#0x00
	stx	_PosX
	ldx	#0x06
	stx	(_PosX + 1)
;	src/metasprites.c: 60: SpdX = SpdY = 0;
	ldx	#0x00
	stx	_SpdY
	stx	(_SpdY + 1)
	stx	_SpdX
	stx	(_SpdX + 1)
;	src/metasprites.c: 62: hide = 0; jitter = 0; idx = 0;
	stx	_hide
	stx	_jitter
	stx	_idx
;	src/metasprites.c: 64: while(1) {        
00148$:
;	src/metasprites.c: 66: joypad_ex(&joypads);
	ldx	#>_joypads
	lda	#_joypads
	jsr	_joypad_ex
;	src/metasprites.c: 68: PosF = 0;
	ldx	#0x00
	stx	_PosF
;	src/metasprites.c: 70: if (joypads.joy0 & J_UP) {
	ldx	(_joypads + 0x0001)
	lda	#0x10
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00246$
	jmp	00108$
00246$:
;	src/metasprites.c: 71: SpdY -= 2;
	lda	_SpdY
	ldx	(_SpdY + 1)
	sec
	sbc	#0x02
	bcs	00247$
	dex
00247$:
	sta	_SpdY
	stx	(_SpdY + 1)
;	src/metasprites.c: 72: if (SpdY < -32) SpdY = -32;
	lda	_SpdY
	sec
	sbc	#0xe0
	lda	(_SpdY + 1)
	sbc	#0xff
	bvc	00249$
	bpl	00248$
	bmi	00250$
00249$:
	bmi	00248$
00250$:
	jmp	00102$
00248$:
	ldx	#0xe0
	stx	_SpdY
	ldx	#0xff
	stx	(_SpdY + 1)
00102$:
;	src/metasprites.c: 73: PosF |= ACC_Y;
	lda	_PosF
	ora	#0x02
	sta	_PosF
	jmp	00109$
00108$:
;	src/metasprites.c: 74: } else if (joypads.joy0 & J_DOWN) {
	lda	#0x20
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00251$
	jmp	00109$
00251$:
;	src/metasprites.c: 75: SpdY += 2;
	lda	_SpdY
	ldx	(_SpdY + 1)
	clc
	adc	#0x02
	bcc	00252$
	inx
00252$:
	sta	_SpdY
	stx	(_SpdY + 1)
;	src/metasprites.c: 76: if (SpdY > 32) SpdY = 32;
	lda	_SpdY
	ldx	(_SpdY + 1)
	sta	*(__TEMP+0)
	lda	#0x20
	sec
	sbc	*(__TEMP+0)
	lda	#0x00
	stx	*(__TEMP+0)
	sbc	*(__TEMP+0)
	bvc	00254$
	bpl	00253$
	bmi	00255$
00254$:
	bmi	00253$
00255$:
	jmp	00104$
00253$:
	ldx	#0x20
	stx	_SpdY
	ldx	#0x00
	stx	(_SpdY + 1)
00104$:
;	src/metasprites.c: 77: PosF |= ACC_Y;
	lda	_PosF
	ora	#0x02
	sta	_PosF
00109$:
;	src/metasprites.c: 80: if (joypads.joy0 & J_LEFT) {
	ldx	(_joypads + 0x0001)
	lda	#0x40
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00256$
	jmp	00117$
00256$:
;	src/metasprites.c: 81: SpdX -= 2;
	lda	_SpdX
	ldx	(_SpdX + 1)
	sec
	sbc	#0x02
	bcs	00257$
	dex
00257$:
	sta	_SpdX
	stx	(_SpdX + 1)
;	src/metasprites.c: 82: if (SpdX < -32) SpdX = -32;
	lda	_SpdX
	sec
	sbc	#0xe0
	lda	(_SpdX + 1)
	sbc	#0xff
	bvc	00259$
	bpl	00258$
	bmi	00260$
00259$:
	bmi	00258$
00260$:
	jmp	00111$
00258$:
	ldx	#0xe0
	stx	_SpdX
	ldx	#0xff
	stx	(_SpdX + 1)
00111$:
;	src/metasprites.c: 83: PosF |= ACC_X;
	lda	_PosF
	ora	#0x01
	sta	_PosF
	jmp	00118$
00117$:
;	src/metasprites.c: 84: } else if (joypads.joy0 & J_RIGHT) {
	lda	#0x80
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00261$
	jmp	00118$
00261$:
;	src/metasprites.c: 85: SpdX += 2;
	lda	_SpdX
	ldx	(_SpdX + 1)
	clc
	adc	#0x02
	bcc	00262$
	inx
00262$:
	sta	_SpdX
	stx	(_SpdX + 1)
;	src/metasprites.c: 86: if (SpdX > 32) SpdX = 32;
	lda	_SpdX
	ldx	(_SpdX + 1)
	sta	*(__TEMP+0)
	lda	#0x20
	sec
	sbc	*(__TEMP+0)
	lda	#0x00
	stx	*(__TEMP+0)
	sbc	*(__TEMP+0)
	bvc	00264$
	bpl	00263$
	bmi	00265$
00264$:
	bmi	00263$
00265$:
	jmp	00113$
00263$:
	ldx	#0x20
	stx	_SpdX
	ldx	#0x00
	stx	(_SpdX + 1)
00113$:
;	src/metasprites.c: 87: PosF |= ACC_X;
	lda	_PosF
	ora	#0x01
	sta	_PosF
00118$:
;	src/metasprites.c: 92: if ((joypads.joy0 & J_A) && (!jitter)) {
	lda	(_joypads + 0x0001)
	and	#0x01
	bne	00266$
	jmp	00120$
00266$:
	lda	_jitter
	beq	00267$
	jmp	00120$
00267$:
;	src/metasprites.c: 93: hide = (!hide);
	lda	_hide
	cmp	#0x01
	lda	#0x00
	rol	a
	eor	#0x01
	sta	_hide
;	src/metasprites.c: 94: jitter = 20;
	ldx	#0x14
	stx	_jitter
00120$:
;	src/metasprites.c: 98: if ((joypads.joy0 & J_B) && (!jitter) && (!hide)) {
	lda	(_joypads + 0x0001)
	and	#0x02
	bne	00268$
	jmp	00125$
00268$:
	lda	_jitter
	beq	00269$
	jmp	00125$
00269$:
	lda	_hide
	beq	00270$
	jmp	00125$
00270$:
;	src/metasprites.c: 99: idx++; if (idx >= (sizeof(sprite_metasprites) >> 1)) idx = 0;
	inc	_idx
	lda	_idx
	cmp	#0x05
	bcs	00271$
	jmp	00123$
00271$:
	ldx	#0x00
	stx	_idx
00123$:
;	src/metasprites.c: 100: jitter = 10;
	ldx	#0x0a
	stx	_jitter
00125$:
;	src/metasprites.c: 104: if (jitter) jitter--;
	lda	_jitter
	bne	00272$
	jmp	00129$
00272$:
	dec	_jitter
00129$:
;	src/metasprites.c: 106: PosX += SpdX, PosY += SpdY; 
	lda	_SpdX
	ldx	(_SpdX + 1)
	clc
	adc	_PosX
	sta	_PosX
	txa
	adc	(_PosX + 1)
	sta	(_PosX + 1)
	lda	_SpdY
	ldx	(_SpdY + 1)
	clc
	adc	_PosY
	sta	_PosY
	txa
	adc	(_PosY + 1)
	sta	(_PosY + 1)
;	src/metasprites.c: 108: uint8_t hiwater = 0;
	ldx	#0x00
	stx	_main_hiwater_131073_88
;	src/metasprites.c: 111: if (hide)
	lda	_hide
	bne	00273$
	jmp	00131$
00273$:
;	src/metasprites.c: 112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	lda	_idx
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#<(_sprite_metasprites+0)
	sta	*(__DPTR+0)
	txa
	adc	#>(_sprite_metasprites+0)
	sta	*(__DPTR+1)
	ldy	#0x01
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
;	../../../include/nes/metasprites.h: 226: __current_metasprite = metasprite;
	sta	___current_metasprite
	stx	(___current_metasprite + 1)
;	../../../include/nes/metasprites.h: 227: __hide_metasprite(base_sprite);
	tya
	jsr	___hide_metasprite
;	src/metasprites.c: 112: hide_metasprite(sprite_metasprites[idx], SPR_NUM_START);
	jmp	00132$
00131$:
;	src/metasprites.c: 114: hiwater = move_metasprite(sprite_metasprites[idx], TILE_NUM_START, SPR_NUM_START, (PosX >> 4), (PosY >> 4));
	lda	_PosY
	ldx	(_PosY + 1)
	stx	*(__TEMP+0)
	lsr	*(__TEMP+0)
	ror	a
	lsr	*(__TEMP+0)
	ror	a
	lsr	*(__TEMP+0)
	ror	a
	lsr	*(__TEMP+0)
	ror	a
	ldx	*(__TEMP+0)
	sta	___move_metasprite_PARM_3
	lda	_PosX
	ldx	(_PosX + 1)
	stx	*(__TEMP+0)
	lsr	*(__TEMP+0)
	ror	a
	lsr	*(__TEMP+0)
	ror	a
	lsr	*(__TEMP+0)
	ror	a
	lsr	*(__TEMP+0)
	ror	a
	ldx	*(__TEMP+0)
	sta	_main___1966090013_196609_96
	lda	_idx
	ldx	#0x00
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#<(_sprite_metasprites+0)
	sta	*(__DPTR+0)
	txa
	adc	#>(_sprite_metasprites+0)
	sta	*(__DPTR+1)
	ldy	#0x01
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
;	../../../include/nes/metasprites.h: 129: __current_metasprite = metasprite;
	sta	___current_metasprite
	stx	(___current_metasprite + 1)
;	../../../include/nes/metasprites.h: 130: __current_base_tile = base_tile;
	sty	___current_base_tile
;	../../../include/nes/metasprites.h: 131: return __move_metasprite(base_sprite, x, y);
	tya
	ldx	_main___1966090013_196609_96
	jsr	___move_metasprite
	sta	_main_hiwater_131073_88
;	src/metasprites.c: 114: hiwater = move_metasprite(sprite_metasprites[idx], TILE_NUM_START, SPR_NUM_START, (PosX >> 4), (PosY >> 4));
00132$:
;	src/metasprites.c: 117: hide_sprites_range(hiwater, MAX_HARDWARE_SPRITES);        
	lda	_main_hiwater_131073_88
	ldx	#0x40
	jsr	_hide_sprites_range
;	src/metasprites.c: 120: if (!(PosF & ACC_Y)) {
	lda	#0x02
	and	_PosF
	beq	00274$
	jmp	00139$
00274$:
;	src/metasprites.c: 121: if (SpdY != 0) {
	lda	(_SpdY + 1)
	ora	_SpdY
	bne	00275$
	jmp	00139$
00275$:
;	src/metasprites.c: 122: if (SpdY < 0) SpdY++;
	lda	_SpdY
	ldx	(_SpdY + 1)
	txa
	sec
	sbc	#0x00
	bvc	00277$
	bpl	00276$
	bmi	00278$
00277$:
	bmi	00276$
00278$:
	jmp	00134$
00276$:
	inc	_SpdY
	bne	00279$
	inc	(_SpdY + 1)
00279$:
	jmp	00139$
00134$:
;	src/metasprites.c: 123: else SpdY --;
	sec
	lda	_SpdY
	sbc	#0x01
	sta	_SpdY
	bcs	00280$
	dec	(_SpdY + 1)
00280$:
00139$:
;	src/metasprites.c: 128: if (!(PosF & ACC_X)) {
	lda	#0x01
	and	_PosF
	beq	00281$
	jmp	00146$
00281$:
;	src/metasprites.c: 129: if (SpdX != 0) {
	lda	(_SpdX + 1)
	ora	_SpdX
	bne	00282$
	jmp	00146$
00282$:
;	src/metasprites.c: 130: if (SpdX < 0) SpdX++;
	lda	_SpdX
	ldx	(_SpdX + 1)
	txa
	sec
	sbc	#0x00
	bvc	00284$
	bpl	00283$
	bmi	00285$
00284$:
	bmi	00283$
00285$:
	jmp	00141$
00283$:
	inc	_SpdX
	bne	00286$
	inc	(_SpdX + 1)
00286$:
	jmp	00146$
00141$:
;	src/metasprites.c: 131: else SpdX --;
	sec
	lda	_SpdX
	sbc	#0x01
	sta	_SpdX
	bcs	00287$
	dec	(_SpdX + 1)
00287$:
00146$:
;	src/metasprites.c: 136: wait_vbl_done();
	jsr	_wait_vbl_done
	jmp	00148$
00152$:
;	src/metasprites.c: 138: }
	rts
	.area CODE
	.area RODATA
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
	.area XINIT
	.area CABS    (ABS)
