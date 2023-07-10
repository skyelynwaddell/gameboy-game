;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (Mac OS X x86_64)
;--------------------------------------------------------
	.module emu_debug
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _EMU_printf
	.globl _EMU_profiler_message
	.globl _puts
	.globl _printf
	.globl _set_default_palette
	.globl _cpu_fast
	.globl _cpu_slow
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
___EMU_PROFILER_INIT:
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
;src/emu_debug.c:26: int main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/emu_debug.c:28: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/emu_debug.c:29: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/emu_debug.c:32: printf("Message to the\nScreen\n");
	ld	de, #___str_1
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
	di
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
	EMULOG52 ^/"NOP TIME:"/, ^/"%-8+LASTCLKS%"/ 
	ei
;src/emu_debug.c:66: if (DEVICE_SUPPORTS_COLOR) {
	ld	hl, #__cpu
	ld	a, (hl)
	sub	a, #0x11
	jp	NZ,00102$
;src/emu_debug.c:70: cpu_fast();
	call	_cpu_fast
;src/emu_debug.c:72: set_default_palette();
	call	_set_default_palette
;src/emu_debug.c:85: }
	di
;src/emu_debug.c:80: EMU_PROFILE_BEGIN("Profile a single NOP instruction at CGB Double Speed");
	.MACRO EMULOG80 msg_t, msg_s, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
	.ascii msg_s 
llbl:
	.ENDM 
	EMULOG80 ^/"Profile a single NOP instruction at CGB Double Speed"/, ^/"%ZEROCLKS%"/ 
;src/emu_debug.c:81: __asm__("nop");
	nop
;src/emu_debug.c:84: EMU_MESSAGE("NOP TIME:%-4+LASTCLKS%");
	.MACRO EMULOG84 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG84 ^/"NOP TIME:%-4+LASTCLKS%"/ 
	ei
;src/emu_debug.c:88: cpu_slow();
	call	_cpu_slow
00102$:
;src/emu_debug.c:106: }
	di
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
00104$:
;src/emu_debug.c:101: printf("%d\n", c);
	push	bc
	push	bc
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
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
	jr	C, 00104$
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
	EMULOG105 ^/"LOOP TIME:"/, ^/"%-8+LASTCLKS%"/ 
	ei
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
;src/emu_debug.c:136: EMU_MESSAGE("LY Register (0xFF44): %($ff44)%");
	.MACRO EMULOG136 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG136 ^/"LY Register (0xFF44): %($ff44)%"/ 
;src/emu_debug.c:137: EMU_MESSAGE("LY Register (0xFF44): %($ff44)%");
	.MACRO EMULOG137 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG137 ^/"LY Register (0xFF44): %($ff44)%"/ 
;src/emu_debug.c:139: EMU_MESSAGE("Is LY Register > Line 67: %($ff44)>67%Yes;No;");
	.MACRO EMULOG139 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG139 ^/"Is LY Register > Line 67: %($ff44)>67%Yes;No;"/ 
;src/emu_debug.c:145: EMU_MESSAGE("The following lines contain: PROFILE,(SP+$0),(SP+$1),A,TOTALCLKS,ROMBANK,WRAMBANK");
	.MACRO EMULOG145 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG145 ^/"The following lines contain: PROFILE,(SP+$0),(SP+$1),A,TOTALCLKS,ROMBANK,WRAMBANK"/ 
;src/emu_debug.c:147: EMU_profiler_message();
	call	_EMU_profiler_message
;src/emu_debug.c:150: EMU_MESSAGE("PROFILE,%(SP+$0)%,%(SP+$1)%,%A%,%TOTALCLKS%,%ROMBANK%,%WRAMBANK%");
	.MACRO EMULOG150 msg_t, ?llbl 
	ld d, d 
	jr llbl 
	.dw 0x6464 
	.dw 0x0000 
	.ascii msg_t 
llbl:
	.ENDM 
	EMULOG150 ^/"PROFILE,%(SP+$0)%,%(SP+$1)%,%A%,%TOTALCLKS%,%ROMBANK%,%WRAMBANK%"/ 
;src/emu_debug.c:158: EMU_printf("var0: %hd; var1: %d; var0*var1=%d", (uint8_t)var0, var1, var0 * var1);
	ld	de, #0xff60
	push	de
	ld	de, #0xfff6
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	ld	de, #___str_3
	push	de
	call	_EMU_printf
	add	sp, #7
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
	ld	bc, #0x0000
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
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
	.area _CABS (ABS)
