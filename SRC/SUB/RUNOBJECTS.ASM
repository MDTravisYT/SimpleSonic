RUNOBJECTS:                             ; ...
                LEA     (OBJECTSONIC).W,A0
                MOVEQ   #$80-1,D7
                MOVEQ   #0,D0
                CMPI.B  #6,(OBJECTSONIC+OBJ.ACTION).W ; SONIC ROUTINE COUNTER
                BCC.S   @PAUSED

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

@PAUSED:                               ; ...
                MOVEQ   #32-1,D7
                BSR.S   @PROCESSOBJLOOP
                MOVEQ   #96-1,D7

@PAUSEOBJLOOP:                         ; ...
                MOVEQ   #0,D0
                MOVE.B  OBJ.ID(A0),D0
                BEQ.S   @SKIPDISPLAY
                TST.B   OBJ.RENDERFLAGS(A0)
                BPL.S   @SKIPDISPLAY
                BSR.W   _OBJECTDISPLAY  ; ONLY DISPLAY SPRITES WHILE PAUSED

@SKIPDISPLAY:                          ; ...
                LEA     OBJ.SIZE(A0),A0
                DBF     D7,@PAUSEOBJLOOP
                RTS
; END OF FUNCTION RUNOBJECTS

OBJECTINDEX:
		DC.L	PLAY02
		DC.L	PLAY02