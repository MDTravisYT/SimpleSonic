VSYNC:
		MOVE	#$2300,	SR
	@WAIT:
		TST.B	(VBLANKCMD).W
		BNE.S	@WAIT
		RTS