LEVEL:
		JSR		CLEARSCREEN
		
		MOVE.W	#$9200+%10000000+24,(VDPCTRL)      ;	WINDOW PLANE VERTICAL
	COPYTILEMAP		TEMPWINDOW,	$CC00,	39,	3

		MOVE.B	#$10,	(OBJSLOT00)
		LEA		(OBJSLOT00),	A0
		MOVE.W	#160,	OBJ.X(A0)
		MOVE.W	#112,	OBJ.Y(A0)
		MOVE.B	#$2,	(OBJSLOT01)
		MOVE.B	#$3,	(OBJSLOT02)
		JSR		RUNOBJECTS
		JSR		PROCESSSPRITES
		
		LEA		TITLEPAL,	A0
		LEA		PALFADEBUFFER,	A1
		MOVE.B	#32,	D0
	@PALLOOP:
		MOVE.L	(A0)+,	(A1)+
		DBF		D0,	@PALLOOP
		
		JSR		PALFADEIN
		
	@LOOP:
		MOVE.B	#4,	(VBLANKCMD).W
		JSR		VSYNC
		JSR		RUNOBJECTS
		JSR		PROCESSSPRITES
		BRA.S	@LOOP
		
TEMPWINDOW:
	rept	256
		DC.W	$8001
	endr