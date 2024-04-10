		INCLUDE		"SRC/SYSTEM/RAM.I"
		INCLUDE		"SRC/SYSTEM/MACRO.I"
		INCLUDE		"SRC/SYSTEM/HEADER.ASM"

INT:
ERROR:
		BRA.S		INT
		
ENTRYPOINT:
		move.l	#CRAMWRITE,	(VDPCTRL)		;	Set VDP control mode to manually write a palette to CRAM
		move.w	#$000E,		VDPDATA			;	Palleting...
		bra.s	ERROR
		

HBLANK:	;	i'll add these later
		rts
VBLANK:	;	presumably tomorrow, they're kinda essential
		rts