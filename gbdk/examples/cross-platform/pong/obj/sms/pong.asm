;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module pong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init_pad
	.globl _printf
	.globl _gotoxy
	.globl _set_tile_2bpp_data
	.globl _joypad_ex
	.globl _joypad_init
	.globl _wait_vbl_done
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
;../../../include/sms/sms.h:684: shadow_OAM[0x41+(nb << 1)] = tile;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	de, #0x0041
	add	hl, de
	ld	de, #_shadow_OAM
	add	hl, de
	ld	(hl), c
;src/pong.c:18: set_sprite_tile((n << 2) + 1, n);
	ld	e, b
	inc	e
;../../../include/sms/sms.h:684: shadow_OAM[0x41+(nb << 1)] = tile;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	de, #0x0041
	add	hl, de
	ld	de, #_shadow_OAM
	add	hl, de
	ld	(hl), c
;src/pong.c:19: set_sprite_tile((n << 2) + 2, n);
	inc	b
	inc	b
;../../../include/sms/sms.h:684: shadow_OAM[0x41+(nb << 1)] = tile;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	de, #0x0041
	add	hl, de
	ld	de, #_shadow_OAM
	add	hl, de
	ld	(hl), c
;src/pong.c:19: set_sprite_tile((n << 2) + 2, n);
;src/pong.c:20: }
	ret
;src/pong.c:51: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/pong.c:56: set_sprite_data(0, 4, sprite_data);
;../../../include/sms/sms.h:537: set_tile_2bpp_data((uint8_t)(start) + 0x100u, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_sprite_data
	push	hl
	ld	hl, #0x0004
	push	hl
	ld	hl, #0x0100
	push	hl
	call	_set_tile_2bpp_data
;src/pong.c:59: init_pad(0);
	xor	a, a
	call	_init_pad
;src/pong.c:60: init_pad(1);
	ld	a, #0x01
	call	_init_pad
;../../../include/sms/sms.h:684: shadow_OAM[0x41+(nb << 1)] = tile;
	ld	hl, #(_shadow_OAM + 71)
	ld	(hl), #0x02
;src/pong.c:69: if (joypad_init(2, &joypads) != 2) {
	ld	hl, #_joypads
	push	hl
	ld	a, #0x02
	push	af
	inc	sp
	call	_joypad_init
	ld	a, l
	sub	a, #0x02
	jr	Z, 00102$
;src/pong.c:70: printf("Device must support\nat least two joypads");
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
;src/pong.c:71: return;
	jp	00156$
00102$:
;src/pong.c:75: player1 = 64, player2 = 64;
	ld	hl, #_player1
	ld	(hl), #0x40
	ld	hl, #_player2
	ld	(hl), #0x40
;src/pong.c:76: player1_score = player2_score = 0;
	ld	hl, #0x0000
	ld	(_player2_score), hl
	ld	(_player1_score), hl
;src/pong.c:79: printf(HUD, player1_score, player2_score);
	push	hl
	push	hl
	ld	hl, #_HUD
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	af
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
	ld	hl, #_joypads
	call	_joypad_ex
;src/pong.c:90: if (joypads.joy0 & J_UP) {
	ld	hl, #_joypads + 1
	ld	c, (hl)
;src/pong.c:91: player1 -= 2;
	ld	a, (_player1+0)
;src/pong.c:90: if (joypads.joy0 & J_UP) {
	bit	0, c
	jr	Z, 00110$
;src/pong.c:91: player1 -= 2;
	ld	hl, #_player1
	add	a, #0xfe
	ld	(hl), a
;src/pong.c:92: if (player1 < YMIN) player1 = YMIN;
	ld	a, (_player1+0)
	sub	a, #0x1c
	jr	NC, 00111$
	ld	hl, #_player1
	ld	(hl), #0x1c
	jr	00111$
00110$:
;src/pong.c:93: } else if (joypads.joy0 & J_DOWN) {
	bit	1, c
	jr	Z, 00111$
;src/pong.c:94: player1 += 2;
	add	a, #0x02
	ld	(_player1+0), a
;src/pong.c:95: if (player1 > YMAX) player1 = YMAX;            
	ld	a, #0x64
	ld	iy, #_player1
	sub	a, 0 (iy)
	jr	NC, 00111$
	ld	0 (iy), #0x64
00111$:
;src/pong.c:97: draw_pad(0, PLAYER1_X, player1);
	ld	a, (_player1+0)
	ld	c, a
	ld	-3 (ix), c
;../../../include/sms/sms.h:720: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	a, c
	sub	a, #0xd0
	jr	NC, 00158$
	ld	-2 (ix), c
	ld	-1 (ix), #0x00
	jr	00159$
00158$:
	ld	-2 (ix), #0xc0
	ld	-1 (ix), #0
00159$:
	ld	a, -2 (ix)
	ld	(#_shadow_OAM),a
;../../../include/sms/sms.h:721: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 64)
	ld	(hl), #0x00
;src/pong.c:25: move_sprite((n << 2) + 1, x, y + 8);
	ld	c, -3 (ix)
	ld	a, c
	add	a, #0x08
;../../../include/sms/sms.h:720: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	e, a
	sub	a, #0xd0
	jr	C, 00161$
	ld	de, #0x00c0
00161$:
	ld	hl, #(_shadow_OAM + 1)
	ld	(hl), e
;../../../include/sms/sms.h:721: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 66)
	ld	(hl), #0x00
;src/pong.c:26: move_sprite((n << 2) + 2, x, y + 16);
	ld	a, c
	add	a, #0x10
;../../../include/sms/sms.h:720: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	e, a
	sub	a, #0xd0
	jr	C, 00163$
	ld	de, #0x00c0
00163$:
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), e
;../../../include/sms/sms.h:721: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 68)
	ld	(hl), #0x00
;src/pong.c:100: if (joypads.joy1 & J_UP) {
	ld	hl, #_joypads + 2
	ld	c, (hl)
;src/pong.c:101: player2 -= 2;
	ld	a, (_player2+0)
;src/pong.c:100: if (joypads.joy1 & J_UP) {
	bit	0, c
	jr	Z, 00119$
;src/pong.c:101: player2 -= 2;
	ld	hl, #_player2
	add	a, #0xfe
	ld	(hl), a
;src/pong.c:102: if (player2 < YMIN) player2 = YMIN;
	ld	a, (_player2+0)
	sub	a, #0x1c
	jr	NC, 00120$
	ld	hl, #_player2
	ld	(hl), #0x1c
	jr	00120$
00119$:
;src/pong.c:103: } else if (joypads.joy1 & J_DOWN) {
	bit	1, c
	jr	Z, 00120$
;src/pong.c:104: player2 += 2;
	add	a, #0x02
	ld	(_player2+0), a
;src/pong.c:105: if (player2 > YMAX) player2 = YMAX;            
	ld	a, #0x64
	ld	iy, #_player2
	sub	a, 0 (iy)
	jr	NC, 00120$
	ld	0 (iy), #0x64
00120$:
;src/pong.c:107: draw_pad(1, PLAYER2_X, player2);
	ld	a, (_player2+0)
;../../../include/sms/sms.h:720: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	e,a
	ld	c,a
	sub	a, #0xd0
	jr	C, 00165$
	ld	de, #0x00c0
00165$:
	ld	hl, #(_shadow_OAM + 4)
	ld	(hl), e
;../../../include/sms/sms.h:721: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 72)
	ld	(hl), #0xf8
;src/pong.c:25: move_sprite((n << 2) + 1, x, y + 8);
	ld	a, c
	add	a, #0x08
;../../../include/sms/sms.h:720: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	e, a
	sub	a, #0xd0
	jr	C, 00167$
	ld	de, #0x00c0
00167$:
	ld	hl, #(_shadow_OAM + 5)
	ld	(hl), e
;../../../include/sms/sms.h:721: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 74)
	ld	(hl), #0xf8
;src/pong.c:26: move_sprite((n << 2) + 2, x, y + 16);
	ld	a, c
	add	a, #0x10
;../../../include/sms/sms.h:720: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	e, a
	sub	a, #0xd0
	jr	NC, 00168$
	ld	d, #0x00
	jr	00169$
00168$:
	ld	de, #0x00c0
00169$:
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), e
;../../../include/sms/sms.h:721: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 76)
	ld	(hl), #0xf8
;src/pong.c:110: ballX += spd_ballX, ballY += spd_ballY;
	ld	a, (_ballX+0)
	ld	hl, #_spd_ballX
	add	a, (hl)
	ld	(_ballX+0), a
	ld	a, (_ballY+0)
	ld	hl, #_spd_ballY
	add	a, (hl)
	ld	(_ballY+0), a
;src/pong.c:112: if ((ballY < YMIN) || (ballY > (YMAX + 24))) {
	ld	a, (_ballY+0)
	sub	a, #0x1c
	jr	C, 00121$
	ld	a, #0x7c
	ld	hl, #_ballY
	sub	a, (hl)
	jr	NC, 00122$
00121$:
;src/pong.c:113: spd_ballY = -spd_ballY; 
	ld	hl, #_spd_ballY
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
00122$:
;src/pong.c:117: if ((ballY > player1) && (ballY < (player1 + 24)) && (spd_ballX < 0)) 
	ld	a, (_ballY+0)
	ld	-3 (ix), a
	ld	-2 (ix), #0x00
;src/pong.c:118: spd_ballX = -spd_ballX;
	ld	hl, #_spd_ballX
	xor	a, a
	sub	a, (hl)
	ld	-1 (ix), a
;src/pong.c:116: if (ballX < (PLAYER1_X + 8)) {
	ld	a, (_ballX+0)
	sub	a, #0x08
	jr	NC, 00135$
;src/pong.c:117: if ((ballY > player1) && (ballY < (player1 + 24)) && (spd_ballX < 0)) 
	ld	a, (#_player1)
	ld	hl, #_ballY
	sub	a, (hl)
	jr	NC, 00136$
	ld	a, (_player1+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	ld	de, #0x0018
	add	hl, de
	ld	a, -3 (ix)
	sub	a, l
	ld	a, -2 (ix)
	sbc	a, h
	jp	PO, 00317$
	xor	a, #0x80
00317$:
	jp	P, 00136$
	ld	a, (_spd_ballX+0)
	bit	7, a
	jr	Z, 00136$
;src/pong.c:118: spd_ballX = -spd_ballX;
	ld	a, -1 (ix)
	ld	(_spd_ballX+0), a
	jr	00136$
00135$:
;src/pong.c:119: } else if (ballX > (PLAYER2_X - 8)) {
	ld	a, #0xf0
	ld	hl, #_ballX
	sub	a, (hl)
	jr	NC, 00136$
;src/pong.c:120: if ((ballY > player2) && (ballY < (player2 + 24)) && (spd_ballX > 0)) 
	ld	a, (#_player2)
	ld	hl, #_ballY
	sub	a, (hl)
	jr	NC, 00136$
	ld	a, (_player2+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	ld	de, #0x0018
	add	hl, de
	ld	a, -3 (ix)
	sub	a, l
	ld	a, -2 (ix)
	sbc	a, h
	jp	PO, 00318$
	xor	a, #0x80
00318$:
	jp	P, 00136$
	xor	a, a
	ld	iy, #_spd_ballX
	sub	a, 0 (iy)
	jp	PO, 00319$
	xor	a, #0x80
00319$:
	jp	P, 00136$
;src/pong.c:121: spd_ballX = -spd_ballX;
	ld	a, -1 (ix)
	ld	(_spd_ballX+0), a
00136$:
;src/pong.c:118: spd_ballX = -spd_ballX;
	ld	hl, #_spd_ballX
	xor	a, a
	sub	a, (hl)
	ld	-1 (ix), a
;src/pong.c:124: if (ballX <= PLAYER1_X) {
	ld	a, (_ballX+0)
	or	a, a
	jr	NZ, 00140$
;src/pong.c:126: ballX = INITBALLX, ballY = INITBALLY;
	ld	a, #0x54
	ld	(#_ballX), a
	ld	a, #0x48
	ld	(#_ballY), a
;src/pong.c:127: spd_ballX = -spd_ballX;
	ld	a, -1 (ix)
	ld	(_spd_ballX+0), a
;src/pong.c:128: player2_score++;
	ld	hl, (_player2_score)
	inc	hl
	ld	(_player2_score), hl
;src/pong.c:129: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	ld	hl, #0x00
	push	hl
	call	_gotoxy
	pop	af
	ld	hl, (_player2_score)
	push	hl
	ld	hl, (_player1_score)
	push	hl
	ld	hl, #_HUD
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	af
	jr	00141$
00140$:
;src/pong.c:130: } else if (ballX > PLAYER2_X) {
	ld	a, #0xf8
	ld	iy, #_ballX
	sub	a, 0 (iy)
	jr	NC, 00141$
;src/pong.c:132: ballX = INITBALLX, ballY = INITBALLY;
	ld	0 (iy), #0x54
	ld	a, #0x48
	ld	(#_ballY), a
;src/pong.c:133: spd_ballX = -spd_ballX;
	ld	a, -1 (ix)
	ld	(_spd_ballX+0), a
;src/pong.c:134: player1_score++;
	ld	hl, (_player1_score)
	inc	hl
	ld	(_player1_score), hl
;src/pong.c:135: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	ld	hl, #0x00
	push	hl
	call	_gotoxy
	pop	af
	ld	hl, (_player2_score)
	push	hl
	ld	hl, (_player1_score)
	push	hl
	ld	hl, #_HUD
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	af
00141$:
;src/pong.c:138: move_sprite(3, ballX, ballY);
	ld	a, (_ballY+0)
	ld	e, a
	ld	a, (_ballX+0)
	ld	c, a
;../../../include/sms/sms.h:720: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	a, e
	sub	a, #0xd0
	jr	C, 00171$
	ld	de, #0x00c0
00171$:
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), e
;../../../include/sms/sms.h:721: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 70)
	ld	(hl), c
;src/pong.c:141: wait_vbl_done();
	call	_wait_vbl_done
	jp	00143$
00156$:
;src/pong.c:143: }
	ld	sp, ix
	pop	ix
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
