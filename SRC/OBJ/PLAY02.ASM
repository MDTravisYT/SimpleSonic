PLAY02:
		MOVEQ	#0,	D0
		MOVE.B	OBJ.ACTION(A0),	D0
		MOVE.W	@INDEX(PC,D0.W),	D1
		JMP		@INDEX(PC,D1.W)
		
	@INDEX:
		DC.W	PLAY02_INIT-@INDEX
		DC.W	PLAY02_DO-@INDEX
		DC.W	PLAY02_DELETE-@INDEX
		DC.W	PLAY02_DELETE-@INDEX
		
PLAY02_INIT:
		ADDQ.B	#2,	OBJ.ACTION(A0)
		MOVE.B	#$12,	OBJ.YRAD(A0)
		MOVE.B	#9,	OBJ.XRAD(A0)
		MOVE.L	#MAP_PLAYER,	OBJ.MAP(A0)
		MOVE.W	#$780,	OBJ.TILE(A0)
		MOVE.B	#4,	OBJ.RENDERFLAGS(A0)
		MOVE.B	#2,	OBJ.PRIORITY(A0)

PLAY02_DO:
		BSR.W	@JOYPADCTRL
		BSR.W	PLAYER_DYNART
		JMP		_OBJECTDISPLAY
		
	@JOYPADCTRL:
		MOVE.B	(JOYPAD).W,	D4
		MOVE.W	OBJ.Y(A0),	D2
		MOVE.W	OBJ.X(A0),	D3
		MOVEQ	#1,	D1
		BTST	#0,	D4
		BEQ.S   LOC_11226
		SUB.W   D1,D2

LOC_11226:		              ; ...
		BTST    #1,D4
		BEQ.S   LOC_1122E
		ADD.W   D1,D2

LOC_1122E:		              ; ...
		BTST    #2,D4
		BEQ.S   LOC_11236
		SUB.W   D1,D3

LOC_11236:		              ; ...
		BTST    #3,D4
		BEQ.S   LOC_1123E
		ADD.W   D1,D3
		
LOC_1123E:		              ; ...
		MOVE.W  D2,OBJ.Y(A0)
		MOVE.W  D3,OBJ.X(A0)
		BTST    #4,(JOYPADPRESS).W
		BEQ.S   LOC_11264
		MOVE.B  OBJ.RENDERFLAGS(A0),D0
		MOVE.B  D0,D1
		ADDQ.B  #1,D0
		ANDI.B  #3,D0
		ANDI.B  #$FC,D1
		OR.B    D1,D0
		MOVE.B  D0,OBJ.RENDERFLAGS(A0)

LOC_11264:		              ; ...
		BTST    #5,(JOYPADPRESS).W
		BEQ.S   LOC_1127E
		ADDQ.B  #1,OBJ.ANIM(A0)
		CMPI.B  #$19,OBJ.ANIM(A0)
		BCS.S   LOC_1127E
		MOVE.B  #0,OBJ.ANIM(A0)
		
LOC_1127E:
		JSR		_SONICANIMATE
		JSR		_OBJECTDISPLAY
		RTS

		
PLAY02_DELETE:
		RTS
		
PLAYER_DYNART:
        MOVEQ   #0,D0
        MOVE.B  OBJ.FRAME(A0),D0
        CMP.B   (SONICFRAME).W,D0
        BEQ.S   @EXIT
        MOVE.B  D0,(SONICFRAME).W
        LEA     (DMAP_PLAYER).L,A2
        ADD.W   D0,D0
        ADDA.W  (A2,D0.W),A2
        MOVEQ   #0,D1
        MOVE.B  (A2)+,D1
        SUBQ.B  #1,D1
        BMI.S   @EXIT
        LEA     (SONICDMABUFFER).W,A3
        MOVE.B  #1,(VBLFLAG1).W

	@LOC_F71A:		               ; ...
        MOVEQ   #0,D2
        MOVE.B  (A2)+,D2
        MOVE.W  D2,D0
        LSR.B   #4,D0
        LSL.W   #8,D2
        MOVE.B  (A2)+,D2
        LSL.W   #5,D2
        LEA     (ART_PLAYER).L,A1
        ADDA.L  D2,A1

	@LOC_F730:		               ; ...
        MOVEM.L (A1)+,D2-D6/A4-A6
        MOVEM.L D2-D6/A4-A6,(A3)
        LEA     $20(A3),A3
        DBF     D0,@LOC_F730
        DBF     D1,@LOC_F71A

@EXIT:				 ; ...
        RTS	
		
_SONICANIMATE:
		LEA		ANIM_PLAYER,	A1
		MOVEQ   #0,D0
		MOVE.B  OBJ.ANIM(A0),D0
		CMP.B   OBJ.ANIMPREVIOUS(A0),D0
		BEQ.S   @DOANIM
		MOVE.B  D0,OBJ.ANIMPREVIOUS(A0)
		MOVE.B  #0,OBJ.ANIMFRAME(A0)
		MOVE.B  #0,OBJ.FRAMETIMER(A0)

@DOANIM:		               ; ...
		ADD.W   D0,D0
		ADDA.W  (A1,D0.W),A1
		MOVE.B  (A1),D0
		BMI.S   ANI_SPEEDCALCFLAG
		MOVE.B  OBJ.STATUS(A0),D1
		ANDI.B  #1,D1
		ANDI.B  #$FC,OBJ.RENDERFLAGS(A0)
		OR.B    D1,OBJ.RENDERFLAGS(A0)
		SUBQ.B  #1,OBJ.FRAMETIMER(A0)
		BPL.S   SONANI_DELAY
		MOVE.B  D0,OBJ.FRAMETIMER(A0)

SONIC_LOADFRAME:		            ; ...
		MOVEQ   #0,D1
		MOVE.B  OBJ.ANIMFRAME(A0),D1
		MOVE.B  1(A1,D1.W),D0
		BMI.S   SONANI_LOOPFLAG

SONANI_NEXT:				 ; ...
		MOVE.B  D0,OBJ.FRAME(A0)
		ADDQ.B  #1,OBJ.ANIMFRAME(A0)

SONANI_DELAY:				; ...
		RTS
; ---------------------------------------------------------------------------

SONANI_LOOPFLAG:		             ; ...
		ADDQ.B  #1,D0
		BNE.S   @LOOPBACKFLAG
		MOVE.B  #0,OBJ.ANIMFRAME(A0)
		MOVE.B  1(A1),D0
		BRA.S   SONANI_NEXT
; ---------------------------------------------------------------------------

@LOOPBACKFLAG:		         ; ...
		ADDQ.B  #1,D0
		BNE.S   @CHANGEANIMFLAG
		MOVE.B  2(A1,D1.W),D0
		SUB.B   D0,OBJ.ANIMFRAME(A0)
		SUB.B   D0,D1
		MOVE.B  1(A1,D1.W),D0
		BRA.S   SONANI_NEXT
; ---------------------------------------------------------------------------

@CHANGEANIMFLAG:		       ; ...
		ADDQ.B  #1,D0
		BNE.S   @EXIT
		MOVE.B  2(A1,D1.W),OBJ.ANIM(A0)

@EXIT:				 ; ...
		RTS
; ---------------------------------------------------------------------------

ANI_SPEEDCALCFLAG:		        ; ...
		SUBQ.B  #1,OBJ.FRAMETIMER(A0)
		BPL.S   SONANI_DELAY
		ADDQ.B  #1,D0
		BNE.W   ANI_CHKROLL
		MOVEQ   #0,D1
		MOVE.B  OBJ.ANGLE(A0),D0
		MOVE.B  OBJ.STATUS(A0),D2
		ANDI.B  #1,D2
		BNE.S   LOC_F53E
		NOT.B   D0

LOC_F53E:		               ; ...
		ADDI.B  #$10,D0
		BPL.S   LOC_F546
		MOVEQ   #3,D1

LOC_F546:		               ; ...
		ANDI.B  #$FC,OBJ.RENDERFLAGS(A0)
		EOR.B   D1,D2
		OR.B    D2,OBJ.RENDERFLAGS(A0)
		BTST    #5,OBJ.STATUS(A0)
		BNE.W   LOC_F5E4
		LSR.B   #4,D0
		ANDI.B  #6,D0
		MOVE.W  OBJ.INERTIA(A0),D2
		BPL.S   LOC_F56A
		NEG.W   D2

LOC_F56A:		               ; ...
		LEA     (SONICCHG_WALK2).L,A1
		CMPI.W  #$600,D2
		BCC.S   LOC_F582
		LEA     (SONICCHG_WALK).L,A1
		MOVE.B  D0,D1
		LSR.B   #1,D1
		ADD.B   D1,D0

LOC_F582:		               ; ...
		ADD.B   D0,D0
		MOVE.B  D0,D3
		NEG.W   D2
		ADDI.W  #$800,D2
		BPL.S   LOC_F590
		MOVEQ   #0,D2

LOC_F590:		               ; ...
		LSR.W   #8,D2
		MOVE.B  D2,OBJ.FRAMETIMER(A0)
		BSR.W   SONIC_LOADFRAME
		ADD.B   D3,OBJ.FRAME(A0)
		RTS
; ---------------------------------------------------------------------------

ANI_CHKROLL:		              ; ...
		ADDQ.B  #1,D0
		BNE.S   LOC_F5E4
		MOVE.W  OBJ.INERTIA(A0),D2
		BPL.S   LOC_F5AC
		NEG.W   D2

LOC_F5AC:		               ; ...
		LEA     (SONICCHG_SPIN2).L,A1
		CMPI.W  #$600,D2
		BCC.S   LOC_F5BE
		LEA     (SONICCHG_SPIN1).L,A1

LOC_F5BE:		               ; ...
		NEG.W   D2
		ADDI.W  #$400,D2
		BPL.S   LOC_F5C8
		MOVEQ   #0,D2

LOC_F5C8:		               ; ...
		LSR.W   #8,D2
		MOVE.B  D2,OBJ.FRAMETIMER(A0)
		MOVE.B  OBJ.STATUS(A0),D1
		ANDI.B  #1,D1
		ANDI.B  #$FC,OBJ.RENDERFLAGS(A0)
		OR.B    D1,OBJ.RENDERFLAGS(A0)
		BRA.W   SONIC_LOADFRAME
; ---------------------------------------------------------------------------

LOC_F5E4:		               ; ...
		MOVE.W  OBJ.INERTIA(A0),D2
		BMI.S   LOC_F5EC
		NEG.W   D2

LOC_F5EC:		               ; ...
		ADDI.W  #$800,D2
		BPL.S   LOC_F5F4
		MOVEQ   #0,D2

LOC_F5F4:		               ; ...
		LSR.W   #6,D2
		MOVE.B  D2,OBJ.FRAMETIMER(A0)
		LEA     (SONICCHG_PUSH).L,A1
		MOVE.B  OBJ.STATUS(A0),D1
		ANDI.B  #1,D1
		ANDI.B  #$FC,OBJ.RENDERFLAGS(A0)
		OR.B    D1,OBJ.RENDERFLAGS(A0)
		BRA.W   SONIC_LOADFRAME
; END OF FUNCTION _SONICANIMATE