;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module emu_debug
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _EMU_printf
	.globl _puts
	.globl _printf
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
;src/emu_debug.c:26: int main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/emu_debug.c:29: DISPLAY_ON;
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
	jp	PO, 00118$
	ei
00118$:
;src/emu_debug.c:32: printf("Message to the\nScreen\n");
	ld	hl, #___str_1
	call	_puts
;src/emu_debug.c:35: EMU_MESSAGE(""); // new line
	.MACRO EMULOG35 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG35 ^/""/ 
;src/emu_debug.c:36: EMU_MESSAGE("Message to the EMU console");
	.MACRO EMULOG36 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG36 ^/"Message to the EMU console"/ 
;src/emu_debug.c:53: }
	ld	a,i
	di
	push	af
;src/emu_debug.c:50: EMU_PROFILE_BEGIN("Profile a single NOP instruction at Normal Speed");
	.MACRO EMULOG50 msg_t, msg_s, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
	.ascii msg_s 
llbl:
	.ENDM 
	EMULOG50 ^/"Profile a single NOP instruction at Normal Speed"/, ^/"%ZEROCLKS%"/ 
;src/emu_debug.c:51: __asm__("nop");
	nop
;src/emu_debug.c:52: EMU_PROFILE_END("NOP TIME:");
	.MACRO EMULOG52 msg_t, msg_s, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
	.ascii msg_s 
llbl:
	.ENDM 
	EMULOG52 ^/"NOP TIME:"/, ^/"%-16+LASTCLKS%"/ 
	pop	af
	jp	PO, 00120$
	ei
00120$:
;src/emu_debug.c:106: }
	ld	a,i
	di
	push	af
;src/emu_debug.c:98: EMU_PROFILE_BEGIN("Profile code in a loop");
	.MACRO EMULOG98 msg_t, msg_s, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
	.ascii msg_s 
llbl:
	.ENDM 
	EMULOG98 ^/"Profile code in a loop"/, ^/"%ZEROCLKS%"/ 
;src/emu_debug.c:99: for(c=0; c<5; c++) {
	ld	bc, #0x0000
00102$:
;src/emu_debug.c:101: printf("%d\n", c);
	push	bc
	push	bc
	ld	hl, #___str_2
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	bc
;src/emu_debug.c:99: for(c=0; c<5; c++) {
	inc	bc
	ld	a, c
	sub	a, #0x05
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00102$
;src/emu_debug.c:105: EMU_PROFILE_END("LOOP TIME:");
	.MACRO EMULOG105 msg_t, msg_s, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
	.ascii msg_s 
llbl:
	.ENDM 
	EMULOG105 ^/"LOOP TIME:"/, ^/"%-16+LASTCLKS%"/ 
	pop	af
	jp	PO, 00122$
	ei
00122$:
;src/emu_debug.c:112: EMU_MESSAGE("Total Clocks: %TOTALCLKS%");
	.MACRO EMULOG112 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG112 ^/"Total Clocks: %TOTALCLKS%"/ 
;src/emu_debug.c:115: EMU_MESSAGE("Clocks until VBLANK: %CLKS2VBLANK%");
	.MACRO EMULOG115 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG115 ^/"Clocks until VBLANK: %CLKS2VBLANK%"/ 
;src/emu_debug.c:118: EMU_MESSAGE("Current  ROM bank: %ROMBANK%");
	.MACRO EMULOG118 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG118 ^/"Current  ROM bank: %ROMBANK%"/ 
;src/emu_debug.c:119: EMU_MESSAGE("Current SRAM bank: %SRAMBANK%");
	.MACRO EMULOG119 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG119 ^/"Current SRAM bank: %SRAMBANK%"/ 
;src/emu_debug.c:121: EMU_MESSAGE("Current VRAM bank: %VRAMBANK%");
	.MACRO EMULOG121 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG121 ^/"Current VRAM bank: %VRAMBANK%"/ 
;src/emu_debug.c:122: EMU_MESSAGE("Current WRAM bank: %WRAMBANK%");
	.MACRO EMULOG122 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG122 ^/"Current WRAM bank: %WRAMBANK%"/ 
;src/emu_debug.c:125: EMU_MESSAGE("All Registers: %ALLREGS%");
	.MACRO EMULOG125 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG125 ^/"All Registers: %ALLREGS%"/ 
;src/emu_debug.c:128: EMU_MESSAGE("Register A + 1: %(A+1)%");
	.MACRO EMULOG128 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG128 ^/"Register A + 1: %(A+1)%"/ 
;src/emu_debug.c:131: EMU_MESSAGE("Current Scanline: %SCANLINE%");
	.MACRO EMULOG131 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG131 ^/"Current Scanline: %SCANLINE%"/ 
;src/emu_debug.c:153: EMU_MESSAGE("PROFILE,%(SP+$0)%,%(SP+$1)%,%A%,%TOTALCLKS%,%ROMBANK%,%WRAMBANK%");
	.MACRO EMULOG153 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG153 ^/"PROFILE,%(SP+$0)%,%(SP+$1)%,%A%,%TOTALCLKS%,%ROMBANK%,%WRAMBANK%"/ 
;src/emu_debug.c:158: EMU_printf("var0: %hd; var1: %d; var0*var1=%d", (uint8_t)var0, var1, var0 * var1);
	ld	hl, #0xff60
	push	hl
	ld	l, #0xf6
	push	hl
	ld	a, #0x10
	push	af
	inc	sp
	ld	hl, #___str_3
	push	hl
	call	_EMU_printf
	pop	af
	pop	af
	pop	af
	inc	sp
;src/emu_debug.c:161: EMU_TEXT("The End");
	.MACRO EMULOG161 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG161 ^/"The End"/ 
;src/emu_debug.c:163: return 0;
	ld	de, #0x0000
;src/emu_debug.c:164: }
	ret
___str_1:
	.ascii "Message to the"
	.db 0x0a
	.ascii "Screen"
	.db 0x00
___str_2:
	.ascii "%d"
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "var0: %hd; var1: %d; var0*var1=%d"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
