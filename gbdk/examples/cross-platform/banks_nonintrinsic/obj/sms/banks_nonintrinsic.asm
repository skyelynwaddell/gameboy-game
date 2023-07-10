;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module banks_nonintrinsic
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_RAM_bank2
	.globl _set_RAM_bank1
	.globl _set_ROM_bank2
	.globl _set_ROM_bank1
	.globl _puts
	.globl _printf
	.globl _putchar
	.globl _addendum_ptr
	.globl _hello1
	.globl _hello2
	.globl _addendum1_ram
	.globl _hello1_ram
	.globl _addendum3_ram
	.globl _addendum2_ram
	.globl _hello2_ram
	.globl _addendum0
	.globl _data
	.globl __current_ram_bank
	.globl ___dummy_variable
	.globl _hello0
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
___dummy_variable::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
__current_ram_bank::
	.ds 1
_data::
	.ds 20
_addendum0::
	.ds 2
;--------------------------------------------------------
; DATA_1 ram data
;--------------------------------------------------------
	.area _DATA_1
_hello2_ram::
	.ds 20
_addendum2_ram::
	.ds 2
_addendum3_ram::
	.ds 2
;--------------------------------------------------------
; DATA_0 ram data
;--------------------------------------------------------
	.area _DATA_0
_hello1_ram::
	.ds 20
_addendum1_ram::
	.ds 2
;--------------------------------------------------------
; CODE_2 rom data
;--------------------------------------------------------
	.area _CODE_2
_hello2:
	.ascii "hello from CODE_2"
	.db 0x0a
	.db 0x00
;--------------------------------------------------------
; CODE_1 rom data
;--------------------------------------------------------
	.area _CODE_1
_hello1:
	.ascii "hello from CODE_1"
	.db 0x0a
	.db 0x00
_addendum_ptr:
	.dw _addendum2_ram
	.dw _addendum3_ram
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
;src/banks_nonintrinsic.c:20: void set_ROM_bank1(void) NONBANKED { SWITCH_ROM(1); }
;	---------------------------------
; Function set_ROM_bank1
; ---------------------------------
_set_ROM_bank1::
	ld	hl, #_MAP_FRAME1
	ld	(hl), #0x01
	ret
_hello0:
	.ascii "hello from CODE"
	.db 0x0a
	.db 0x00
;src/banks_nonintrinsic.c:21: void set_ROM_bank2(void) NONBANKED { SWITCH_ROM(2); }
;	---------------------------------
; Function set_ROM_bank2
; ---------------------------------
_set_ROM_bank2::
	ld	hl, #_MAP_FRAME1
	ld	(hl), #0x02
	ret
;src/banks_nonintrinsic.c:31: void set_RAM_bank1(void) NONBANKED { SWITCH_RAM_BANK(0); }
;	---------------------------------
; Function set_RAM_bank1
; ---------------------------------
_set_RAM_bank1::
	ld	a, (_RAM_CONTROL+0)
	and	a, #0xfb
	ld	(_RAM_CONTROL+0), a
	ld	hl, #__current_ram_bank
	ld	(hl), #0x00
	ret
;src/banks_nonintrinsic.c:32: void set_RAM_bank2(void) NONBANKED { SWITCH_RAM_BANK(1); }
;	---------------------------------
; Function set_RAM_bank2
; ---------------------------------
_set_RAM_bank2::
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x04
	ld	(_RAM_CONTROL+0), a
	ld	hl, #__current_ram_bank
	ld	(hl), #0x01
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/banks_nonintrinsic.c:48: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/banks_nonintrinsic.c:49: ENABLE_RAM;
	call	_set_RAM_bank1
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x08
	ld	(_RAM_CONTROL+0), a
;src/banks_nonintrinsic.c:51: addendum1_ram = 2;
	ld	hl, #0x0002
	ld	(_addendum1_ram), hl
;src/banks_nonintrinsic.c:52: addendum2_ram = 4;
	call	_set_RAM_bank2
	ld	hl, #0x0004
	ld	(_addendum2_ram), hl
;src/banks_nonintrinsic.c:53: addendum3_ram = 8;
	ld	l, #0x08
	ld	(_addendum3_ram), hl
;src/banks_nonintrinsic.c:56: for (int8_t i = 0; (hello0[i]); i++) putchar(hello0[i]);  
	ld	b, #0x00
00119$:
	ld	a, b
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello0
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00101$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	b
	jr	00119$
00101$:
;src/banks_nonintrinsic.c:57: for (int8_t i = 0; (hello1[i]); i++) putchar(hello1[i]);
	ld	c, #0x00
00122$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank1
	pop	de
	pop	bc
	ld	hl, #_hello1
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00122$
00102$:
;src/banks_nonintrinsic.c:58: for (int8_t i = 0; (hello2[i]); i++) putchar(hello2[i]);
	ld	c, #0x00
00125$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank2
	pop	de
	pop	bc
	ld	hl, #_hello2
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00125$
00103$:
;src/banks_nonintrinsic.c:61: for (int8_t i = 0; (i < sizeof(hello1)); i++) hello1_ram[i] = hello1[i];
	ld	c, #0x00
00128$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x93
	ld	a, #0x00
	rla
	ld	b, a
	push	bc
	call	_set_ROM_bank1
	pop	bc
	ld	a, b
	or	a, a
	jr	Z, 00104$
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello1_ram
	add	hl, de
	ld	iy, #_hello1
	add	iy, de
	ld	b, 0 (iy)
	push	hl
	push	bc
	call	_set_RAM_bank1
	pop	bc
	pop	hl
	ld	(hl), b
	inc	c
	jr	00128$
00104$:
;src/banks_nonintrinsic.c:62: for (int8_t i = 0; (i < 4); i++) hello1_ram[i + 11] = data[i];
	ld	c, #0x00
	push	bc
	call	_set_RAM_bank1
	pop	bc
00131$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x84
	jr	NC, 00105$
	ld	a, c
	add	a, #0x0b
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello1_ram
	add	hl, de
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	iy, #_data
	add	iy, de
	ld	a, 0 (iy)
	ld	(hl), a
	inc	c
	jr	00131$
00105$:
;src/banks_nonintrinsic.c:63: for (int8_t i = 0; (hello1_ram[i]); i++) putchar(hello1_ram[i]);
	ld	e, #0x00
00134$:
	ld	a, e
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, #_hello1_ram
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
	push	de
	push	af
	inc	sp
	call	_putchar
	inc	sp
	call	_set_RAM_bank1
	pop	de
	inc	e
	jr	00134$
00106$:
;src/banks_nonintrinsic.c:66: for (int8_t i = 0; (i < sizeof(hello2)); i++) hello2_ram[i] = hello2[i];
	ld	c, #0x00
00137$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x93
	ld	a, #0x00
	rla
	ld	b, a
	push	bc
	call	_set_ROM_bank2
	pop	bc
	ld	a, b
	or	a, a
	jr	Z, 00107$
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello2_ram
	add	hl, de
	ld	iy, #_hello2
	add	iy, de
	ld	b, 0 (iy)
	push	hl
	push	bc
	call	_set_RAM_bank2
	pop	bc
	pop	hl
	ld	(hl), b
	inc	c
	jr	00137$
00107$:
;src/banks_nonintrinsic.c:67: for (int8_t i = 0; (i < 4); i++) hello2_ram[i + 11] = data[i];
	ld	c, #0x00
	push	bc
	call	_set_RAM_bank2
	pop	bc
00140$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x84
	jr	NC, 00108$
	ld	a, c
	add	a, #0x0b
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello2_ram
	add	hl, de
	ex	de, hl
	ld	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	de
	ld	de, #_data
	add	hl, de
	pop	de
	ld	a, (hl)
	ld	(de), a
	inc	c
	jr	00140$
00108$:
;src/banks_nonintrinsic.c:68: for (int8_t i = 0; (hello2_ram[i]); i++) putchar(hello2_ram[i]);
	ld	c, #0x00
00143$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello2_ram
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00109$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	call	_set_RAM_bank2
	pop	bc
	inc	c
	jr	00143$
00109$:
;src/banks_nonintrinsic.c:70: printf("once more...\n");
	ld	hl, #___str_2
	call	_puts
;src/banks_nonintrinsic.c:72: for (int8_t i = 0; (hello0[i]); i++) putchar(hello0[i]);  
	ld	c, #0x00
00146$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello0
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00146$
00110$:
;src/banks_nonintrinsic.c:73: for (int8_t i = 0; (hello1[i]); i++) putchar(hello1[i]);
	ld	c, #0x00
00149$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank1
	pop	de
	pop	bc
	ld	hl, #_hello1
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00149$
00111$:
;src/banks_nonintrinsic.c:74: for (int8_t i = 0; (hello2[i]); i++) putchar(hello2[i]);
	ld	c, #0x00
00152$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank2
	pop	de
	pop	bc
	ld	hl, #_hello2
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00152$
00112$:
;src/banks_nonintrinsic.c:75: for (int8_t i = 0; (hello1_ram[i]); i++) putchar(hello1_ram[i]);
	ld	c, #0x00
00155$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_RAM_bank1
	pop	de
	pop	bc
	ld	hl, #_hello1_ram
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00155$
00113$:
;src/banks_nonintrinsic.c:76: for (int8_t i = 0; (hello2_ram[i]); i++) putchar(hello2_ram[i]);
	ld	c, #0x00
00158$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_RAM_bank2
	pop	de
	pop	bc
	ld	hl, #_hello2_ram
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00114$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00158$
00114$:
;src/banks_nonintrinsic.c:78: printf("once more...\n");
	ld	hl, #___str_2
	call	_puts
;src/banks_nonintrinsic.c:80: printf("%s", hello0);
	ld	hl, #_hello0
	push	hl
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks_nonintrinsic.c:81: printf("%s", switch_to(hello1));    
	call	_set_ROM_bank1
	ld	hl, #_hello1
	ld	a, (hl)
	ld	(___dummy_variable+0), a
	ld	hl, #_hello1
	push	hl
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks_nonintrinsic.c:82: printf("%s", switch_to(hello2));
	call	_set_ROM_bank2
	ld	hl, #_hello2
	ld	a, (hl)
	ld	(___dummy_variable+0), a
	ld	hl, #_hello2
	push	hl
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks_nonintrinsic.c:83: printf("%s", switch_to(hello1_ram));
	call	_set_RAM_bank1
	ld	hl, #_hello1_ram
	ld	a, (hl)
	ld	(___dummy_variable+0), a
	ld	hl, #_hello1_ram
	push	hl
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks_nonintrinsic.c:84: printf("%s", switch_to(hello2_ram));
	call	_set_RAM_bank2
	ld	hl, #_hello2_ram
	ld	a, (hl)
	ld	(___dummy_variable+0), a
	ld	hl, #_hello2_ram
	push	hl
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks_nonintrinsic.c:86: printf("1+2+4+8=0x%x", (int)(addendum0 + addendum1_ram + (*addendum_ptr[0]) + (*addendum_ptr[1])));
	call	_set_RAM_bank1
	ld	hl, #_addendum1_ram
	ld	a, (_addendum0+0)
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, (_addendum0+1)
	adc	a, (hl)
	ld	b, a
	push	bc
	call	_set_ROM_bank1
	pop	bc
	ld	hl, (#_addendum_ptr + 0)
	push	hl
	push	bc
	call	_set_RAM_bank1
	pop	bc
	pop	hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	push	bc
	call	_set_ROM_bank1
	pop	bc
	pop	hl
	add	hl, bc
	ex	de, hl
	ld	hl, (#_addendum_ptr + 2)
	push	hl
	push	de
	call	_set_RAM_bank1
	pop	de
	pop	hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
	add	hl, de
	ld	bc, #___str_5+0
	push	hl
	push	bc
	call	_printf
	pop	af
	pop	af
;src/banks_nonintrinsic.c:89: while(1);
00116$:
;src/banks_nonintrinsic.c:90: }
	jr	00116$
___str_2:
	.ascii "once more..."
	.db 0x00
___str_4:
	.ascii "%s"
	.db 0x00
___str_5:
	.ascii "1+2+4+8=0x%x"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit___current_ram_bank:
	.db #0x00	; 0
__xinit__data:
	.ascii "DATA"
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
__xinit__addendum0:
	.dw #0x0001
	.area _CABS (ABS)
