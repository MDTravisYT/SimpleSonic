PROCESSSCROLLINGTILES:
		LEA		(VDPCTRL).L,	A5
		LEA		(VDPDATA).L,	A6
		LEA		(SCROLL_BG1FLAGS).W,	A2
		LEA		(SCROLL_BGPOSX).W,	A3
		LEA		((LEVEL_LAYOUT+$40)).W,	A4
		MOVE.W	#$6000,	D2
		BSR.W	DRAWBGSCROLLBLOCK1
		LEA		(SCROLL_BG2FLAGS).W,	A2
		LEA		(SCROLL_BG2POSX).W,	A3
		BSR.W	DRAWBGSCROLLBLOCK2
		LEA		(SCROLL_FGFLAGS).W,	A2
		LEA		(SCROLL_FGPOSX).W,	A3
		LEA		(LEVEL_LAYOUT).W,	A4
		MOVE.W	#$4000,	D2
		TST.B	(A2)
		BEQ.S	LOCRET_4482
		BCLR	#0,	(A2)
		BEQ.S	LOC_4438
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		BSR.W	DRAWLEFTTORIGHT
	LOC_4438:
		BCLR	#1,	(A2)
		BEQ.S	LOC_4452
		MOVE.W	#224,	D4
		MOVEQ	#-16,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVE.W	#224,	D4
		MOVEQ	#-16,	D5
		BSR.W	DRAWLEFTTORIGHT
	LOC_4452:
		BCLR	#2,	(A2)
		BEQ.S	LOC_4468
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		BSR.W	DRAWTOPTOBOTTOM
	LOC_4468:
		BCLR	#3,	(A2)
		BEQ.S	LOCRET_4482
		MOVEQ	#-16,	D4
		MOVE.W	#320,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVEQ	#-16,	D4
		MOVE.W	#320,	D5
		BSR.W	DRAWTOPTOBOTTOM
	LOCRET_4482:
		RTS
		
DRAWBGSCROLLBLOCK1:
		TST.B	(A2)
		BEQ.W	@SKIP
		BCLR	#0,	(A2)
		BEQ.S	@LOC_44A2
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		MOVEQ	#32-1,	D6
		BSR.W	DRAWLEFTTORIGHT2
	@LOC_44A2:
		BCLR	#1,	(A2)
		BEQ.S	@LOC_44BE
		MOVE.W	#224,	D4
		MOVEQ	#-16,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVE.W	#224,	D4
		MOVEQ	#-16,	D5
		MOVEQ	#32-1,	D6
		BSR.W	DRAWLEFTTORIGHT2
	@LOC_44BE:
		BCLR	#2,	(A2)
		BEQ.S	@SKIPLOAD
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVEQ	#-16,	D4
		MOVEQ	#-16,	D5
		MOVE.W	(SCROLLBLOCKSIZE).W,	D6
		MOVE.W	3(A3),	D1
		ANDI.W	#$FFF0,	D1
		SUB.W	D1,	D6
		BLT.S	@SKIPLOAD
		LSR.W	#4,	D6
		CMPI.W	#16-1,	D6
		BCS.S	@LOC_44EA
		MOVEQ	#16-1,	D6
	@LOC_44EA:
		BSR.W	DRAWTOPTOBOTTOM2
	@SKIPLOAD:
		BCLR	#3,	(A2)
		BEQ.S	@SKIP
		MOVEQ	#-16,	D4
		MOVE.W	#320,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVEQ	#-16,	D4
		MOVE.W	#320,	D5
		MOVE.W	(SCROLLBLOCKSIZE).W,	D6
		MOVE.W	4(A3),	D1
		ANDI.W	#$FFF0,	D1
		SUB.W	D1,	D6
		BLT.S	@SKIP
		LSR.W	#4,	D6
		CMPI.W	#16-1,	D6
		BCS.S	@LOC_451E
		MOVEQ	#16-1,	D6
	@LOC_451E:
		BSR.W	DRAWTOPTOBOTTOM2
	@SKIP:
		RTS
		
DRAWLEFTTORIGHT:
		MOVEQ	#22-1,	D6
	DRAWLEFTTORIGHT2:
		MOVE.L	#$800000,	D7
		MOVE.L	D0,	D1
	@LOOP:
		MOVEM.L	D4-D5,-(SP)
		BSR.W	GETBLOCKDATA
		MOVE.L	D1,	D0
		BSR.W	DRAWBLOCK
		ADDQ.B	#4,	D1
		ANDI.B	#$7F,	D1
		MOVEM.L	(SP)+,	D4-D5
		ADDI.W	#16,	D5
		DBF		D6,	@LOOP
		RTS
		
DRAWBGSCROLLBLOCK2:
		TST.B	(A2)
		BEQ.W	@EXIT
		BCLR	#2,	(A2)
		BEQ.S	@LOC_456E
		CMPI.W	#$10,	(A3)
		BCS.S	@LOC_456E
		MOVE.W	(SCROLLBLOCKSIZE).W,	D4
		MOVE.W	4(A3),	D1
		ANDI.W	#$FFF0,	D1
		SUB.W	D1,	D4
		MOVE.W	D4,	-(SP)
		MOVEQ	#-16,	D5
		BSR.W	CALCBLOCKSVRAM
		MOVE.W	(SP)+,	D4
		MOVEQ	#-16,	D5
		MOVE.W	(SCROLLBLOCKSIZE).W,	D6
		MOVE.W	4(A3),	D1
		ANDI.W	#$FFF0,	D1
		SUB.W	D1,	D6
		BLT.S	@LOC_456E
		LSR.W	#4,	D6
		SUBI.W	#$E,	D6
		BCC.S	@LOC_456E
		NEG.W	D6
		BSR.W	DRAWTOPTOBOTTOM2
	@LOC_456E:
		BCLR	#3,	(A2)
		BEQ.S	@EXIT
		MOVE.W	(SCROLLBLOCKSIZE).W,	D5
		MOVE.W	4(A3),	D1
		ANDI.W	#$FFF0,	D1
		SUB.W	D1,	D4
		MOVE.W	D4,	-(SP)
		MOVE.W	#320,	D5
		MOVE.W	(SCROLLBLOCKSIZE).W,	D6
		MOVE.W	4(A3),	D1
		ANDI.W	#$FFF0,	D1
		SUB.W	D1,	D6
		BLT.S	@EXIT
		LSR.W	#4,	D6
		SUBI.W	#$E,	D6
		BCC.S	@EXIT
		NEG.W	D6
		BSR.W	DRAWTOPTOBOTTOM2
	@EXIT:
		RTS
		
DRAWTOPTOBOTTOM:
		MOVEQ	#((224+16+16)/16)-1,	D6
	DRAWTOPTOBOTTOM2:
		MOVE.L	#$800000,	D7
		MOVE.L	D0,	D1
	@LOOP:
		MOVEM.L	D4-D5,	-(SP)
		BSR.W	GETBLOCKDATA
		MOVE.L	D1,	D0
		BSR.W	DRAWBLOCK
		ADDI.W	#256,	D1
		ANDI.W	#$FFF,	D1
		MOVEM.L	(SP)+,	D4-D5
		ADDI.W	#16,	D4
		DBF	D6,	@LOOP
		RTS
		
DRAWBLOCK:                              ; ...
                OR.W    D2,D0
                SWAP    D0
                BTST    #4,(A0)
                BNE.S   @DRAWFLIPY
                BTST    #3,(A0)
                BNE.S   @DRAWFLIPX
                MOVE.L  D0,(A5)
                MOVE.L  (A1)+,(A6)
                ADD.L   D7,D0
                MOVE.L  D0,(A5)
                MOVE.L  (A1)+,(A6)
                RTS
; ---------------------------------------------------------------------------

@DRAWFLIPX:                            ; ...
                MOVE.L  D0,(A5)
                MOVE.L  (A1)+,D4
                EORI.L  #$8000800,D4
                SWAP    D4
                MOVE.L  D4,(A6)
                ADD.L   D7,D0
                MOVE.L  D0,(A5)
                MOVE.L  (A1)+,D4
                EORI.L  #$8000800,D4
                SWAP    D4
                MOVE.L  D4,(A6)
                RTS
; ---------------------------------------------------------------------------

@DRAWFLIPY:                            ; ...
                BTST    #3,(A0)
                BNE.S   @DRAWFLIPXY
                MOVE.L  D0,(A5)
                MOVE.L  (A1)+,D5
                MOVE.L  (A1)+,D4
                EORI.L  #$10001000,D4
                MOVE.L  D4,(A6)
                ADD.L   D7,D0
                MOVE.L  D0,(A5)
                EORI.L  #$10001000,D5
                MOVE.L  D5,(A6)
                RTS
; ---------------------------------------------------------------------------

@DRAWFLIPXY:                           ; ...
                MOVE.L  D0,(A5)
                MOVE.L  (A1)+,D5
                MOVE.L  (A1)+,D4
                EORI.L  #$18001800,D4
                SWAP    D4
                MOVE.L  D4,(A6)
                ADD.L   D7,D0
                MOVE.L  D0,(A5)
                EORI.L  #$18001800,D5
                SWAP    D5
                MOVE.L  D5,(A6)
                RTS
; ---------------------------------------------------------------------------
                RTS
; END OF FUNCTION DRAWBLOCK
	
GETBLOCKDATA:
		LEA     (LEVELBLOCKS).W,A1
		ADD.W   4(A3),D4
		ADD.W   (A3),D5 
		MOVE.W  D4,D3
		LSR.W   #1,D3
		ANDI.W  #$380,D3
		LSR.W   #3,D5
		MOVE.W  D5,D0
		LSR.W   #5,D0
		ANDI.W  #$7F,D0
		ADD.W   D3,D0
		MOVEQ   #-1,D3
		MOVE.B  (A4,D0.W),D3
		ANDI.B  #$7F,D3
		BEQ.S   @END
		SUBQ.B  #1,D3
		EXT.W   D3
		ROR.W   #7,D3
		ADD.W   D4,D4
		ANDI.W  #$1E0,D4
		ANDI.W  #$1E,D5
		ADD.W   D4,D3
		ADD.W   D5,D3
		MOVEA.L D3,A0
		MOVE.W  (A0),D3
		ANDI.W  #$3FF,D3
		LSL.W   #3,D3
		ADDA.W  D3,A1
	@END:
		RTS
	
CALCBLOCKSVRAM:
		ADD.W	4(A3),	D4
		ADD.W	(A3),	D5
		ANDI.W	#$F0,	D4
		ANDI.W	#$1F0,	D5
		LSL.W	#4,	D4
		LSR.W	#2,	D5
		ADD.W	D5,	D4
		MOVEQ	#3,	D0
		SWAP	D0
		MOVE.W	D4,	D0
		RTS