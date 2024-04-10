		INCLUDE		"SRC/SYSTEM/RAM.I"
		INCLUDE		"SRC/SYSTEM/MACRO.I"
		INCLUDE		"SRC/SYSTEM/HEADER.ASM"

INT:
ERROR:
		BRA.S		INT
		
		INCLUDE		"SRC/SYSTEM/SECURITY.ASM"
START:
		move.w	#$8000+%00000100,(VDPCTRL)	;	Set VDP modes, mainly to render the screen
		move.w	#$8100+%01000100,(VDPCTRL)	;	Set VDP modes, mainly to render the screen
		move.l	#CRAMWRITE,	(VDPCTRL)		;	Set VDP control mode to manually write a palette to CRAM
		move.w	#$0EEE,		VDPDATA			;	Palleting...
		bra.s	ERROR
		

		INCLUDE		"SRC/SYSTEM/HBLANK.ASM"
		INCLUDE		"SRC/SYSTEM/VBLANK.ASM"