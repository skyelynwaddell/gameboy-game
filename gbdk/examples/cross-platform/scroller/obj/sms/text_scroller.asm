;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module text_scroller
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _scanline_isr
	.globl _printf
	.globl _get_bkg_xy_addr
	.globl _set_vram_byte
	.globl _wait_vbl_done
	.globl _add_LCD
	.globl _set_interrupts
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
;src/text_scroller.c:29: if (VCOUNTER == (SCROLL_POS_PIX_START - 8)) {
	in	a, (_VCOUNTER)
	sub	a, #0x6f
	jr	NZ, 00108$
;src/text_scroller.c:30: while (VCOUNTER != SCROLL_POS_PIX_START);
00101$:
	in	a, (_VCOUNTER)
	sub	a, #0x77
	jr	NZ, 00101$
;src/text_scroller.c:31: VDP_CMD = -scroller_x; VDP_CMD = VDP_RSCX;
	ld	hl, #_scroller_x
	xor	a, a
	sub	a, (hl)
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
;src/text_scroller.c:32: while (VCOUNTER != SCROLL_POS_PIX_START + 8);
00104$:
	in	a, (_VCOUNTER)
	sub	a, #0x7f
	ret	Z
	jr	00104$
00108$:
;src/text_scroller.c:34: VDP_CMD = 0; VDP_CMD = VDP_RSCX;
	ld	a, #0x00
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
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
	ld	hl, #0x0168
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
	pop	af
;src/text_scroller.c:56: }
	ld	a,i
	di
	push	af
;src/text_scroller.c:52: add_LCD(scanline_isr);
	ld	hl, #_scanline_isr
	call	_add_LCD
	pop	af
	jp	PO, 00140$
	ei
00140$:
;src/text_scroller.c:58: __WRITE_VDP_REG(VDP_R10, 0x07);
	ld	hl, #_shadow_VDP_R10
	ld	(hl), #0x07
	ld	a,i
	di
	push	af
	ld	a, #0x07
	out	(_VDP_CMD), a
	ld	a, #0x8a
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00142$
	ei
00142$:
;src/text_scroller.c:60: set_interrupts(VBL_IFLAG | LCD_IFLAG);
	ld	l, #0x03
;	spillPairReg hl
;	spillPairReg hl
	call	_set_interrupts
;src/text_scroller.c:62: HIDE_LEFT_COLUMN;    
	ld	a, (_shadow_VDP_R0+0)
	or	a, #0x20
	ld	(_shadow_VDP_R0+0), a
	ld	a,i
	di
	push	af
	ld	a, (_shadow_VDP_R0+0)
	out	(_VDP_CMD), a
	ld	a, #0x80
	out	(_VDP_CMD), a
	pop	af
	jp	PO, 00144$
	ei
00144$:
;src/text_scroller.c:63: base = (uint8_t *)((uint16_t)get_bkg_xy_addr(0, SCROLL_POS) & (DEVICE_SCREEN_MAP_ENTRY_SIZE==1?0xffe0:0xffc0));
	ld	hl, #0xf00
	push	hl
	call	_get_bkg_xy_addr
	ld	a, l
	and	a, #0xc0
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(_base), hl
;src/text_scroller.c:64: limit = base + (DEVICE_SCREEN_BUFFER_WIDTH * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	ld	hl, (_base)
	ld	de, #0x0040
	add	hl, de
	ld	(_limit), hl
;src/text_scroller.c:66: scroller_vram_addr = base + ((DEVICE_SCREEN_X_OFFSET + DEVICE_SCREEN_WIDTH) * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	ld	(_scroller_vram_addr), hl
;src/text_scroller.c:67: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	ld	hl, #_limit
	ld	a, (_scroller_vram_addr+0)
	sub	a, (hl)
	inc	hl
	ld	a, (_scroller_vram_addr+1)
	sbc	a, (hl)
	jr	C, 00102$
	ld	hl, (_base)
	ld	(_scroller_vram_addr), hl
00102$:
;src/text_scroller.c:69: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	ld	hl, (_scroller_next_char)
	ld	a, (hl)
	add	a, #0xe0
	push	af
	inc	sp
	ld	hl, (_scroller_vram_addr)
	push	hl
	call	_set_vram_byte
;src/text_scroller.c:71: while (1) {
00110$:
;src/text_scroller.c:72: scroller_x++;
	ld	hl, #_scroller_x
	inc	(hl)
;src/text_scroller.c:73: if ((scroller_x & 0x07) == 0) {
	ld	a, (_scroller_x+0)
	and	a, #0x07
	jr	NZ, 00108$
;src/text_scroller.c:75: scroller_next_char++;
	ld	hl, (_scroller_next_char)
	inc	hl
	ld	(_scroller_next_char), hl
;src/text_scroller.c:76: if (*scroller_next_char == 0) scroller_next_char = scroller_text;
	ld	hl, (_scroller_next_char)
	ld	a, (hl)
	or	a, a
	jr	NZ, 00104$
	ld	hl, #_scroller_text+0
	ld	(_scroller_next_char), hl
00104$:
;src/text_scroller.c:79: scroller_vram_addr += DEVICE_SCREEN_MAP_ENTRY_SIZE;
	ld	hl, (_scroller_vram_addr)
	inc	hl
	inc	hl
	ld	(_scroller_vram_addr), hl
;src/text_scroller.c:80: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	ld	hl, #_limit
	ld	a, (_scroller_vram_addr+0)
	sub	a, (hl)
	inc	hl
	ld	a, (_scroller_vram_addr+1)
	sbc	a, (hl)
	jr	C, 00106$
	ld	hl, (_base)
	ld	(_scroller_vram_addr), hl
00106$:
;src/text_scroller.c:83: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	ld	hl, (_scroller_next_char)
	ld	a, (hl)
	add	a, #0xe0
	push	af
	inc	sp
	ld	hl, (_scroller_vram_addr)
	push	hl
	call	_set_vram_byte
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
