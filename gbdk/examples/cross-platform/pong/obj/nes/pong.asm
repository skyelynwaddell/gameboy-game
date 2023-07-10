;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module pong
	.optsdcc -mmos6502
	
	.globl __TEMP
	.globl __DPTR
	.area ZP      (PAG)
__TEMP:	.ds 8
__DPTR:	.ds 2
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _HUD
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
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area ZP      (PAG)
_main_sloc0_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
	.area	OSEG    (PAG, OVR)
_init_pad_sloc0_1_0:
	.ds 1
;--------------------------------------------------------
; uninitialized external ram data
;--------------------------------------------------------
	.area BSS
_init_pad_n_65536_70:
	.ds 1
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
; absolute external ram data
;--------------------------------------------------------
	.area DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area DATA
_sprite_data::
	.ds 64
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
;Allocation info for local variables in function 'init_pad'
;------------------------------------------------------------
;n                         Allocated with name '_init_pad_n_65536_70'
;__1310720006              Allocated to registers a 
;__1310720007              Allocated to registers 
;nb                        Allocated to registers 
;tile                      Allocated to registers 
;__1310720009              Allocated to registers a 
;__1310720010              Allocated to registers 
;nb                        Allocated to registers 
;tile                      Allocated to registers 
;__1310720012              Allocated to registers a 
;__1310720013              Allocated to registers 
;nb                        Allocated to registers 
;tile                      Allocated to registers 
;sloc0                     Allocated with name '_init_pad_sloc0_1_0'
;------------------------------------------------------------
;	src/pong.c: 16: void init_pad(uint8_t n) {
;	-----------------------------------------
;	 function init_pad
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_init_pad:
	sta	_init_pad_n_65536_70
;	src/pong.c: 17: set_sprite_tile(n << 2, n);
	lda	_init_pad_n_65536_70
	asl	a
	asl	a
	sta	*_init_pad_sloc0_1_0
	lda	*_init_pad_sloc0_1_0
;	../../../include/nes/nes.h: 723: shadow_OAM[nb].tile=tile;
	ldx	#0x00
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_shadow_OAM
	pha
	txa
	adc	#>_shadow_OAM
	tax
	pla
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_init_pad_n_65536_70
	ldy	#0x01
	sta	[__DPTR],y
;	src/pong.c: 18: set_sprite_tile((n << 2) + 1, n);
	lda	*_init_pad_sloc0_1_0
	clc
	adc	#0x01
;	../../../include/nes/nes.h: 723: shadow_OAM[nb].tile=tile;
	ldx	#0x00
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_shadow_OAM
	pha
	txa
	adc	#>_shadow_OAM
	tax
	pla
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_init_pad_n_65536_70
	sta	[__DPTR],y
;	src/pong.c: 19: set_sprite_tile((n << 2) + 2, n);
	lda	*_init_pad_sloc0_1_0
	clc
	adc	#0x02
;	../../../include/nes/nes.h: 723: shadow_OAM[nb].tile=tile;
	ldx	#0x00
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_shadow_OAM
	pha
	txa
	adc	#>_shadow_OAM
	tax
	pla
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_init_pad_n_65536_70
	sta	[__DPTR],y
;	src/pong.c: 19: set_sprite_tile((n << 2) + 2, n);
00104$:
;	src/pong.c: 20: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;__1310720027              Allocated to registers 
;__1310720028              Allocated to registers 
;nb                        Allocated to registers 
;tile                      Allocated to registers 
;__1966080030              Allocated to registers 
;__1966080031              Allocated to registers 
;__1966080032              Allocated to registers a 
;n                         Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers x 
;__1310720015              Allocated to registers 
;__1310720016              Allocated to registers 
;__1310720017              Allocated to registers 
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated to registers 
;__1310720019              Allocated to registers 
;__1310720020              Allocated to registers 
;__1310720021              Allocated to registers a 
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated to registers 
;__1310720023              Allocated to registers 
;__1310720024              Allocated to registers 
;__1310720025              Allocated to registers a 
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated to registers 
;__1966080034              Allocated to registers 
;__1966080035              Allocated to registers 
;__1966080036              Allocated to registers a 
;n                         Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers x 
;__1310720015              Allocated to registers 
;__1310720016              Allocated to registers 
;__1310720017              Allocated to registers 
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated to registers 
;__1310720019              Allocated to registers 
;__1310720020              Allocated to registers 
;__1310720021              Allocated to registers a 
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated to registers 
;__1310720023              Allocated to registers 
;__1310720024              Allocated to registers 
;__1310720025              Allocated to registers a 
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated to registers 
;__1966080038              Allocated to registers 
;__1966080039              Allocated to registers 
;__1966080040              Allocated to registers 
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated to registers 
;------------------------------------------------------------
;	src/pong.c: 51: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/pong.c: 56: set_sprite_data(0, 4, sprite_data);
	lda	#_sprite_data
	sta	_set_sprite_data_PARM_3
	lda	#>_sprite_data
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#0x00
	ldx	#0x04
	jsr	_set_sprite_data
;	src/pong.c: 59: init_pad(0);
	lda	#0x00
	jsr	_init_pad
;	src/pong.c: 60: init_pad(1);
	lda	#0x01
	jsr	_init_pad
;	../../../include/nes/nes.h: 723: shadow_OAM[nb].tile=tile;
	ldx	#0x02
	stx	(_shadow_OAM + 0x000d)
;	src/pong.c: 66: SHOW_BKG; SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	src/pong.c: 69: if (joypad_init(2, &joypads) != 2) {
	lda	#_joypads
	sta	_joypad_init_PARM_2
	lda	#>_joypads
	sta	(_joypad_init_PARM_2 + 1)
	txa
	jsr	_joypad_init
	cmp	#0x02
	bne	00241$
	jmp	00102$
00241$:
;	src/pong.c: 70: printf("Device must support\nat least two joypads");
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	lda	*(__TEMP+0)
;	src/pong.c: 71: return;
	jmp	00155$
00102$:
;	src/pong.c: 75: player1 = 64, player2 = 64;
	ldx	#0x40
	stx	_player1
	stx	_player2
;	src/pong.c: 76: player1_score = player2_score = 0;
	ldx	#0x00
	stx	_player2_score
	stx	(_player2_score + 1)
	stx	_player1_score
	stx	(_player1_score + 1)
;	src/pong.c: 79: printf(HUD, player1_score, player2_score);
	txa
	pha
	pha
	pha
	pha
	lda	#>_HUD
	pha
	lda	#_HUD
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	pla
	pla
	pla
	pla
	lda	*(__TEMP+0)
;	src/pong.c: 82: ballX = INITBALLX, ballY = INITBALLY;
	ldx	#0x54
	stx	_ballX
	ldx	#0x48
	stx	_ballY
;	src/pong.c: 83: spd_ballX = 1, spd_ballY = 1;
	ldx	#0x01
	stx	_spd_ballX
	stx	_spd_ballY
;	src/pong.c: 85: while(1) {
00143$:
;	src/pong.c: 87: joypad_ex(&joypads);
	ldx	#>_joypads
	lda	#_joypads
	jsr	_joypad_ex
;	src/pong.c: 90: if (joypads.joy0 & J_UP) {
	ldx	(_joypads + 0x0001)
	lda	#0x10
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00242$
	jmp	00110$
00242$:
;	src/pong.c: 91: player1 -= 2;
	lda	_player1
	sec
	sbc	#0x02
	sta	_player1
;	src/pong.c: 92: if (player1 < YMIN) player1 = YMIN;
	lda	_player1
	cmp	#0x1c
	bcc	00243$
	jmp	00111$
00243$:
	ldx	#0x1c
	stx	_player1
	jmp	00111$
00110$:
;	src/pong.c: 93: } else if (joypads.joy0 & J_DOWN) {
	lda	#0x20
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00244$
	jmp	00111$
00244$:
;	src/pong.c: 94: player1 += 2;
	lda	_player1
	clc
	adc	#0x02
	sta	_player1
;	src/pong.c: 95: if (player1 > YMAX) player1 = YMAX;            
	lda	_player1
	cmp	#0x64
	beq	00246$
	bcs	00245$
00246$:
	jmp	00111$
00245$:
	ldx	#0x64
	stx	_player1
00111$:
;	src/pong.c: 97: draw_pad(0, PLAYER1_X, player1);
	lda	_player1
	tax
;	../../../include/nes/nes.h: 793: OAM_item_t * itm = &shadow_OAM[nb];
;	../../../include/nes/nes.h: 794: itm->y=y, itm->x=x;
	sta	_shadow_OAM
	ldy	#0x00
	sty	(_shadow_OAM + 0x0003)
;	src/pong.c: 25: move_sprite((n << 2) + 1, x, y + 8);
	txa
	clc
	adc	#0x08
;	../../../include/nes/nes.h: 793: OAM_item_t * itm = &shadow_OAM[nb];
;	../../../include/nes/nes.h: 794: itm->y=y, itm->x=x;
	sta	(_shadow_OAM + 0x0004)
	sty	(_shadow_OAM + 0x0007)
;	src/pong.c: 26: move_sprite((n << 2) + 2, x, y + 16);
	txa
	clc
	adc	#0x10
;	../../../include/nes/nes.h: 793: OAM_item_t * itm = &shadow_OAM[nb];
;	../../../include/nes/nes.h: 794: itm->y=y, itm->x=x;
	sta	(_shadow_OAM + 0x0008)
	sty	(_shadow_OAM + 0x000b)
;	src/pong.c: 100: if (joypads.joy1 & J_UP) {
	ldx	(_joypads + 0x0002)
	lda	#0x10
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00247$
	jmp	00119$
00247$:
;	src/pong.c: 101: player2 -= 2;
	lda	_player2
	sec
	sbc	#0x02
	sta	_player2
;	src/pong.c: 102: if (player2 < YMIN) player2 = YMIN;
	lda	_player2
	cmp	#0x1c
	bcc	00248$
	jmp	00120$
00248$:
	ldx	#0x1c
	stx	_player2
	jmp	00120$
00119$:
;	src/pong.c: 103: } else if (joypads.joy1 & J_DOWN) {
	lda	#0x20
	stx	*(__TEMP+0)
	and	*(__TEMP+0)
	bne	00249$
	jmp	00120$
00249$:
;	src/pong.c: 104: player2 += 2;
	lda	_player2
	clc
	adc	#0x02
	sta	_player2
;	src/pong.c: 105: if (player2 > YMAX) player2 = YMAX;            
	lda	_player2
	cmp	#0x64
	beq	00251$
	bcs	00250$
00251$:
	jmp	00120$
00250$:
	ldx	#0x64
	stx	_player2
00120$:
;	src/pong.c: 107: draw_pad(1, PLAYER2_X, player2);
	lda	_player2
	tax
;	../../../include/nes/nes.h: 793: OAM_item_t * itm = &shadow_OAM[nb];
;	../../../include/nes/nes.h: 794: itm->y=y, itm->x=x;
	sta	(_shadow_OAM + 0x0010)
	ldy	#0xf8
	sty	(_shadow_OAM + 0x0013)
;	src/pong.c: 25: move_sprite((n << 2) + 1, x, y + 8);
	txa
	clc
	adc	#0x08
;	../../../include/nes/nes.h: 793: OAM_item_t * itm = &shadow_OAM[nb];
;	../../../include/nes/nes.h: 794: itm->y=y, itm->x=x;
	sta	(_shadow_OAM + 0x0014)
	sty	(_shadow_OAM + 0x0017)
;	src/pong.c: 26: move_sprite((n << 2) + 2, x, y + 16);
	txa
	clc
	adc	#0x10
;	../../../include/nes/nes.h: 793: OAM_item_t * itm = &shadow_OAM[nb];
;	../../../include/nes/nes.h: 794: itm->y=y, itm->x=x;
	sta	(_shadow_OAM + 0x0018)
	sty	(_shadow_OAM + 0x001b)
;	src/pong.c: 110: ballX += spd_ballX, ballY += spd_ballY;
	lda	_ballX
	clc
	adc	_spd_ballX
	sta	_ballX
	lda	_ballY
	clc
	adc	_spd_ballY
	sta	_ballY
;	src/pong.c: 112: if ((ballY < YMIN) || (ballY > (YMAX + 24))) {
	lda	_ballY
	cmp	#0x1c
	bcs	00252$
	jmp	00121$
00252$:
	lda	_ballY
	cmp	#0x7c
	beq	00254$
	bcs	00253$
00254$:
	jmp	00122$
00253$:
00121$:
;	src/pong.c: 113: spd_ballY = -spd_ballY; 
	lda	_spd_ballY
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballY
00122$:
;	src/pong.c: 116: if (ballX < (PLAYER1_X + 8)) {
	lda	_ballX
	cmp	#0x08
	bcc	00255$
	jmp	00135$
00255$:
;	src/pong.c: 117: if ((ballY > player1) && (ballY < (player1 + 24)) && (spd_ballX < 0)) 
	lda	_ballY
	cmp	_player1
	beq	00257$
	bcs	00256$
00257$:
	jmp	00136$
00256$:
	lda	_player1
	ldx	#0x00
	clc
	adc	#0x18
	sta	*_main_sloc0_1_0
	txa
	adc	#0x00
	sta	*(_main_sloc0_1_0 + 1)
	lda	_ballY
	sec
	sbc	*_main_sloc0_1_0
	txa
	sbc	*(_main_sloc0_1_0 + 1)
	bvc	00259$
	bpl	00258$
	bmi	00260$
00259$:
	bmi	00258$
00260$:
	jmp	00136$
00258$:
	lda	_spd_ballX
	sec
	sbc	#0x00
	bvc	00262$
	bpl	00261$
	bmi	00263$
00262$:
	bmi	00261$
00263$:
	jmp	00136$
00261$:
;	src/pong.c: 118: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
	jmp	00136$
00135$:
;	src/pong.c: 119: } else if (ballX > (PLAYER2_X - 8)) {
	lda	_ballX
	cmp	#0xf0
	beq	00265$
	bcs	00264$
00265$:
	jmp	00136$
00264$:
;	src/pong.c: 120: if ((ballY > player2) && (ballY < (player2 + 24)) && (spd_ballX > 0)) 
	lda	_ballY
	cmp	_player2
	beq	00267$
	bcs	00266$
00267$:
	jmp	00136$
00266$:
	lda	_player2
	ldx	#0x00
	clc
	adc	#0x18
	sta	*_main_sloc0_1_0
	txa
	adc	#0x00
	sta	*(_main_sloc0_1_0 + 1)
	lda	_ballY
	sec
	sbc	*_main_sloc0_1_0
	txa
	sbc	*(_main_sloc0_1_0 + 1)
	bvc	00269$
	bpl	00268$
	bmi	00270$
00269$:
	bmi	00268$
00270$:
	jmp	00136$
00268$:
	txa
	sec
	sbc	_spd_ballX
	bvc	00272$
	bpl	00271$
	bmi	00273$
00272$:
	bmi	00271$
00273$:
	jmp	00136$
00271$:
;	src/pong.c: 121: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
00136$:
;	src/pong.c: 124: if (ballX <= PLAYER1_X) {
	lda	_ballX
	beq	00274$
	jmp	00140$
00274$:
;	src/pong.c: 126: ballX = INITBALLX, ballY = INITBALLY;
	ldx	#0x54
	stx	_ballX
	ldx	#0x48
	stx	_ballY
;	src/pong.c: 127: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
;	src/pong.c: 128: player2_score++;
	inc	_player2_score
	bne	00275$
	inc	(_player2_score + 1)
00275$:
;	src/pong.c: 129: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	lda	#0x00
	tax
	jsr	_gotoxy
	lda	(_player2_score + 1)
	pha
	lda	_player2_score
	pha
	lda	(_player1_score + 1)
	pha
	lda	_player1_score
	pha
	lda	#>_HUD
	pha
	lda	#_HUD
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	pla
	pla
	pla
	pla
	lda	*(__TEMP+0)
	jmp	00141$
00140$:
;	src/pong.c: 130: } else if (ballX > PLAYER2_X) {
	lda	_ballX
	cmp	#0xf8
	beq	00277$
	bcs	00276$
00277$:
	jmp	00141$
00276$:
;	src/pong.c: 132: ballX = INITBALLX, ballY = INITBALLY;
	ldx	#0x54
	stx	_ballX
	ldx	#0x48
	stx	_ballY
;	src/pong.c: 133: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
;	src/pong.c: 134: player1_score++;
	inc	_player1_score
	bne	00278$
	inc	(_player1_score + 1)
00278$:
;	src/pong.c: 135: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	lda	#0x00
	tax
	jsr	_gotoxy
	lda	(_player2_score + 1)
	pha
	lda	_player2_score
	pha
	lda	(_player1_score + 1)
	pha
	lda	_player1_score
	pha
	lda	#>_HUD
	pha
	lda	#_HUD
	pha
	jsr	_printf
	sta	*(__TEMP+0)
	pla
	pla
	pla
	pla
	pla
	pla
	lda	*(__TEMP+0)
00141$:
;	../../../include/nes/nes.h: 793: OAM_item_t * itm = &shadow_OAM[nb];
;	../../../include/nes/nes.h: 794: itm->y=y, itm->x=x;
	lda	_ballY
	sta	(_shadow_OAM + 0x000c)
	lda	_ballX
	sta	(_shadow_OAM + 0x000f)
;	src/pong.c: 141: wait_vbl_done();
	jsr	_wait_vbl_done
	jmp	00143$
00155$:
;	src/pong.c: 143: }
	rts
	.area CODE
	.area RODATA
_HUD:
	.ascii " p1: %d   p2: %d"
	.db 0x00
	.area RODATA
___str_0:
	.ascii "Device must support"
	.db 0x0a
	.ascii "at least two joypads"
	.db 0x00
	.area CODE
	.area XINIT
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
	.area CABS    (ABS)
