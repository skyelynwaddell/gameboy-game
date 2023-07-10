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
                                    118 ;src/main.c:28: HIDE_LEFT_COLUMN;
      000209 0B E8 17         [13]  119 	ld	a, (_shadow_VDP_R0+0)
      00020C FC 03            [ 7]  120 	or	a, #0x20
      00020E FD 03 FF         [13]  121 	ld	(_shadow_VDP_R0+0), a
      000211 FF FF            [ 9]  122 	ld	a,i
      000213 FF               [ 4]  123 	di
      000214 FC               [11]  124 	push	af
      000215 FF F9 FF         [13]  125 	ld	a, (_shadow_VDP_R0+0)
      000218 FF FF            [11]  126 	out	(_VDP_CMD), a
      00021A FF FF            [ 7]  127 	ld	a, #0x80
      00021C FF FF            [11]  128 	out	(_VDP_CMD), a
      00021E FF               [10]  129 	pop	af
      00021F FF F7 FF         [10]  130 	jp	PO, 00145$
      000222 FF               [ 4]  131 	ei
      000E68                        132 00145$:
                                    133 ;src/main.c:33: set_bkg_data(0, INCBIN_SIZE(map_tiles) >> 4, map_tiles);
      000223 FF FF FF         [10]  134 	ld	de, #_map_tiles+0
      000226 FF FF FF         [10]  135 	ld	bc, #___size_map_tiles+0
      000229 FF FF            [ 8]  136 	srl	b
      00022B FF FF            [ 8]  137 	rr	c
      00022D FF FF            [ 8]  138 	srl	b
      00022F FF 8F            [ 8]  139 	rr	c
      000231 FF DF            [ 8]  140 	srl	b
      000233 FF FF            [ 8]  141 	rr	c
      000235 FF F8            [ 8]  142 	srl	b
      000237 FF F0            [ 8]  143 	rr	c
                                    144 ;../../../include/sms/sms.h:534: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
      000239 FF B9 FF         [16]  145 	ld	hl, (__current_2bpp_palette)
      00023C FF               [11]  146 	push	hl
      00023D FF               [11]  147 	push	de
      00023E FF               [11]  148 	push	bc
      00023F FF 07 FF         [10]  149 	ld	hl, #0x0000
      000242 83               [11]  150 	push	hl
      000243 FF CF FF         [17]  151 	call	_set_tile_2bpp_data
                                    152 ;src/main.c:36: rle_init(map_compressed);
      000246 F1 FF FB         [10]  153 	ld	hl, #_map_compressed
      000249 FF FF FF         [17]  154 	call	_rle_init
                                    155 ;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
      00024C FF FF FF FF      [19]  156 	ld	-1 (ix), #0x00
      000E95                        157 00114$:
      000250 2F D0 39         [19]  158 	ld	a, -1 (ix)
      000253 C2 7B            [ 7]  159 	sub	a, #0x21
      000255 84 7F            [12]  160 	jr	Z, 00103$
                                    161 ;src/main.c:42: rle_decompress(data, MAP_DATA_HEIGHT);
      000257 80 67            [ 7]  162 	ld	a, #0x12
      000259 98               [11]  163 	push	af
      00025A 24               [ 6]  164 	inc	sp
      00025B DB 80 FF         [10]  165 	ld	hl, #_data
      00025E C0               [11]  166 	push	hl
      00025F FF CF 00         [17]  167 	call	_rle_decompress
                                    168 ;src/main.c:47: set_bkg_tiles(i & (DEVICE_SCREEN_BUFFER_WIDTH-1), 0, 1, MAP_DATA_HEIGHT, data);
      000262 97 48 CF         [10]  169 	ld	bc, #_data
      000265 30 FF 00         [19]  170 	ld	a, -1 (ix)
      000268 36 C9            [ 7]  171 	and	a, #0x1f
      00026A 04               [11]  172 	push	bc
      00026B FB 00            [ 7]  173 	ld	h, #0x12
                                    174 ;	spillPairReg hl
                                    175 ;	spillPairReg hl
      00026D FF               [11]  176 	push	hl
      00026E 01               [ 6]  177 	inc	sp
      00026F FF FF            [ 7]  178 	ld	h, #0x01
                                    179 ;	spillPairReg hl
                                    180 ;	spillPairReg hl
      000271 00               [11]  181 	push	hl
      000272 FF               [ 6]  182 	inc	sp
      000273 00 FF            [ 7]  183 	ld	h, #0x00
                                    184 ;	spillPairReg hl
                                    185 ;	spillPairReg hl
      000275 00               [11]  186 	push	hl
      000276 FF               [ 6]  187 	inc	sp
      000277 00               [11]  188 	push	af
      000278 6F               [ 6]  189 	inc	sp
      000279 90 21 DE         [17]  190 	call	_set_tile_map_compat
                                    191 ;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
      00027C 00 FF 80         [23]  192 	inc	-1 (ix)
      00027F FF FF            [12]  193 	jr	00114$
      000EC6                        194 00103$:
                                    195 ;src/main.c:51: datapos = 0;
      000281 00 FF 00         [10]  196 	ld	hl, #_datapos
      000284 FF 00            [10]  197 	ld	(hl), #0x00
                                    198 ;src/main.c:52: scrollpos = 1;
      000286 FF 00 36         [10]  199 	ld	hl, #_scrollpos
      000289 C9 04            [10]  200 	ld	(hl), #0x01
                                    201 ;src/main.c:53: while(TRUE) {
      000ED0                        202 00109$:
                                    203 ;src/main.c:55: wait_vbl_done();
      00028B FB 00 FF         [17]  204 	call	_wait_vbl_done
                                    205 ;src/main.c:60: scrollpos++;
      00028E 01 FF FF         [10]  206 	ld	hl, #_scrollpos
      000291 00               [11]  207 	inc	(hl)
                                    208 ;src/main.c:61: move_bkg(scrollpos, 0);
      000292 FF 00 FC         [13]  209 	ld	a, (_scrollpos+0)
      000295 03               [ 4]  210 	ld	c, a
                                    211 ;../../../include/sms/sms.h:195: __WRITE_VDP_REG(VDP_RSCX, -x);
      000296 F9 04 6F         [10]  212 	ld	hl, #_shadow_VDP_RSCX
      000299 90               [ 4]  213 	xor	a, a
      00029A 21               [ 4]  214 	sub	a, c
      00029B DE               [ 7]  215 	ld	(hl), a
      00029C 00 FF            [ 9]  216 	ld	a,i
      00029E 80               [ 4]  217 	di
      00029F FF               [11]  218 	push	af
      0002A0 F7 08 FF         [13]  219 	ld	a, (_shadow_VDP_RSCX+0)
      0002A3 00 FF            [11]  220 	out	(_VDP_CMD), a
      0002A5 00 FF            [ 7]  221 	ld	a, #0x88
      0002A7 00 36            [11]  222 	out	(_VDP_CMD), a
      0002A9 C9               [10]  223 	pop	af
      0002AA 04 FB 00         [10]  224 	jp	PO, 00148$
      0002AD FF               [ 4]  225 	ei
      000EF3                        226 00148$:
                                    227 ;../../../include/sms/sms.h:196: __WRITE_VDP_REG(VDP_RSCY, y);
      0002AE 01 FF FF         [10]  228 	ld	hl, #_shadow_VDP_RSCY
      0002B1 00 F3            [10]  229 	ld	(hl), #0x00
      0002B3 00 E5            [ 9]  230 	ld	a,i
      0002B5 12               [ 4]  231 	di
      0002B6 F2               [11]  232 	push	af
      0002B7 0D 6F            [ 7]  233 	ld	a, #0x00
      0002B9 90 21            [11]  234 	out	(_VDP_CMD), a
      0002BB DE 00            [ 7]  235 	ld	a, #0x89
      0002BD FF 80            [11]  236 	out	(_VDP_CMD), a
      0002BF FF               [10]  237 	pop	af
      0002C0 47 80 9B         [10]  238 	jp	PO, 00150$
      0002C3 44               [ 4]  239 	ei
      000F09                        240 00150$:
                                    241 ;src/main.c:65: if ((scrollpos & 0x07u) == 0) {
      0002C4 C7               [ 4]  242 	ld	a, c
      0002C5 38 FF            [ 7]  243 	and	a, #0x07
      0002C7 00 36            [12]  244 	jr	NZ, 00109$
                                    245 ;src/main.c:69: datapos = (scrollpos >> 3);
      0002C9 C9 04 FB         [13]  246 	ld	a, (_scrollpos+0)
      0002CC 00               [ 4]  247 	rrca
      0002CD FF               [ 4]  248 	rrca
      0002CE 01               [ 4]  249 	rrca
      0002CF FF FC            [ 7]  250 	and	a, #0x1f
      0002D1 03 FC 00         [13]  251 	ld	(_datapos+0), a
                                    252 ;src/main.c:70: uint8_t map_x_column = (datapos + DEVICE_SCREEN_WIDTH) & (DEVICE_SCREEN_BUFFER_WIDTH-1);
      0002D4 FA 04 FD         [13]  253 	ld	a, (_datapos+0)
      0002D7 02 3E            [ 7]  254 	add	a, #0x20
      0002D9 C1 BF            [ 7]  255 	and	a, #0x1f
      0002DB 00 FF 00         [19]  256 	ld	-1 (ix), a
                                    257 ;src/main.c:75: if (!rle_decompress(data, MAP_DATA_HEIGHT)) {
      0002DE FF 00            [ 7]  258 	ld	a, #0x12
      0002E0 BC               [11]  259 	push	af
      0002E1 43               [ 6]  260 	inc	sp
      0002E2 00 00 81         [10]  261 	ld	hl, #_data
      0002E5 00               [11]  262 	push	hl
      0002E6 44 83 30         [17]  263 	call	_rle_decompress
      0002E9 CF               [ 4]  264 	ld	a, l
      0002EA B9               [ 4]  265 	or	a, a
      0002EB 46 D3            [12]  266 	jr	NZ, 00105$
                                    267 ;src/main.c:76: rle_init(map_compressed);
      0002ED 2C FF 00         [10]  268 	ld	hl, #_map_compressed
      0002F0 F1 0E 04         [17]  269 	call	_rle_init
                                    270 ;src/main.c:77: rle_decompress(data, MAP_DATA_HEIGHT);
      0002F3 00 0A            [ 7]  271 	ld	a, #0x12
      0002F5 04               [11]  272 	push	af
      0002F6 91               [ 6]  273 	inc	sp
      0002F7 0E 46 B9         [10]  274 	ld	hl, #_data
      0002FA 67               [11]  275 	push	hl
      0002FB 98 AF 50         [17]  276 	call	_rle_decompress
      000F43                        277 00105$:
                                    278 ;src/main.c:83: set_bkg_tiles(map_x_column, 0, 1, MAP_DATA_HEIGHT, data);
      0002FE FF 00 F1         [10]  279 	ld	hl, #_data
      000301 0F               [11]  280 	push	hl
      000302 05 00 0A         [10]  281 	ld	hl, #0x1201
      000305 05               [11]  282 	push	hl
      000306 90               [ 4]  283 	xor	a, a
      000307 0F               [11]  284 	push	af
      000308 44               [ 6]  285 	inc	sp
      000309 BB 64 9B         [19]  286 	ld	a, -1 (ix)
      00030C A8               [11]  287 	push	af
      00030D 57               [ 6]  288 	inc	sp
      00030E FA 05 3C         [17]  289 	call	_set_tile_map_compat
      000311 C3 81 00         [10]  290 	jp	00109$
                                    291 ;src/main.c:86: }
      000314 06               [ 6]  292 	inc	sp
      000315 01 9C            [14]  293 	pop	ix
      000317 03               [10]  294 	ret
                                    295 	.area _CODE
                                    296 	.area _INITIALIZER
      000000                        297 __xinit__scrollpos:
      000318 64                     298 	.db #0x00	; 0
      000001                        299 __xinit__datapos:
      000319 9B                     300 	.db #0x00	; 0
                                    301 	.area _CABS (ABS)
