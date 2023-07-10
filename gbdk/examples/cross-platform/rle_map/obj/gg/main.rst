                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.2.2 #13350 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mz80
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
                                     18 	.globl _set_tile_map_compat
                                     19 	.globl _set_tile_2bpp_data
                                     20 	.globl _wait_vbl_done
                                     21 	.globl _datapos
                                     22 	.globl _scrollpos
                                     23 	.globl _data
                                     24 ;--------------------------------------------------------
                                     25 ; special function registers
                                     26 ;--------------------------------------------------------
                           00003E    27 _MEMORY_CTL	=	0x003e
                           00003F    28 _JOY_CTL	=	0x003f
                           00007E    29 _VCOUNTER	=	0x007e
                           00007F    30 _PSG	=	0x007f
                           00007F    31 _HCOUNTER	=	0x007f
                           0000BE    32 _VDP_DATA	=	0x00be
                           0000BF    33 _VDP_CMD	=	0x00bf
                           0000BF    34 _VDP_STATUS	=	0x00bf
                           0000DC    35 _JOY_PORT1	=	0x00dc
                           0000DD    36 _JOY_PORT2	=	0x00dd
                           0000F0    37 _FMADDRESS	=	0x00f0
                           0000F1    38 _FMDATA	=	0x00f1
                           0000F2    39 _AUDIOCTRL	=	0x00f2
                                     40 ;--------------------------------------------------------
                                     41 ; ram data
                                     42 ;--------------------------------------------------------
                                     43 	.area _DATA
                           00FFFC    44 _RAM_CONTROL	=	0xfffc
                           00FFF8    45 _GLASSES_3D	=	0xfff8
                           00FFFD    46 _MAP_FRAME0	=	0xfffd
                           00FFFE    47 _MAP_FRAME1	=	0xfffe
                           00FFFF    48 _MAP_FRAME2	=	0xffff
      00C0C2                         49 _data::
      00C0C2                         50 	.ds 18
                                     51 ;--------------------------------------------------------
                                     52 ; ram data
                                     53 ;--------------------------------------------------------
                                     54 	.area _INITIALIZED
      00C0EA                         55 _scrollpos::
      00C0EA                         56 	.ds 1
      00C0EB                         57 _datapos::
      00C0EB                         58 	.ds 1
                                     59 ;--------------------------------------------------------
                                     60 ; absolute external ram data
                                     61 ;--------------------------------------------------------
                                     62 	.area _DABS (ABS)
                                     63 ;--------------------------------------------------------
                                     64 ; global & static initialisations
                                     65 ;--------------------------------------------------------
                                     66 	.area _HOME
                                     67 	.area _GSINIT
                                     68 	.area _GSFINAL
                                     69 	.area _GSINIT
                                     70 ;--------------------------------------------------------
                                     71 ; Home
                                     72 ;--------------------------------------------------------
                                     73 	.area _HOME
                                     74 	.area _HOME
                                     75 ;--------------------------------------------------------
                                     76 ; code
                                     77 ;--------------------------------------------------------
                                     78 	.area _CODE
                                     79 ;src/main.c:8: INCBIN(map_tiles, "res/map_tiles.bin")
                                     80 ;	---------------------------------
                                     81 ; Function __func_map_tiles
                                     82 ; ---------------------------------
                           000000    83 	b___func_map_tiles	= 0
      000100                         84 ___func_map_tiles::
      000100                         85 _map_tiles::
      000100                         86 1$:
      000100 FF 00 FF 00 FF 00 FF    87 	.incbin "res/map_tiles.bin" 
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
      000780                         88 2$:
                           000780    89 	___size_map_tiles = (2$-1$) 
                                     90 	.globl ___size_map_tiles 
                                     91 	.local b___func_map_tiles 
                           000000    92 	___bank_map_tiles = b___func_map_tiles 
                                     93 	.globl ___bank_map_tiles 
                                     94 ;src/main.c:15: INCBIN(map_compressed, "res/map.bin.rle")
                                     95 ;	---------------------------------
                                     96 ; Function __func_map_compressed
                                     97 ; ---------------------------------
                           000000    98 	b___func_map_compressed	= 0
      000780                         99 ___func_map_compressed::
      000780                        100 _map_compressed::
      000780                        101 1$:
      000180 FF FF DF FF F0 FF E0   102 	.incbin "res/map.bin.rle" 
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
      000E45                        103 2$:
                           0006C5   104 	___size_map_compressed = (2$-1$) 
                                    105 	.globl ___size_map_compressed 
                                    106 	.local b___func_map_compressed 
                           000000   107 	___bank_map_compressed = b___func_map_compressed 
                                    108 	.globl ___bank_map_compressed 
                                    109 ;src/main.c:22: void main() {
                                    110 ;	---------------------------------
                                    111 ; Function main
                                    112 ; ---------------------------------
      000E45                        113 _main::
      000200 40 87            [15]  114 	push	ix
      000202 9A 45 C2 3D      [14]  115 	ld	ix,#0
      000206 FC 03            [15]  116 	add	ix,sp
      000208 F4               [ 6]  117 	dec	sp
                                    118 ;src/main.c:33: set_bkg_data(0, INCBIN_SIZE(map_tiles) >> 4, map_tiles);
      000209 0B E8 17         [10]  119 	ld	de, #_map_tiles+0
      00020C FC 03 FD         [10]  120 	ld	bc, #___size_map_tiles+0
      00020F 03 FF            [ 8]  121 	srl	b
      000211 FF FF            [ 8]  122 	rr	c
      000213 FF FC            [ 8]  123 	srl	b
      000215 FF F9            [ 8]  124 	rr	c
      000217 FF FF            [ 8]  125 	srl	b
      000219 FF FF            [ 8]  126 	rr	c
      00021B FF FF            [ 8]  127 	srl	b
      00021D FF FF            [ 8]  128 	rr	c
                                    129 ;../../../include/sms/sms.h:534: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
      00021F FF F7 FF         [16]  130 	ld	hl, (__current_2bpp_palette)
      000222 FF               [11]  131 	push	hl
      000223 FF               [11]  132 	push	de
      000224 FF               [11]  133 	push	bc
      000225 FF FF FF         [10]  134 	ld	hl, #0x0000
      000228 FF               [11]  135 	push	hl
      000229 FF FF FF         [17]  136 	call	_set_tile_2bpp_data
                                    137 ;src/main.c:36: rle_init(map_compressed);
      00022C FF FF FF         [10]  138 	ld	hl, #_map_compressed
      00022F FF 8F FF         [17]  139 	call	_rle_init
                                    140 ;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
      000232 DF FF FF FF      [19]  141 	ld	-1 (ix), #0x00
      000E7B                        142 00114$:
      000236 F8 FF F0         [19]  143 	ld	a, -1 (ix)
      000239 FF B9            [ 7]  144 	sub	a, #0x15
      00023B FF FF            [12]  145 	jr	Z, 00103$
                                    146 ;src/main.c:42: rle_decompress(data, MAP_DATA_HEIGHT);
      00023D FF FF            [ 7]  147 	ld	a, #0x12
      00023F FF               [11]  148 	push	af
      000240 07               [ 6]  149 	inc	sp
      000241 FF 83 FF         [10]  150 	ld	hl, #_data
      000244 CF               [11]  151 	push	hl
      000245 FF F1 FF         [17]  152 	call	_rle_decompress
                                    153 ;src/main.c:47: set_bkg_tiles(i & (DEVICE_SCREEN_BUFFER_WIDTH-1), 0, 1, MAP_DATA_HEIGHT, data);
      000248 FB FF FF         [10]  154 	ld	bc, #_data
      00024B FF FF FF         [19]  155 	ld	a, -1 (ix)
      00024E FF FF            [ 7]  156 	and	a, #0x1f
      000250 2F               [11]  157 	push	bc
      000251 D0 39            [ 7]  158 	ld	h, #0x12
                                    159 ;	spillPairReg hl
                                    160 ;	spillPairReg hl
      000253 C2               [11]  161 	push	hl
      000254 7B               [ 6]  162 	inc	sp
      000255 84 7F            [ 7]  163 	ld	h, #0x01
                                    164 ;	spillPairReg hl
                                    165 ;	spillPairReg hl
      000257 80               [11]  166 	push	hl
      000258 67               [ 6]  167 	inc	sp
      000259 98 24            [ 7]  168 	ld	h, #0x00
                                    169 ;	spillPairReg hl
                                    170 ;	spillPairReg hl
      00025B DB               [11]  171 	push	hl
      00025C 80               [ 6]  172 	inc	sp
      00025D FF               [11]  173 	push	af
      00025E C0               [ 6]  174 	inc	sp
      00025F FF CF 00         [17]  175 	call	_set_tile_map_compat
                                    176 ;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
      000262 97 48 CF         [23]  177 	inc	-1 (ix)
      000265 30 FF            [12]  178 	jr	00114$
      000EAC                        179 00103$:
                                    180 ;src/main.c:51: datapos = 0;
      000267 00 36 C9         [10]  181 	ld	hl, #_datapos
      00026A 04 FB            [10]  182 	ld	(hl), #0x00
                                    183 ;src/main.c:52: scrollpos = 1;
      00026C 00 FF 01         [10]  184 	ld	hl, #_scrollpos
      00026F FF FF            [10]  185 	ld	(hl), #0x01
                                    186 ;src/main.c:53: while(TRUE) {
      000EB6                        187 00109$:
                                    188 ;src/main.c:55: wait_vbl_done();
      000271 00 FF 00         [17]  189 	call	_wait_vbl_done
                                    190 ;src/main.c:60: scrollpos++;
      000274 FF 00 FF         [10]  191 	ld	hl, #_scrollpos
      000277 00               [11]  192 	inc	(hl)
                                    193 ;src/main.c:61: move_bkg(scrollpos, 0);
      000278 6F 90 21         [13]  194 	ld	a, (_scrollpos+0)
      00027B DE               [ 4]  195 	ld	c, a
                                    196 ;../../../include/sms/sms.h:195: __WRITE_VDP_REG(VDP_RSCX, -x);
      00027C 00 FF 80         [10]  197 	ld	hl, #_shadow_VDP_RSCX
      00027F FF               [ 4]  198 	xor	a, a
      000280 FF               [ 4]  199 	sub	a, c
      000281 00               [ 7]  200 	ld	(hl), a
      000282 FF 00            [ 9]  201 	ld	a,i
      000284 FF               [ 4]  202 	di
      000285 00               [11]  203 	push	af
      000286 FF 00 36         [13]  204 	ld	a, (_shadow_VDP_RSCX+0)
      000289 C9 04            [11]  205 	out	(_VDP_CMD), a
      00028B FB 00            [ 7]  206 	ld	a, #0x88
      00028D FF 01            [11]  207 	out	(_VDP_CMD), a
      00028F FF               [10]  208 	pop	af
      000290 FF 00 FF         [10]  209 	jp	PO, 00146$
      000293 00               [ 4]  210 	ei
      000ED9                        211 00146$:
                                    212 ;../../../include/sms/sms.h:196: __WRITE_VDP_REG(VDP_RSCY, y);
      000294 FC 03 F9         [10]  213 	ld	hl, #_shadow_VDP_RSCY
      000297 04 6F            [10]  214 	ld	(hl), #0x00
      000299 90 21            [ 9]  215 	ld	a,i
      00029B DE               [ 4]  216 	di
      00029C 00               [11]  217 	push	af
      00029D FF 80            [ 7]  218 	ld	a, #0x00
      00029F FF F7            [11]  219 	out	(_VDP_CMD), a
      0002A1 08 FF            [ 7]  220 	ld	a, #0x89
      0002A3 00 FF            [11]  221 	out	(_VDP_CMD), a
      0002A5 00               [10]  222 	pop	af
      0002A6 FF 00 36         [10]  223 	jp	PO, 00148$
      0002A9 C9               [ 4]  224 	ei
      000EEF                        225 00148$:
                                    226 ;src/main.c:65: if ((scrollpos & 0x07u) == 0) {
      0002AA 04               [ 4]  227 	ld	a, c
      0002AB FB 00            [ 7]  228 	and	a, #0x07
      0002AD FF 01            [12]  229 	jr	NZ, 00109$
                                    230 ;src/main.c:69: datapos = (scrollpos >> 3);
      0002AF FF FF 00         [13]  231 	ld	a, (_scrollpos+0)
      0002B2 F3               [ 4]  232 	rrca
      0002B3 00               [ 4]  233 	rrca
      0002B4 E5               [ 4]  234 	rrca
      0002B5 12 F2            [ 7]  235 	and	a, #0x1f
      0002B7 0D 6F 90         [13]  236 	ld	(_datapos+0), a
                                    237 ;src/main.c:70: uint8_t map_x_column = (datapos + DEVICE_SCREEN_WIDTH) & (DEVICE_SCREEN_BUFFER_WIDTH-1);
      0002BA 21 DE 00         [13]  238 	ld	a, (_datapos+0)
      0002BD FF 80            [ 7]  239 	add	a, #0x14
      0002BF FF 47            [ 7]  240 	and	a, #0x1f
      0002C1 80 9B 44         [19]  241 	ld	-1 (ix), a
                                    242 ;src/main.c:75: if (!rle_decompress(data, MAP_DATA_HEIGHT)) {
      0002C4 C7 38            [ 7]  243 	ld	a, #0x12
      0002C6 FF               [11]  244 	push	af
      0002C7 00               [ 6]  245 	inc	sp
      0002C8 36 C9 04         [10]  246 	ld	hl, #_data
      0002CB FB               [11]  247 	push	hl
      0002CC 00 FF 01         [17]  248 	call	_rle_decompress
      0002CF FF               [ 4]  249 	ld	a, l
      0002D0 FC               [ 4]  250 	or	a, a
      0002D1 03 FC            [12]  251 	jr	NZ, 00105$
                                    252 ;src/main.c:76: rle_init(map_compressed);
      0002D3 00 FA 04         [10]  253 	ld	hl, #_map_compressed
      0002D6 FD 02 3E         [17]  254 	call	_rle_init
                                    255 ;src/main.c:77: rle_decompress(data, MAP_DATA_HEIGHT);
      0002D9 C1 BF            [ 7]  256 	ld	a, #0x12
      0002DB 00               [11]  257 	push	af
      0002DC FF               [ 6]  258 	inc	sp
      0002DD 00 FF 00         [10]  259 	ld	hl, #_data
      0002E0 BC               [11]  260 	push	hl
      0002E1 43 00 00         [17]  261 	call	_rle_decompress
      000F29                        262 00105$:
                                    263 ;src/main.c:83: set_bkg_tiles(map_x_column, 0, 1, MAP_DATA_HEIGHT, data);
      0002E4 81 00 44         [10]  264 	ld	hl, #_data
      0002E7 83               [11]  265 	push	hl
      0002E8 30 CF B9         [10]  266 	ld	hl, #0x1201
      0002EB 46               [11]  267 	push	hl
      0002EC D3               [ 4]  268 	xor	a, a
      0002ED 2C               [11]  269 	push	af
      0002EE FF               [ 6]  270 	inc	sp
      0002EF 00 F1 0E         [19]  271 	ld	a, -1 (ix)
      0002F2 04               [11]  272 	push	af
      0002F3 00               [ 6]  273 	inc	sp
      0002F4 0A 04 91         [17]  274 	call	_set_tile_map_compat
      0002F7 0E 46 B9         [10]  275 	jp	00109$
                                    276 ;src/main.c:86: }
      0002FA 67               [ 6]  277 	inc	sp
      0002FB 98 AF            [14]  278 	pop	ix
      0002FD 50               [10]  279 	ret
                                    280 	.area _CODE
                                    281 	.area _INITIALIZER
      000000                        282 __xinit__scrollpos:
      0002FE FF                     283 	.db #0x00	; 0
      000001                        284 __xinit__datapos:
      0002FF 00                     285 	.db #0x00	; 0
                                    286 	.area _CABS (ABS)
