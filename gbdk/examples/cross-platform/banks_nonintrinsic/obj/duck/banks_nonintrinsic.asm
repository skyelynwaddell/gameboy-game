;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module banks_nonintrinsic
	.optsdcc -msm83
	
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
	ld	a, #0x01
	ldh	(__current_bank + 0), a
	ld	hl, #0x0001
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
	ld	a, #0x02
	ldh	(__current_bank + 0), a
	ld	hl, #0x0001
	ld	(hl), #0x02
	ret
;src/banks_nonintrinsic.c:31: void set_RAM_bank1(void) NONBANKED { SWITCH_RAM_BANK(0); }
;	---------------------------------
; Function set_RAM_bank1
; ---------------------------------
_set_RAM_bank1::
	ld	hl, #0x4000
	ld	(hl), #0x00
	ld	hl, #__current_ram_bank
	ld	(hl), #0x00
	ret
;src/banks_nonintrinsic.c:32: void set_RAM_bank2(void) NONBANKED { SWITCH_RAM_BANK(1); }
;	---------------------------------
; Function set_RAM_bank2
; ---------------------------------
_set_RAM_bank2::
	ld	hl, #0x4000
	ld	(hl), #0x01
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
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/banks_nonintrinsic.c:51: addendum1_ram = 2;
	ld	hl, #_addendum1_ram
	ld	a, #0x02
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks_nonintrinsic.c:52: addendum2_ram = 4;
	call	_set_RAM_bank2
	ld	hl, #_addendum2_ram
	ld	a, #0x04
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks_nonintrinsic.c:53: addendum3_ram = 8;
	ld	hl, #_addendum3_ram
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
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
	ld	a, e
	add	a, #<(_hello1)
	ld	e, a
	ld	a, d
	adc	a, #>(_hello1)
	ld	d, a
	ld	a, (de)
	ld	b, a
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
	push	af
	rlca
	sbc	a, a
	ld	b, a
	pop	af
	add	a, #<(_data)
	ld	e, a
	ld	a, b
	adc	a, #>(_data)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	inc	c
	jr	00131$
00105$:
;src/banks_nonintrinsic.c:63: for (int8_t i = 0; (hello1_ram[i]); i++) putchar(hello1_ram[i]);
	ld	c, #0x00
00134$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello1_ram
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	call	_set_RAM_bank1
	pop	bc
	inc	c
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
	ld	a, e
	add	a, #<(_hello2)
	ld	e, a
	ld	a, d
	adc	a, #>(_hello2)
	ld	d, a
	ld	a, (de)
	ld	b, a
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
	ld	a, c
	push	af
	rlca
	sbc	a, a
	ld	b, a
	pop	af
	add	a, #<(_data)
	ld	e, a
	ld	a, b
	adc	a, #>(_data)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
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
	ld	de, #___str_2
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
	ld	de, #___str_2
	call	_puts
;src/banks_nonintrinsic.c:80: printf("%s", hello0);
	ld	de, #_hello0
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:81: printf("%s", switch_to(hello1));    
	call	_set_ROM_bank1
	ld	a, (#_hello1 + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello1
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:82: printf("%s", switch_to(hello2));
	call	_set_ROM_bank2
	ld	a, (#_hello2 + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello2
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:83: printf("%s", switch_to(hello1_ram));
	call	_set_RAM_bank1
	ld	a, (#_hello1_ram + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello1_ram
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:84: printf("%s", switch_to(hello2_ram));
	call	_set_RAM_bank2
	ld	a, (#_hello2_ram + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello2_ram
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:86: printf("1+2+4+8=0x%x", (int)(addendum0 + addendum1_ram + (*addendum_ptr[0]) + (*addendum_ptr[1])));
	call	_set_RAM_bank1
	ld	a, (#_addendum0)
	ld	hl, #_addendum1_ram
	add	a, (hl)
	ld	c, a
	ld	a, (#_addendum0 + 1)
	ld	hl, #_addendum1_ram + 1
	adc	a, (hl)
	ld	b, a
	push	bc
	call	_set_ROM_bank1
	pop	bc
	ld	hl, #_addendum_ptr
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	bc
	call	_set_RAM_bank1
	pop	bc
	pop	hl
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	bc
	call	_set_ROM_bank1
	pop	bc
	pop	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_addendum_ptr + 2)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	bc
	call	_set_RAM_bank1
	pop	bc
	pop	hl
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ld	de, #___str_5
	push	de
	call	_printf
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
