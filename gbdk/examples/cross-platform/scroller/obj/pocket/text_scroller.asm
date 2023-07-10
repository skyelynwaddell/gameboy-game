;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module text_scroller
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _scanline_isr
	.globl _printf
	.globl _get_bkg_xy_addr
	.globl _set_vram_byte
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _add_LCD
	.globl _scroller_next_char
	.globl _scroller_x
	.globl _scanline_offsets
	.globl _limit
	.globl _base
	.globl _scroller_vram_addr
	.globl _scroller_text
	.globl _scanline_offsets_tbl
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_scroller_vram_addr::
	.ds 2
_base::
	.ds 2
_limit::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_scanline_offsets::
	.ds 2
_scroller_x::
	.ds 1
_scroller_next_char::
	.ds 2
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
;src/text_scroller.c:13: void scanline_isr() {
;	---------------------------------
; Function scanline_isr
; ---------------------------------
_scanline_isr::
;src/text_scroller.c:15: switch (LYC_REG) {
	ldh	a, (_LYC_REG + 0)
	or	a, a
	jr	Z, 00101$
	cp	a, #0x77
	jr	Z, 00102$
	sub	a, #0x7f
	jr	Z, 00103$
	ret
;src/text_scroller.c:16: case 0: 
00101$:
;src/text_scroller.c:17: SCX_REG = 0;
	xor	a, a
	ldh	(_SCX_REG + 0), a
;src/text_scroller.c:18: LYC_REG = SCROLL_POS_PIX_START;
	ld	a, #0x77
	ldh	(_LYC_REG + 0), a
;src/text_scroller.c:19: break;
	ret
;src/text_scroller.c:20: case SCROLL_POS_PIX_START:
00102$:
;src/text_scroller.c:21: SCX_REG = scroller_x;
	ld	a, (#_scroller_x)
	ldh	(_SCX_REG + 0), a
;src/text_scroller.c:22: LYC_REG = SCROLL_POS_PIX_END;
	ld	a, #0x7f
	ldh	(_LYC_REG + 0), a
;src/text_scroller.c:23: break;
	ret
;src/text_scroller.c:24: case SCROLL_POS_PIX_END:
00103$:
;src/text_scroller.c:25: SCX_REG = LYC_REG = 0;
	xor	a, a
	ldh	(_LYC_REG + 0), a
	xor	a, a
	ldh	(_SCX_REG + 0), a
;src/text_scroller.c:27: }
;src/text_scroller.c:37: }
	ret
_scanline_offsets_tbl:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
;src/text_scroller.c:48: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/text_scroller.c:49: printf(" Scrolling %d chars", sizeof(scroller_text) - 1);
	ld	de, #0x0168
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;src/text_scroller.c:56: }
	di
;src/text_scroller.c:52: add_LCD(scanline_isr);
	ld	de, #_scanline_isr
	push	de
	call	_add_LCD
	pop	hl
;src/text_scroller.c:54: STAT_REG |= STATF_LYC; LYC_REG = 0;
	ldh	a, (_STAT_REG + 0)
	or	a, #0x02
	ldh	(_STAT_REG + 0), a
	ld	a, #0x00
	ldh	(_LYC_REG + 0), a
	ei
;src/text_scroller.c:60: set_interrupts(VBL_IFLAG | LCD_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src/text_scroller.c:63: base = (uint8_t *)((uint16_t)get_bkg_xy_addr(0, SCROLL_POS) & (DEVICE_SCREEN_MAP_ENTRY_SIZE==1?0xffe0:0xffc0));
	ld	hl, #0xf00
	push	hl
	call	_get_bkg_xy_addr
	pop	hl
	ld	a, e
	and	a, #0xe0
	ld	hl, #_base
	ld	(hl+), a
;src/text_scroller.c:64: limit = base + (DEVICE_SCREEN_BUFFER_WIDTH * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	ld	a, d
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x20
	ld	(#_limit),a
	ld	a, (#_base + 1)
	adc	a, #0x00
	ld	(#_limit + 1),a
;src/text_scroller.c:66: scroller_vram_addr = base + ((DEVICE_SCREEN_X_OFFSET + DEVICE_SCREEN_WIDTH) * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	ld	a, (#_base)
	add	a, #0x14
	ld	(#_scroller_vram_addr),a
	ld	a, (#_base + 1)
	adc	a, #0x00
	ld	(#_scroller_vram_addr + 1),a
;src/text_scroller.c:67: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	ld	de, #_scroller_vram_addr
	ld	hl, #_limit
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00102$
	ld	a, (#_base)
	ld	(#_scroller_vram_addr),a
	ld	a, (#_base + 1)
	ld	(#_scroller_vram_addr + 1),a
00102$:
;src/text_scroller.c:69: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	ld	hl, #_scroller_next_char
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	add	a, #0xe0
	push	af
	inc	sp
	ld	hl, #_scroller_vram_addr
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_set_vram_byte
	add	sp, #3
;src/text_scroller.c:71: while (1) {
00110$:
;src/text_scroller.c:72: scroller_x++;
	ld	hl, #_scroller_x
	inc	(hl)
;src/text_scroller.c:73: if ((scroller_x & 0x07) == 0) {
	ld	a, (hl)
	and	a, #0x07
	jr	NZ, 00108$
;src/text_scroller.c:75: scroller_next_char++;
	ld	hl, #_scroller_next_char
	inc	(hl)
	jr	NZ, 00143$
	inc	hl
	inc	(hl)
00143$:
;src/text_scroller.c:76: if (*scroller_next_char == 0) scroller_next_char = scroller_text;
	ld	hl, #_scroller_next_char
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	or	a, a
	jr	NZ, 00104$
	dec	hl
	ld	a, #<(_scroller_text)
	ld	(hl+), a
	ld	(hl), #>(_scroller_text)
00104$:
;src/text_scroller.c:79: scroller_vram_addr += DEVICE_SCREEN_MAP_ENTRY_SIZE;
	ld	hl, #_scroller_vram_addr
	inc	(hl)
	jr	NZ, 00144$
	inc	hl
	inc	(hl)
00144$:
;src/text_scroller.c:80: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	ld	de, #_scroller_vram_addr
	ld	hl, #_limit
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00106$
	ld	a, (#_base)
	ld	(#_scroller_vram_addr),a
	ld	a, (#_base + 1)
	ld	(#_scroller_vram_addr + 1),a
00106$:
;src/text_scroller.c:83: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	ld	hl, #_scroller_next_char
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	add	a, #0xe0
	push	af
	inc	sp
	ld	hl, #_scroller_vram_addr
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_set_vram_byte
	add	sp, #3
00108$:
;src/text_scroller.c:85: wait_vbl_done();        
	call	_wait_vbl_done
;src/text_scroller.c:87: }
	jr	00110$
_scroller_text:
	.ascii "This is a text scroller demo for GBDK-2020. You can use idea"
	.ascii "s, that are shown in this demo, to make different parallax e"
	.ascii "ffects, scrolling of tilemaps which are larger than 32x32 ti"
	.ascii "les and TEXT SCROLLERS, of course! Need to write something e"
	.ascii "lse to make this text longer than 256 characters. The quick "
	.ascii "red fox jumps over the lazy brown dog. 0123456789.          "
	.db 0x00
___str_0:
	.ascii " Scrolling %d chars"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__scanline_offsets:
	.dw _scanline_offsets_tbl
__xinit__scroller_x:
	.db #0x00	; 0
__xinit__scroller_next_char:
	.dw _scroller_text
	.area _CABS (ABS)
