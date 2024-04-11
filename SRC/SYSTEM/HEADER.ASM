		DC.L	$00FFFE00
		DC.L	SECURITY
		DC.L 	BusError		; Bus error
		DC.L 	AddressError	; Address error (4)
		DC.L 	IllegalInstr	; Illegal instruction
		DC.L 	ZeroDivide		; Division by zero
		DC.L 	ChkInstr		; CHK exception
		DC.L 	TrapvInstr		; TRAPV exception (8)
		DC.L 	PrivilegeViol	; Privilege violation
		DC.L 	Trace			; TRACE exception
		DC.L 	Line1010Emu	; Line-A emulator
		DC.L 	Line1111Emu	; Line-F emulator (12)
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	INT
		DC.L	INT
		DC.L	INT
		DC.L	HBLANK
		DC.L	INT
		DC.L	VBLANK
		DC.L	INT
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.L	ERROR
		DC.B	'SEGA MEGA DRIVE '		;	SYSTEM
		DC.B	'(C)SEGA 1989.JAN'		;	DATE
		DC.B	'                '		;	DOMESTIC TITLE
		DC.B	'                '
		DC.B	'                '
		DC.B	'                '		;	INTERNATIONAL TITLE
		DC.B	'                '
		DC.B	'                '
		DC.B	'GM 00000000-00',0,0	;	SERIAL
		DC.B	'J               '		;	I/O SUPPORT JOYPAD
		DC.L	$00000000				;	ROM START
		DC.L	$0007FFFF				;	ROM END
		DC.L	$00FF0000				;	RAM START
		DC.L	$00FFFFFF				;	RAM END
		DC.B	'                '
		DC.B	'                '
		DC.B	'                '
		DC.B	'                '
		DC.B	'JU              '		;	REGION