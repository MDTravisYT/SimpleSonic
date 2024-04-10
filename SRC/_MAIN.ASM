		INCLUDE		"SRC/SYSTEM/RAM.I"
		INCLUDE		"SRC/SYSTEM/MACRO.I"
		INCLUDE		"SRC/SYSTEM/HEADER.ASM"

INT:
ERROR:
		move.l	#CRAMWRITE,	(VDPCTRL)		;	Set VDP control mode to manually write a palette to CRAM
		move.w	#$000E,		VDPDATA			;	Palleting...
		BRA.S		INT
		
		INCLUDE		"SRC/SYSTEM/SECURITY.ASM"
START:
		move.w	#$8000+%00000100,(VDPCTRL)
		move.w	#$8100+%01010100,(VDPCTRL)
		move.w	#$8200+(PLANE_A>>10),(VDPCTRL)
		move.w	#$8300+(PLANE_W/$800),(VDPCTRL)
		move.w	#$8400+(PLANE_B>>13),(VDPCTRL)
		move.w	#$8500+%01111100,(VDPCTRL)
		move.w	#$8600+%00000000,(VDPCTRL)
		move.w	#$8700+%00000000,(VDPCTRL)
		move.w	#$8800+%00000000,(VDPCTRL)
		move.w	#$8900+%00000000,(VDPCTRL)
		move.w	#$8A00+%00000000,(VDPCTRL)
		move.w	#$8B00+%00000000,(VDPCTRL)
		move.w	#$8C00+%10000001,(VDPCTRL)
		move.w	#$8D00+%00111111,(VDPCTRL)
		move.w	#$8E00+%00000000,(VDPCTRL)
		move.w	#$8F00+%00000010,(VDPCTRL)
		move.w	#$9000+%00000001,(VDPCTRL)
		move.w	#$9100+%00000000,(VDPCTRL)
		move.w	#$9200+%00000000,(VDPCTRL)
		
		move.l	#VRAMWRITE,	(VDPCTRL)
		LEA		FONT,		A0
		LEA		VDPDATA,	A1
	;	MOVE.L	#$40000000,	A1
		MOVE.W	#$17FF,		D0
	@LOADGFX:
		MOVE.W	(A0)+,	(A1)
		DBF		D0,	@LOADGFX
		
	COPYTILEMAP		TITLEMAP,	$8000,	31,	31
		
		move.l	#CRAMWRITE,	(VDPCTRL)		;	Set VDP control mode to manually write a palette to CRAM
		move.w	#$0000,		VDPDATA			;	Palleting...
		move.w	#$0EEE,		VDPDATA			;	Palleting...
	LOOP:
		bra.s	LOOP
		
		INCLUDE		"SRC/SYSTEM/HBLANK.ASM"
		INCLUDE		"SRC/SYSTEM/VBLANK.ASM"
		
DrawTileMap:		;	SUBROUTINE
                lea     VDPDATA,a6
                move.l  #$800000,d4

.LoopRow:                           
                move.l  d0,4(a6)    ; VDPCTRL
                move.w  d1,d3

.LoopColumn: 
                move.w  (a1)+,(a6)
                dbf     d3,.LoopColumn
                add.l   d4,d0
                dbf     d2,.LoopRow
                rts
		
	ALIGN	$18000
FONT:		INCBIN		"ART/FONT.UNC"
TITLEMAP:	INCBIN		"MAP/TITLE.MAP"