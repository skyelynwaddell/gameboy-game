                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ISO C Compiler 
                              3 ; Version 4.2.2 #13350 (Mac OS X x86_64)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mmos6502
                              7 	
                              8 	.globl __TEMP
                              9 	.globl __DPTR
                             10 	.area ZP      (PAG)
   0065                      11 __TEMP:	.ds 8
   006D                      12 __DPTR:	.ds 2
                             13 ;--------------------------------------------------------
                             14 ; Public variables in this module
                             15 ;--------------------------------------------------------
                             16 	.globl _main
                             17 	.globl ___func_map_compressed
                             18 	.globl ___func_map_tiles
                             19 	.globl _rle_decompress
                             20 	.globl _rle_init
                             21 	.globl _set_bkg_tiles
                             22 	.globl _set_bkg_data
                             23 	.globl _wait_vbl_done
                             24 	.globl _datapos
                             25 	.globl _scrollpos
                             26 	.globl _data
                             27 ;--------------------------------------------------------
                             28 ; ZP ram data
                             29 ;--------------------------------------------------------
                             30 	.area ZP      (PAG)
   006F                      31 _main_sloc0_1_0:
   006F                      32 	.ds 1
                             33 ;--------------------------------------------------------
                             34 ; overlayable items in ram
                             35 ;--------------------------------------------------------
                             36 ;--------------------------------------------------------
                             37 ; uninitialized external ram data
                             38 ;--------------------------------------------------------
                             39 	.area BSS
   0302                      40 _data::
   0302                      41 	.ds 18
   0314                      42 _main_map_x_column_196609_73:
   0314                      43 	.ds 1
                             44 ;--------------------------------------------------------
                             45 ; absolute external ram data
                             46 ;--------------------------------------------------------
                             47 	.area DABS    (ABS)
                             48 ;--------------------------------------------------------
                             49 ; initialized external ram data
                             50 ;--------------------------------------------------------
                             51 	.area DATA
   0300                      52 _scrollpos::
   0300                      53 	.ds 1
   0301                      54 _datapos::
   0301                      55 	.ds 1
                             56 ;--------------------------------------------------------
                             57 ; global & static initialisations
                             58 ;--------------------------------------------------------
                             59 	.area _CODE
                             60 	.area GSINIT
                             61 	.area GSFINAL
                             62 	.area GSINIT
                             63 ;--------------------------------------------------------
                             64 ; Home
                             65 ;--------------------------------------------------------
                             66 	.area _CODE
                             67 	.area _CODE
                             68 ;--------------------------------------------------------
                             69 ; code
                             70 ;--------------------------------------------------------
                             71 	.area CODE
                             72 ;------------------------------------------------------------
                             73 ;Allocation info for local variables in function '__func_map_tiles'
                             74 ;------------------------------------------------------------
                             75 ;	src/main.c: 8: INCBIN(map_tiles, "res/map_tiles.bin")
                             76 ;	-----------------------------------------
                             77 ;	 function __func_map_tiles
                             78 ;	-----------------------------------------
                             79 ;	Register assignment is optimal.
                             80 ;	Stack space usage: 0 bytes.
   8000                      81 ___func_map_tiles:
                             82 ;	naked function: no prologue.
   8000                      83 		_map_tiles::
   8000                      84 	 1$:
   8000 FF 00 FF 00 FF 00    85 	 .incbin "res/map_tiles.bin" 
        FF 00 FF 00 FF 00
        DF 20 FF 00 FF 00
        FF 00 FF 00 FF 00
        3F C0 BF 00 FF 00
        FF 00 FF 00 FF 00
        FF 00 FF 00 FF 00
        FF 00 FF 00 FF 00
        FF 00 EF 10 F8 00
        F0 00 F0 00 E1 00
        C5 22 F3 0C FD 03
        F8 07 78 07 5A 25
        BC 43 7C 83 FC 03
        E0 07 FF FF FF FF
        FF FF FF FF FF FF
        FF FF FF FF FF FF
        FF FF FF FF FF FF
        FF FF FF FF FF FF
        DF FF FF FF FF FF
        FF FF FF FF FF FF
        3F FF BF FF FF FF
        FF FF
   0780                      86 	 2$:
                     0780    87 	 ___size_map_tiles = (2$-1$) 
                             88 	 .globl ___size_map_tiles 
                             89 	 .local b___func_map_tiles 
                     0000    90 	 ___bank_map_tiles = 0 
                             91 	 .globl ___bank_map_tiles 
   0780                      92 00101$:
                             93 ;	naked function: no epilogue.
                             94 ;------------------------------------------------------------
                             95 ;Allocation info for local variables in function '__func_map_compressed'
                             96 ;------------------------------------------------------------
                             97 ;	src/main.c: 15: INCBIN(map_compressed, "res/map.bin.rle")
                             98 ;	-----------------------------------------
                             99 ;	 function __func_map_compressed
                            100 ;	-----------------------------------------
                            101 ;	Register assignment is optimal.
                            102 ;	Stack space usage: 0 bytes.
   0780                     103 ___func_map_compressed:
                            104 ;	naked function: no prologue.
   0780                     105 		_map_compressed::
   0780                     106 	 1$:
   8080 FF FF DF FF F0 FF   107 	 .incbin "res/map.bin.rle" 
        E0 FF E1 FF F3 FF
        FC FF EF FF FF FF
        FF FF FF FF 9F FF
        3D FF FF FF FF FF
        E7 FF BF C0 3F C0
        3F C0 5E A0 5C A0
        38 C4 3C C3 7F 80
        FF 00 FF 00 FF 00
        7F 00 F7 08 BF 40
        7F 80 FF 00 FF 00
        FF 00 7F 00 5F 20
        BD 42 7F 80 FF 00
        E7 00 FF 00 FF 00
        FC 03 F9 04 FF 00
        FF 00 FF 00 FF 00
        F7 08 FF 00 FF 00
        FF 00 FF 00 FF 00
        FF 00 FF 00 FF 00
        F3 00 E5 12 F2 0D
        FD 02 FF 00 DF 20
        FF 00
   0E45                     108 	 2$:
                     06C5   109 	 ___size_map_compressed = (2$-1$) 
                            110 	 .globl ___size_map_compressed 
                            111 	 .local b___func_map_compressed 
                     0000   112 	 ___bank_map_compressed = 0 
                            113 	 .globl ___bank_map_compressed 
   0E45                     114 00101$:
                            115 ;	naked function: no epilogue.
                            116 ;------------------------------------------------------------
                            117 ;Allocation info for local variables in function 'main'
                            118 ;------------------------------------------------------------
                            119 ;sloc0                     Allocated with name '_main_sloc0_1_0'
                            120 ;i                         Allocated to registers 
                            121 ;__1966080006              Allocated to registers x 
                            122 ;__1966080007              Allocated to registers 
                            123 ;x                         Allocated to registers 
                            124 ;y                         Allocated to registers 
                            125 ;map_x_column              Allocated with name '_main_map_x_column_196609_73'
                            126 ;------------------------------------------------------------
                            127 ;	src/main.c: 22: void main() {
                            128 ;	-----------------------------------------
                            129 ;	 function main
                            130 ;	-----------------------------------------
                            131 ;	Register assignment is optimal.
                            132 ;	Stack space usage: 0 bytes.
   0E45                     133 _main:
                            134 ;	src/main.c: 28: HIDE_LEFT_COLUMN;
   8100 40 87 9A      [ 4]  135 	lda	_shadow_PPUMASK
   8103 45 C2         [ 2]  136 	and	#0xf9
   8105 3D FC 03      [ 4]  137 	sta	_shadow_PPUMASK
                            138 ;	src/main.c: 30: SHOW_BKG;
   8108 F4 0B E8      [ 4]  139 	lda	_shadow_PPUMASK
   810B 17 FC         [ 2]  140 	ora	#0x08
   810D 03 FD 03      [ 4]  141 	sta	_shadow_PPUMASK
                            142 ;	src/main.c: 33: set_bkg_data(0, INCBIN_SIZE(map_tiles) >> 4, map_tiles);
   8110 FF FF         [ 2]  143 	lda	#___size_map_tiles
   8112 FF FF         [ 2]  144 	ldx	#>___size_map_tiles
   8114 FC FF         [ 3]  145 	stx	*(__TEMP+0)
   8116 F9 FF         [ 5]  146 	lsr	*(__TEMP+0)
   8118 FF            [ 2]  147 	ror	a
   8119 FF FF         [ 5]  148 	lsr	*(__TEMP+0)
   811B FF            [ 2]  149 	ror	a
   811C FF FF         [ 5]  150 	lsr	*(__TEMP+0)
   811E FF            [ 2]  151 	ror	a
   811F FF F7         [ 5]  152 	lsr	*(__TEMP+0)
   8121 FF            [ 2]  153 	ror	a
   8122 FF FF         [ 3]  154 	ldx	*(__TEMP+0)
   8124 FF FF         [ 2]  155 	ldx	#_map_tiles
   8126 FF FF FF      [ 4]  156 	stx	_set_bkg_data_PARM_3
   8129 FF FF         [ 2]  157 	ldx	#>_map_tiles
   812B FF FF FF      [ 4]  158 	stx	(_set_bkg_data_PARM_3 + 1)
   812E FF            [ 2]  159 	tax
   812F FF 8F         [ 2]  160 	lda	#0x00
   8131 FF DF FF      [ 6]  161 	jsr	_set_bkg_data
                            162 ;	src/main.c: 36: rle_init(map_compressed);
   8134 FF FF         [ 2]  163 	ldx	#>_map_compressed
   8136 F8 FF         [ 2]  164 	lda	#_map_compressed
   8138 F0 FF B9      [ 6]  165 	jsr	_rle_init
                            166 ;	src/main.c: 41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
   813B FF FF         [ 2]  167 	ldx	#0x00
   813D FF FF         [ 3]  168 	stx	*_main_sloc0_1_0
   0E84                     169 00113$:
   813F FF 07         [ 3]  170 	lda	*_main_sloc0_1_0
   8141 FF 83         [ 2]  171 	cmp	#0x21
   8143 FF CF         [ 4]  172 	bne	00138$
   8145 FF F1 FF      [ 3]  173 	jmp	00103$
   0E8D                     174 00138$:
                            175 ;	src/main.c: 42: rle_decompress(data, MAP_DATA_HEIGHT);
   8148 FB FF         [ 2]  176 	ldx	#0x12
   814A FF FF FF      [ 4]  177 	stx	_rle_decompress_PARM_2
   814D FF FF         [ 2]  178 	ldx	#>_data
   814F FF 2F         [ 2]  179 	lda	#_data
   8151 D0 39 C2      [ 6]  180 	jsr	_rle_decompress
                            181 ;	src/main.c: 47: set_bkg_tiles(i & (DEVICE_SCREEN_BUFFER_WIDTH-1), 0, 1, MAP_DATA_HEIGHT, data);
   8154 7B 84         [ 3]  182 	lda	*_main_sloc0_1_0
   8156 7F 80         [ 2]  183 	and	#0x1f
   8158 67 98         [ 2]  184 	ldx	#_data
   815A 24 DB 80      [ 4]  185 	stx	_set_bkg_tiles_PARM_5
   815D FF C0         [ 2]  186 	ldx	#>_data
   815F FF CF 00      [ 4]  187 	stx	(_set_bkg_tiles_PARM_5 + 1)
   8162 97 48         [ 2]  188 	ldx	#0x01
   8164 CF 30 FF      [ 4]  189 	stx	_set_bkg_tiles_PARM_3
   8167 00 36         [ 2]  190 	ldx	#0x12
   8169 C9 04 FB      [ 4]  191 	stx	_set_bkg_tiles_PARM_4
   816C 00 FF         [ 2]  192 	ldx	#0x00
   816E 01 FF FF      [ 6]  193 	jsr	_set_bkg_tiles
                            194 ;	src/main.c: 41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
   8171 00 FF         [ 5]  195 	inc	*_main_sloc0_1_0
   8173 00 FF 00      [ 3]  196 	jmp	00113$
   0EBB                     197 00103$:
                            198 ;	src/main.c: 51: datapos = 0;
   8176 FF 00         [ 2]  199 	ldx	#0x00
   8178 6F 90 21      [ 4]  200 	stx	_datapos
                            201 ;	src/main.c: 52: scrollpos = 1;
   817B DE            [ 2]  202 	inx
   817C 00 FF 80      [ 4]  203 	stx	_scrollpos
                            204 ;	src/main.c: 53: while(TRUE) {
   0EC4                     205 00109$:
                            206 ;	src/main.c: 55: wait_vbl_done();
   817F FF FF 00      [ 6]  207 	jsr	_wait_vbl_done
                            208 ;	src/main.c: 60: scrollpos++;
   8182 FF 00 FF      [ 6]  209 	inc	_scrollpos
                            210 ;	src/main.c: 61: move_bkg(scrollpos, 0);
   8185 00 FF 00      [ 4]  211 	ldx	_scrollpos
                            212 ;	../../../include/nes/nes.h: 618: bkg_scroll_x = x, bkg_scroll_y = y;
   8188 36 C9 04      [ 4]  213 	stx	_bkg_scroll_x
   818B FB 00         [ 2]  214 	ldy	#0x00
   818D FF 01 FF      [ 4]  215 	sty	_bkg_scroll_y
                            216 ;	src/main.c: 65: if ((scrollpos & 0x07u) == 0) {
   8190 FF 00         [ 2]  217 	lda	#0x07
   8192 FF 00         [ 3]  218 	stx	*(__TEMP+0)
   8194 FC 03         [ 3]  219 	and	*(__TEMP+0)
   8196 F9 04         [ 4]  220 	beq	00139$
   8198 6F 90 21      [ 3]  221 	jmp	00109$
   0EE0                     222 00139$:
                            223 ;	src/main.c: 69: datapos = (scrollpos >> 3);
   819B DE            [ 2]  224 	txa
   819C 00            [ 2]  225 	lsr	a
   819D FF            [ 2]  226 	lsr	a
   819E 80            [ 2]  227 	lsr	a
   819F FF F7 08      [ 4]  228 	sta	_datapos
                            229 ;	src/main.c: 70: uint8_t map_x_column = (datapos + DEVICE_SCREEN_WIDTH) & (DEVICE_SCREEN_BUFFER_WIDTH-1);
   81A2 FF            [ 2]  230 	clc
   81A3 00 FF         [ 2]  231 	adc	#0x20
   81A5 00 FF         [ 2]  232 	and	#0x1f
   81A7 00 36 C9      [ 4]  233 	sta	_main_map_x_column_196609_73
                            234 ;	src/main.c: 75: if (!rle_decompress(data, MAP_DATA_HEIGHT)) {
   81AA 04 FB         [ 2]  235 	ldx	#0x12
   81AC 00 FF 01      [ 4]  236 	stx	_rle_decompress_PARM_2
   81AF FF FF         [ 2]  237 	ldx	#>_data
   81B1 00 F3         [ 2]  238 	lda	#_data
   81B3 00 E5 12      [ 6]  239 	jsr	_rle_decompress
   81B6 F2 0D         [ 2]  240 	cmp	#0x00
   81B8 6F 90         [ 4]  241 	beq	00140$
   81BA 21 DE 00      [ 3]  242 	jmp	00105$
   0F02                     243 00140$:
                            244 ;	src/main.c: 76: rle_init(map_compressed);
   81BD FF 80         [ 2]  245 	ldx	#>_map_compressed
   81BF FF 47         [ 2]  246 	lda	#_map_compressed
   81C1 80 9B 44      [ 6]  247 	jsr	_rle_init
                            248 ;	src/main.c: 77: rle_decompress(data, MAP_DATA_HEIGHT);
   81C4 C7 38         [ 2]  249 	ldx	#0x12
   81C6 FF 00 36      [ 4]  250 	stx	_rle_decompress_PARM_2
   81C9 C9 04         [ 2]  251 	ldx	#>_data
   81CB FB 00         [ 2]  252 	lda	#_data
   81CD FF 01 FF      [ 6]  253 	jsr	_rle_decompress
   0F15                     254 00105$:
                            255 ;	src/main.c: 83: set_bkg_tiles(map_x_column, 0, 1, MAP_DATA_HEIGHT, data);
   81D0 FC 03         [ 2]  256 	lda	#_data
   81D2 FC 00 FA      [ 4]  257 	sta	_set_bkg_tiles_PARM_5
   81D5 04 FD         [ 2]  258 	lda	#>_data
   81D7 02 3E C1      [ 4]  259 	sta	(_set_bkg_tiles_PARM_5 + 1)
   81DA BF 00         [ 2]  260 	ldx	#0x01
   81DC FF 00 FF      [ 4]  261 	stx	_set_bkg_tiles_PARM_3
   81DF 00 BC         [ 2]  262 	ldx	#0x12
   81E1 43 00 00      [ 4]  263 	stx	_set_bkg_tiles_PARM_4
   81E4 81 00 44      [ 4]  264 	lda	_main_map_x_column_196609_73
   81E7 83 30         [ 2]  265 	ldx	#0x00
   81E9 CF B9 46      [ 6]  266 	jsr	_set_bkg_tiles
   81EC D3 2C FF      [ 3]  267 	jmp	00109$
   0F34                     268 00115$:
                            269 ;	src/main.c: 86: }
   81EF 00            [ 6]  270 	rts
                            271 	.area CODE
                            272 	.area RODATA
                            273 	.area XINIT
   0000                     274 __xinit__scrollpos:
   81F0 F1                  275 	.db #0x00	; 0
   0001                     276 __xinit__datapos:
   81F1 0E                  277 	.db #0x00	; 0
                            278 	.area CABS    (ABS)
