RUNOBJECTS:                             ; ...
                LEA     (OBJSLOT00).W,A0
                MOVEQ   #$80-1,D7
                MOVEQ   #0,D0

@PROCESSOBJLOOP:                       ; ...
                MOVE.B  OBJ.ID(A0),D0
                BEQ.S   @EMPTYSLOT
                ADD.W   D0,D0
                ADD.W   D0,D0
                MOVEA.L OBJECTINDEX-4(PC,D0.W),A1 ; NO ZERO OFFSET - START AT 1
                JSR     (A1)
                MOVEQ   #0,D0

@EMPTYSLOT:                            ; ...
                LEA     OBJ.SIZE(A0),A0
                DBF     D7,@PROCESSOBJLOOP
                RTS
; ---------------------------------------------------------------------------

; END OF FUNCTION RUNOBJECTS

OBJECTINDEX:
		DC.L	PLAY01
		DC.L	PLAY01