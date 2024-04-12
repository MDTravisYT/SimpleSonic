TITLE:
		move.l	#VRAMWRITE,	(VDPCTRL)
		LEA		FONT,		A0
		LEA		VDPDATA,	A1
	;	MOVE.L	#$40000000,	A1
		MOVE.W	#$17FF,		D0
	@LOADGFX:
		MOVE.W	(A0)+,	(A1)
		DBF		D0,	@LOADGFX
		
	COPYTILEMAP		TITLEMAP,	$C104,	33,	21
			
		MOVE.B	#$1,	(OBJSLOT01)
	LOOP:
		move.l	#CRAMWRITE,	(VDPCTRL)		;	Set VDP control mode to manually write a palette to CRAM
		move.w	#$0000,		VDPDATA			;	Palleting...
		move.w	#$0EEE,		VDPDATA			;	Palleting...
		move.w	#$0060,		VDPDATA			;	Palleting...
		MOVE.B	#2,	(VBLANKCMD).W
		JSR		VSYNC
		JSR		READJOYPADS
		JSR		PROCESSSPRITES
		JSR		RUNOBJECTS
		ANDI.B	#%10000000,	(JOYPADPRESS).W
		BEQ.S	LOOP
		BRA.W	ERROR