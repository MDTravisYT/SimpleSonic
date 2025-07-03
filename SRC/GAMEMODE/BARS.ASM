; +-----------------------------------------------------------+    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
; |                                                           |    ▒▒▒▒▒▒▒▓██▒▒▒▓████▒▒███▓▒▒▓██▒▒▒▒████████████▓▒▒
; |        Color bar test                                     |    ▒▒▒▒▒▒▓███▒▒▓█████▓▓███▓▒▒██▒▒██▒▒▓████████████▒
; |                                                           |    ▒▒▒▒▒▓████▒▓██████▒▒██▒▒▒▒▒▓▓██▒▒▒▒▒▒▒███▓▒▒▒▒▒▒
; |                  Now you can see the full power           |    ▒▒▒▒▓█████████████▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███▒▒▒▒▒▒
; |                   of the NAKA FADE!                       |    ▒▒▒▓██████████████▒▒██▒▒▒▒▓█████▒▒▒▒▒▒▒███▓▒▒▒▒▒
; |                (10,000 green screen explosions)           |    ▒▒▓███████████████▓▓███████████▓▒▒▒▒▒▒▒▓███▒▒▒▒▒
; |                                                           |    ▒▓████████████████▒▒█████████▓▒▒▒▒▒▒▒▒▒▒███▓▒▒▒▒
; +-----------------------------------------------------------+    ░░░░░░░░░░░░░░░░░░░░MDTRAVIS░░░░░░░░░░░░░░░░░░░░

BARS:
		move.w	#$8700,VDPCTRL		; Background palette/color: 0/0
		jsr		CLEARSCREEN
		
		move.l	#CRAMWRITE,VDPCTRL	; set VDP to CRAM write
		moveq	#$1F,d3	; set repeat times
	@cramclrloop:
		move.l	#0,VDPDATA	; clear 2 palettes
		dbf	d3,@cramclrloop	; repeat until the entire CRAM is clear
		
		move.l	#$40200000,	(VDPCTRL)
		LEA		cb_art,		A0
		LEA		VDPDATA,	A1
		MOVE.W	#$120-1,		D0
	@LOADGFX:
		MOVE.W	(A0)+,	(A1)
		DBF		D0,	@LOADGFX
					
		COPYTILEMAP	cb_map,$8000,40-1,28-1
		
		move.b	#0,RAM_START
	@loop2:
		moveq	#0,	d0
		move.b	RAM_START,d0		; load palette
		lsl.w	#4,	d0
		moveq	#16-1,	d1
		lea		cb_pal,	a0
		add.w	d0,	a0
		lea		PALFADEBUFFER,	a1
	@loadpal:
		move.w	(a0)+,(a1)+
		dbf		d1,@loadpal
		move.w	#34,	TIMER
		jsr		PALFADEIN
		
	@loop:
		move.b	#4,(VBLANKCMD).w
		jsr		VSYNC
		tst.w	TIMER
		bne.s	@loop
		jsr		PALFADEOUT
		add.b	#2,	RAM_START
		cmpi.b	#$40,	RAM_START
		bne.s	@loop2
	;	move.b	#id_AdvancedDebug,	v_gamemode
		rts

cb_map:		incbin		"MAP\BARS.MAP"
cb_art:		incbin		"ART\BARS.UNC"
	cb_art_end:
cb_pal:		incbin		"PAL\BARS.PAL"
