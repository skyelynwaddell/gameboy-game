;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module pong
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init_pad
	.globl _printf
	.globl _gotoxy
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _joypad_ex
	.globl _joypad_init
	.globl _sprite_data
	.globl _spd_ballY
	.globl _spd_ballX
	.globl _ballY
	.globl _ballX
	.globl _player2_score
	.globl _player1_score
	.globl _player2
	.globl _player1
	.globl _joypads
	.globl _HUD
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_joypads::
	.ds 5
_player1::
	.ds 1
_player2::
	.ds 1
_player1_score::
	.ds 2
_player2_score::
	.ds 2
_ballX::
	.ds 1
_ballY::
	.ds 1
_spd_ballX::
	.ds 1
_spd_ballY::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_sprite_data::
	.ds 64
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
;src/pong.c:16: void init_pad(uint8_t n) {
;	---------------------------------
; Function init_pad
; ---------------------------------
_init_pad::
;src/pong.c:17: set_sprite_tile(n << 2, n);
	ld	c, a
	add	a, a
	add	a, a
	ld	b, a
;../../../include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;src/pong.c:18: set_sprite_tile((n << 2) + 1, n);
	ld	e, b
	inc	e
;../../../include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;src/pong.c:19: set_sprite_tile((n << 2) + 2, n);
	inc	b
	inc	b
;../../../include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	de, #_shadow_OAM+0
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;src/pong.c:19: set_sprite_tile((n << 2) + 2, n);
;src/pong.c:20: }
	ret
;src/pong.c:51: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-3
;src/pong.c:56: set_sprite_data(0, 4, sprite_data);
	ld	de, #_sprite_data
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/pong.c:59: init_pad(0);
	xor	a, a
	call	_init_pad
;src/pong.c:60: init_pad(1);
	ld	a, #0x01
	call	_init_pad
;../../../include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x02
;src/pong.c:66: SHOW_BKG; SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x40
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/pong.c:69: if (joypad_init(2, &joypads) != 2) {
	ld	de, #_joypads
	push	de
	ld	a, #0x02
	push	af
	inc	sp
	call	_joypad_init
	add	sp, #3
	ld	a, e
	sub	a, #0x02
	jr	Z, 00102$
;src/pong.c:70: printf("Device must support\nat least two joypads");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;src/pong.c:71: return;
	jp	00155$
00102$:
;src/pong.c:75: player1 = 64, player2 = 64;
	ld	hl, #_player1
	ld	(hl), #0x40
	ld	hl, #_player2
	ld	(hl), #0x40
;src/pong.c:76: player1_score = player2_score = 0;
	xor	a, a
	ld	hl, #_player2_score
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ld	hl, #_player1_score
	ld	(hl+), a
	ld	(hl), a
;src/pong.c:79: printf(HUD, player1_score, player2_score);
	ld	de, #0x0000
	push	de
	push	de
	ld	de, #_HUD
	push	de
	call	_printf
	add	sp, #6
;src/pong.c:82: ballX = INITBALLX, ballY = INITBALLY;
	ld	hl, #_ballX
	ld	(hl), #0x54
	ld	hl, #_ballY
	ld	(hl), #0x48
;src/pong.c:83: spd_ballX = 1, spd_ballY = 1;
	ld	hl, #_spd_ballX
	ld	(hl), #0x01
	ld	hl, #_spd_ballY
	ld	(hl), #0x01
;src/pong.c:85: while(1) {
00143$:
;src/pong.c:87: joypad_ex(&joypads);
	ld	de, #_joypads
	call	_joypad_ex
;src/pong.c:90: if (joypads.joy0 & J_UP) {
	ld	hl, #(_joypads + 1)
	ld	c, (hl)
;src/pong.c:91: player1 -= 2;
	ld	a, (#_player1)
;src/pong.c:90: if (joypads.joy0 & J_UP) {
	bit	2, c
	jr	Z, 00110$
;src/pong.c:91: player1 -= 2;
	add	a, #0xfe
	ld	hl, #_player1
	ld	(hl), a
;src/pong.c:92: if (player1 < YMIN) player1 = YMIN;
	ld	a, (hl)
	sub	a, #0x1c
	jr	NC, 00111$
	ld	(hl), #0x1c
	jr	00111$
00110$:
;src/pong.c:93: } else if (joypads.joy0 & J_DOWN) {
	bit	3, c
	jr	Z, 00111$
;src/pong.c:94: player1 += 2;
	add	a, #0x02
	ld	hl, #_player1
	ld	(hl), a
;src/pong.c:95: if (player1 > YMAX) player1 = YMAX;            
	ld	a, #0x64
	sub	a, (hl)
	jr	NC, 00111$
	ld	(hl), #0x64
00111$:
;src/pong.c:97: draw_pad(0, PLAYER1_X, player1);
	ld	hl, #_player1
	ld	c, (hl)
	ld	b, c
;../../../include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;../../../include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x08
;src/pong.c:25: move_sprite((n << 2) + 1, x, y + 8);
	ld	a, b
	add	a, #0x08
;../../../include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
;../../../include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	hl, #(_shadow_OAM + 4)
	ld	(hl+), a
	ld	(hl), #0x08
;src/pong.c:26: move_sprite((n << 2) + 2, x, y + 16);
	ld	a, b
	add	a, #0x10
;../../../include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
;../../../include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	hl, #(_shadow_OAM + 8)
	ld	(hl+), a
	ld	(hl), #0x08
;src/pong.c:100: if (joypads.joy1 & J_UP) {
	ld	hl, #(_joypads + 2)
	ld	c, (hl)
;src/pong.c:101: player2 -= 2;
	ld	a, (#_player2)
;src/pong.c:100: if (joypads.joy1 & J_UP) {
	bit	2, c
	jr	Z, 00119$
;src/pong.c:101: player2 -= 2;
	add	a, #0xfe
	ld	hl, #_player2
	ld	(hl), a
;src/pong.c:102: if (player2 < YMIN) player2 = YMIN;
	ld	a, (hl)
	sub	a, #0x1c
	jr	NC, 00120$
	ld	(hl), #0x1c
	jr	00120$
00119$:
;src/pong.c:103: } else if (joypads.joy1 & J_DOWN) {
	bit	3, c
	jr	Z, 00120$
;src/pong.c:104: player2 += 2;
	add	a, #0x02
	ld	hl, #_player2
	ld	(hl), a
;src/pong.c:105: if (player2 > YMAX) player2 = YMAX;            
	ld	a, #0x64
	sub	a, (hl)
	jr	NC, 00120$
	ld	(hl), #0x64
00120$:
;src/pong.c:107: draw_pad(1, PLAYER2_X, player2);
	ld	hl, #_player2
	ld	c, (hl)
	ld	b, c
;../../../include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;../../../include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	(hl), c
	inc	hl
	ld	(hl), #0xa0
;src/pong.c:25: move_sprite((n << 2) + 1, x, y + 8);
	ld	a, b
	add	a, #0x08
	ld	c, a
;../../../include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;../../../include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	(hl), c
	inc	hl
	ld	(hl), #0xa0
;src/pong.c:26: move_sprite((n << 2) + 2, x, y + 16);
	ld	a, b
	add	a, #0x10
	ld	c, a
;../../../include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;../../../include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	(hl), c
	inc	hl
	ld	(hl), #0xa0
;src/pong.c:110: ballX += spd_ballX, ballY += spd_ballY;
	ld	a, (#_ballX)
	ld	hl, #_spd_ballX
	add	a, (hl)
	ld	(#_ballX),a
	ld	a, (#_ballY)
	ld	hl, #_spd_ballY
	add	a, (hl)
	ld	hl, #_ballY
	ld	(hl), a
;src/pong.c:112: if ((ballY < YMIN) || (ballY > (YMAX + 24))) {
	ld	a, (hl)
	sub	a, #0x1c
	jr	C, 00121$
	ld	a, #0x7c
	sub	a, (hl)
	jr	NC, 00122$
00121$:
;src/pong.c:113: spd_ballY = -spd_ballY; 
	xor	a, a
	ld	hl, #_spd_ballY
	sub	a, (hl)
	ld	(hl), a
00122$:
;src/pong.c:117: if ((ballY > player1) && (ballY < (player1 + 24)) && (spd_ballX < 0)) 
	ld	a, (#_ballY)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
;src/pong.c:118: spd_ballX = -spd_ballX;
	xor	a, a
	ld	hl, #_spd_ballX
	sub	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;src/pong.c:116: if (ballX < (PLAYER1_X + 8)) {
	ld	a, (#_ballX)
	sub	a, #0x10
	jr	NC, 00135$
;src/pong.c:117: if ((ballY > player1) && (ballY < (player1 + 24)) && (spd_ballX < 0)) 
	ld	a, (#_player1)
	ld	hl, #_ballY
	sub	a, (hl)
	jp	NC, 00136$
	ld	a, (#_player1)
	ld	b, #0x00
	add	a, #0x18
	ld	c, a
	jr	NC, 00267$
	inc	b
00267$:
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00268$
	bit	7, d
	jr	NZ, 00269$
	cp	a, a
	jr	00269$
00268$:
	bit	7, d
	jr	Z, 00269$
	scf
00269$:
	jr	NC, 00136$
	ld	a, (#_spd_ballX)
	bit	7, a
	jr	Z, 00136$
;src/pong.c:118: spd_ballX = -spd_ballX;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_spd_ballX),a
	jr	00136$
00135$:
;src/pong.c:119: } else if (ballX > (PLAYER2_X - 8)) {
	ld	a, #0x98
	ld	hl, #_ballX
	sub	a, (hl)
	jr	NC, 00136$
;src/pong.c:120: if ((ballY > player2) && (ballY < (player2 + 24)) && (spd_ballX > 0)) 
	ld	a, (#_player2)
	ld	hl, #_ballY
	sub	a, (hl)
	jr	NC, 00136$
	ld	a, (#_player2)
	ld	b, #0x00
	add	a, #0x18
	ld	c, a
	jr	NC, 00270$
	inc	b
00270$:
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00271$
	bit	7, d
	jr	NZ, 00272$
	cp	a, a
	jr	00272$
00271$:
	bit	7, d
	jr	Z, 00272$
	scf
00272$:
	jr	NC, 00136$
	ld	hl, #_spd_ballX
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
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
	jr	NC, 00136$
;src/pong.c:121: spd_ballX = -spd_ballX;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_spd_ballX),a
00136$:
;src/pong.c:118: spd_ballX = -spd_ballX;
	xor	a, a
	ld	hl, #_spd_ballX
	sub	a, (hl)
	ld	c, a
;src/pong.c:124: if (ballX <= PLAYER1_X) {
	ld	a, #0x08
	ld	hl, #_ballX
	sub	a, (hl)
	jr	C, 00140$
;src/pong.c:126: ballX = INITBALLX, ballY = INITBALLY;
	ld	(hl), #0x54
	ld	hl, #_ballY
	ld	(hl), #0x48
;src/pong.c:127: spd_ballX = -spd_ballX;
	ld	hl, #_spd_ballX
	ld	(hl), c
;src/pong.c:128: player2_score++;
	ld	hl, #_player2_score
	inc	(hl)
	jr	NZ, 00275$
	inc	hl
	inc	(hl)
00275$:
;src/pong.c:129: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
	ld	hl, #_player2_score
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #_player1_score
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #_HUD
	push	de
	call	_printf
	add	sp, #6
	jr	00141$
00140$:
;src/pong.c:130: } else if (ballX > PLAYER2_X) {
	ld	a, #0xa0
	ld	hl, #_ballX
	sub	a, (hl)
	jr	NC, 00141$
;src/pong.c:132: ballX = INITBALLX, ballY = INITBALLY;
	ld	(hl), #0x54
	ld	hl, #_ballY
	ld	(hl), #0x48
;src/pong.c:133: spd_ballX = -spd_ballX;
	ld	hl, #_spd_ballX
	ld	(hl), c
;src/pong.c:134: player1_score++;
	ld	hl, #_player1_score
	inc	(hl)
	jr	NZ, 00276$
	inc	hl
	inc	(hl)
00276$:
;src/pong.c:135: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
	ld	hl, #_player2_score
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	hl, #_player1_score
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #_HUD
	push	de
	call	_printf
	add	sp, #6
00141$:
;src/pong.c:138: move_sprite(3, ballX, ballY);
	ld	hl, #_ballY
	ld	c, (hl)
	ld	hl, #_ballX
	ld	b, (hl)
;../../../include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;../../../include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/pong.c:141: wait_vbl_done();
	call	_wait_vbl_done
	jp	00143$
00155$:
;src/pong.c:143: }
	add	sp, #3
	ret
_HUD:
	.ascii " p1: %d   p2: %d"
	.db 0x00
___str_0:
	.ascii "Device must support"
	.db 0x0a
	.ascii "at least two joypads"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__sprite_data:
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x91	; 145
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x5a	; 90	'Z'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.area _CABS (ABS)
