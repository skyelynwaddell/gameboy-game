                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.2.2 #13350 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -msm83
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl b___func_map_compressed
                                     13 	.globl ___func_map_compressed
                                     14 	.globl b___func_map_tiles
                                     15 	.globl ___func_map_tiles
                                     16 	.globl _rle_decompress
                                     17 	.globl _rle_init
                                     18 	.globl _set_bkg_tiles
                                     19 	.globl _set_bkg_data
                                     20 	.globl _wait_vbl_done
                                     21 	.globl _datapos
                                     22 	.globl _scrollpos
                                     23 	.globl _data
                                     24 ;--------------------------------------------------------
                                     25 ; special function registers
                                     26 ;--------------------------------------------------------
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area _DATA
      00C0B1                         31 _data::
      00C0B1                         32 	.ds 18
                                     33 ;--------------------------------------------------------
                                     34 ; ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area _INITIALIZED
      00C0C7                         37 _scrollpos::
      00C0C7                         38 	.ds 1
      00C0C8                         39 _datapos::
      00C0C8                         40 	.ds 1
                                     41 ;--------------------------------------------------------
                                     42 ; absolute external ram data
                                     43 ;--------------------------------------------------------
                                     44 	.area _DABS (ABS)
                                     45 ;--------------------------------------------------------
                                     46 ; global & static initialisations
                                     47 ;--------------------------------------------------------
                                     48 	.area _HOME
                                     49 	.area _GSINIT
                                     50 	.area _GSFINAL
                                     51 	.area _GSINIT
                                     52 ;--------------------------------------------------------
                                     53 ; Home
                                     54 ;--------------------------------------------------------
                                     55 	.area _HOME
                                     56 	.area _HOME
                                     57 ;--------------------------------------------------------
                                     58 ; code
                                     59 ;--------------------------------------------------------
                                     60 	.area _CODE
                                     61 ;src/main.c:8: INCBIN(map_tiles, "res/map_tiles.bin")
                                     62 ;	---------------------------------
                                     63 ; Function __func_map_tiles
                                     64 ; ---------------------------------
                           000000    65 	b___func_map_tiles	= 0
      000200                         66 ___func_map_tiles::
      000200                         67 _map_tiles::
      000200                         68 1$:
      000200 FF 00 FF 00 FF 00 FF    69 	.incbin "res/map_tiles.bin" 
             00 FF 00 FF 00 DF 20
             FF 00 FF 00 FF 00 FF
             00 FF 00 3F C0 BF 00
             FF 00 FF 00 FF 00 FF
             00 FF 00 FF 00 FF 00
             FF 00 FF 00 FF 00 FF
             00 EF 10 F8 00 F0 00
             F0 00 E1 00 C5 22 F3
             0C FD 03 F8 07 78 07
             5A 25 BC 43 7C 83 FC
             03 E0 07 FF FF FF FF
             FF FF FF FF FF FF FF
             FF FF FF FF FF FF FF
             FF FF FF FF FF FF FF
             FF FF FF DF FF FF FF
             FF FF FF FF FF FF FF
             FF 3F FF BF FF FF FF
             FF FF
      000780                         70 2$:
                           000780    71 	___size_map_tiles = (2$-1$) 
                                     72 	.globl ___size_map_tiles 
                                     73 	.local b___func_map_tiles 
                           000000    74 	___bank_map_tiles = b___func_map_tiles 
                                     75 	.globl ___bank_map_tiles 
                                     76 ;src/main.c:15: INCBIN(map_compressed, "res/map.bin.rle")
                                     77 ;	---------------------------------
                                     78 ; Function __func_map_compressed
                                     79 ; ---------------------------------
                           000000    80 	b___func_map_compressed	= 0
      000780                         81 ___func_map_compressed::
      000780                         82 _map_compressed::
      000780                         83 1$:
      000280 FF FF DF FF F0 FF E0    84 	.incbin "res/map.bin.rle" 
             FF E1 FF F3 FF FC FF
             EF FF FF FF FF FF FF
             FF 9F FF 3D FF FF FF
             FF FF E7 FF BF C0 3F
             C0 3F C0 5E A0 5C A0
             38 C4 3C C3 7F 80 FF
             00 FF 00 FF 00 7F 00
             F7 08 BF 40 7F 80 FF
             00 FF 00 FF 00 7F 00
             5F 20 BD 42 7F 80 FF
             00 E7 00 FF 00 FF 00
             FC 03 F9 04 FF 00 FF
             00 FF 00 FF 00 F7 08
             FF 00 FF 00 FF 00 FF
             00 FF 00 FF 00 FF 00
             FF 00 F3 00 E5 12 F2
             0D FD 02 FF 00 DF 20
             FF 00
      000E45                         85 2$:
                           0006C5    86 	___size_map_compressed = (2$-1$) 
                                     87 	.globl ___size_map_compressed 
                                     88 	.local b___func_map_compressed 
                           000000    89 	___bank_map_compressed = b___func_map_compressed 
                                     90 	.globl ___bank_map_compressed 
                                     91 ;src/main.c:22: void main() {
                                     92 ;	---------------------------------
                                     93 ; Function main
                                     94 ; ---------------------------------
      000E45                         95 _main::
      000300 40               [ 8]   96 	dec	sp
                                     97 ;src/main.c:30: SHOW_BKG;
      000301 87 9A            [12]   98 	ldh	a, (_LCDC_REG + 0)
      000303 45 C2            [ 8]   99 	or	a, #0x01
      000305 3D FC            [12]  100 	ldh	(_LCDC_REG + 0), a
                                    101 ;src/main.c:33: set_bkg_data(0, INCBIN_SIZE(map_tiles) >> 4, map_tiles);
      000307 03 F4 0B         [12]  102 	ld	bc, #_map_tiles+0
      00030A E8 17 FC         [12]  103 	ld	de, #___size_map_tiles+0
      00030D 03 FD            [ 8]  104 	srl	d
      00030F 03 FF            [ 8]  105 	rr	e
      000311 FF FF            [ 8]  106 	srl	d
      000313 FF FC            [ 8]  107 	rr	e
      000315 FF F9            [ 8]  108 	srl	d
      000317 FF FF            [ 8]  109 	rr	e
      000319 FF FF            [ 8]  110 	srl	d
      00031B FF FF            [ 8]  111 	rr	e
      00031D FF               [ 4]  112 	ld	a, e
      00031E FF               [16]  113 	push	bc
      00031F FF               [ 4]  114 	ld	h, a
      000320 F7 FF            [ 8]  115 	ld	l, #0x00
      000322 FF               [16]  116 	push	hl
      000323 FF FF FF         [24]  117 	call	_set_bkg_data
      000326 FF FF            [16]  118 	add	sp, #4
                                    119 ;src/main.c:36: rle_init(map_compressed);
      000328 FF FF FF         [12]  120 	ld	de, #_map_compressed
      00032B FF               [16]  121 	push	de
      00032C FF FF FF         [24]  122 	call	_rle_init
      00032F FF               [12]  123 	pop	hl
                                    124 ;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
      000330 8F FF DF         [12]  125 	ld	bc, #_data
      000333 FF FF            [ 8]  126 	ld	e, #0x00
      000E7A                        127 00111$:
      000335 FF               [ 4]  128 	ld	a, e
      000336 F8 FF            [ 8]  129 	sub	a, #0x15
      000338 F0 FF            [12]  130 	jr	Z, 00101$
                                    131 ;src/main.c:42: rle_decompress(data, MAP_DATA_HEIGHT);
      00033A B9               [16]  132 	push	bc
      00033B FF               [16]  133 	push	de
      00033C FF FF            [ 8]  134 	ld	a, #0x12
      00033E FF               [16]  135 	push	af
      00033F FF               [ 8]  136 	inc	sp
      000340 07 FF 83         [12]  137 	ld	hl, #_data
      000343 FF               [16]  138 	push	hl
      000344 CF FF F1         [24]  139 	call	_rle_decompress
      000347 FF FB            [16]  140 	add	sp, #3
      000349 FF               [12]  141 	pop	de
      00034A FF               [12]  142 	pop	bc
                                    143 ;src/main.c:47: set_bkg_tiles(i & (DEVICE_SCREEN_BUFFER_WIDTH-1), 0, 1, MAP_DATA_HEIGHT, data);
      00034B FF               [ 4]  144 	ld	l, c
                                    145 ;	spillPairReg hl
                                    146 ;	spillPairReg hl
      00034C FF               [ 4]  147 	ld	h, b
                                    148 ;	spillPairReg hl
                                    149 ;	spillPairReg hl
      00034D FF               [ 4]  150 	ld	a, e
      00034E FF FF            [ 8]  151 	and	a, #0x1f
      000350 2F               [16]  152 	push	de
      000351 D0               [16]  153 	push	hl
      000352 39 C2            [ 8]  154 	ld	h, #0x12
                                    155 ;	spillPairReg hl
                                    156 ;	spillPairReg hl
      000354 7B               [16]  157 	push	hl
      000355 84               [ 8]  158 	inc	sp
      000356 7F 80            [ 8]  159 	ld	h, #0x01
                                    160 ;	spillPairReg hl
                                    161 ;	spillPairReg hl
      000358 67               [16]  162 	push	hl
      000359 98               [ 8]  163 	inc	sp
      00035A 24 DB            [ 8]  164 	ld	h, #0x00
                                    165 ;	spillPairReg hl
                                    166 ;	spillPairReg hl
      00035C 80               [16]  167 	push	hl
      00035D FF               [ 8]  168 	inc	sp
      00035E C0               [16]  169 	push	af
      00035F FF               [ 8]  170 	inc	sp
      000360 CF 00 97         [24]  171 	call	_set_bkg_tiles
      000363 48 CF            [16]  172 	add	sp, #6
      000365 30               [12]  173 	pop	de
                                    174 ;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
      000366 FF               [ 4]  175 	inc	e
      000367 00 36            [12]  176 	jr	00111$
      000EAE                        177 00101$:
                                    178 ;src/main.c:51: datapos = 0;
      000369 C9 04 FB         [12]  179 	ld	hl, #_datapos
      00036C 00 FF            [12]  180 	ld	(hl), #0x00
                                    181 ;src/main.c:52: scrollpos = 1;
      00036E 01 FF FF         [12]  182 	ld	hl, #_scrollpos
      000371 00 FF            [12]  183 	ld	(hl), #0x01
                                    184 ;src/main.c:53: while(TRUE) {
      000EB8                        185 00107$:
                                    186 ;src/main.c:55: wait_vbl_done();
      000373 00 FF 00         [24]  187 	call	_wait_vbl_done
                                    188 ;src/main.c:60: scrollpos++;
      000376 FF 00 6F         [12]  189 	ld	hl, #_scrollpos
      000379 90               [12]  190 	inc	(hl)
                                    191 ;src/main.c:61: move_bkg(scrollpos, 0);
      00037A 21               [ 8]  192 	ld	a, (hl)
                                    193 ;../../../include/gb/gb.h:1208: SCX_REG=x, SCY_REG=y;
      00037B DE 00            [12]  194 	ldh	(_SCX_REG + 0), a
      00037D FF               [16]  195 	push	af
      00037E 80               [ 4]  196 	xor	a, a
      00037F FF FF            [12]  197 	ldh	(_SCY_REG + 0), a
      000381 00               [12]  198 	pop	af
                                    199 ;src/main.c:65: if ((scrollpos & 0x07u) == 0) {
      000382 FF 00            [ 8]  200 	and	a, #0x07
      000384 FF 00            [12]  201 	jr	NZ, 00107$
                                    202 ;src/main.c:69: datapos = (scrollpos >> 3);
      000386 FF 00 36         [16]  203 	ld	a, (#_scrollpos)
      000389 C9 04            [ 8]  204 	swap	a
      00038B FB               [ 4]  205 	rlca
      00038C 00 FF            [ 8]  206 	and	a, #0x1f
      00038E 01 FF FF         [12]  207 	ld	hl, #_datapos
      000391 00               [ 8]  208 	ld	(hl), a
                                    209 ;src/main.c:70: uint8_t map_x_column = (datapos + DEVICE_SCREEN_WIDTH) & (DEVICE_SCREEN_BUFFER_WIDTH-1);
      000392 FF               [ 8]  210 	ld	a, (hl)
      000393 00 FC            [ 8]  211 	add	a, #0x14
      000395 03 F9            [ 8]  212 	and	a, #0x1f
      000397 04 6F            [12]  213 	ldhl	sp,	#0
      000399 90               [ 8]  214 	ld	(hl), a
                                    215 ;src/main.c:75: if (!rle_decompress(data, MAP_DATA_HEIGHT)) {
      00039A 21 DE            [ 8]  216 	ld	a, #0x12
      00039C 00               [16]  217 	push	af
      00039D FF               [ 8]  218 	inc	sp
      00039E 80 FF F7         [12]  219 	ld	de, #_data
      0003A1 08               [16]  220 	push	de
      0003A2 FF 00 FF         [24]  221 	call	_rle_decompress
      0003A5 00 FF            [16]  222 	add	sp, #3
      0003A7 00               [ 4]  223 	ld	a, e
      0003A8 36               [ 4]  224 	or	a, a
      0003A9 C9 04            [12]  225 	jr	NZ, 00103$
                                    226 ;src/main.c:76: rle_init(map_compressed);
      0003AB FB 00 FF         [12]  227 	ld	de, #_map_compressed
      0003AE 01               [16]  228 	push	de
      0003AF FF FF 00         [24]  229 	call	_rle_init
      0003B2 F3               [12]  230 	pop	hl
                                    231 ;src/main.c:77: rle_decompress(data, MAP_DATA_HEIGHT);
      0003B3 00 E5            [ 8]  232 	ld	a, #0x12
      0003B5 12               [16]  233 	push	af
      0003B6 F2               [ 8]  234 	inc	sp
      0003B7 0D 6F 90         [12]  235 	ld	de, #_data
      0003BA 21               [16]  236 	push	de
      0003BB DE 00 FF         [24]  237 	call	_rle_decompress
      0003BE 80 FF            [16]  238 	add	sp, #3
      000F05                        239 00103$:
                                    240 ;src/main.c:83: set_bkg_tiles(map_x_column, 0, 1, MAP_DATA_HEIGHT, data);
      0003C0 47 80 9B         [12]  241 	ld	de, #_data
      0003C3 44               [16]  242 	push	de
      0003C4 C7 38 FF         [12]  243 	ld	hl, #0x1201
      0003C7 00               [16]  244 	push	hl
      0003C8 36               [ 4]  245 	xor	a, a
      0003C9 C9               [16]  246 	push	af
      0003CA 04               [ 8]  247 	inc	sp
      0003CB FB 00            [12]  248 	ldhl	sp,	#5
      0003CD FF               [ 8]  249 	ld	a, (hl)
      0003CE 01               [16]  250 	push	af
      0003CF FF               [ 8]  251 	inc	sp
      0003D0 FC 03 FC         [24]  252 	call	_set_bkg_tiles
      0003D3 00 FA            [16]  253 	add	sp, #6
      0003D5 04 FD            [12]  254 	jr	00107$
                                    255 ;src/main.c:86: }
      0003D7 02               [ 8]  256 	inc	sp
      0003D8 3E               [16]  257 	ret
                                    258 	.area _CODE
                                    259 	.area _INITIALIZER
      000000                        260 __xinit__scrollpos:
      0003D9 C1                     261 	.db #0x00	; 0
      000001                        262 __xinit__datapos:
      0003DA BF                     263 	.db #0x00	; 0
                                    264 	.area _CABS (ABS)
