MapSpr_TestObjects1:dc.w __small1-*     ; ...
                dc.w __small2-MapSpr_TestObjects1
                dc.w __large1-MapSpr_TestObjects1
                dc.w __large2-MapSpr_TestObjects1
__small1:       dc.b   1,$F0, $F,$80,  0,$F0 ; ...
__small2:       dc.b   1,$F0, $F,$80,$10,$F0 ; ...
__large1:       dc.b   8,$80, $F,$80,$10,$F0,$60, $F ; ...
                dc.b $80,$10,$F0,$40, $F,$80,$10,$F0
                dc.b $20, $F,$80,$10,$F0,  0, $F,$80
                dc.b $10,$F0,$E0, $F,$80,$10,$F0,$C0
                dc.b  $F,$80,$10,$F0,$A0, $F,$80,$10
                dc.b $F0,  0
__large2:       dc.b   8,$80, $F,$80,  0,$F0,$60, $F ; ...
                dc.b $80,  0,$F0,$40, $F,$80,  0,$F0
                dc.b $20, $F,$80,  0,$F0,  0, $F,$80
                dc.b   0,$F0,$E0, $F,$80,  0,$F0,$C0
                dc.b  $F,$80,  0,$F0,$A0, $F,$80,  0
                dc.b $F0,  0