; Validate_CC.asm
; Authors:              J. Bertrand, J. Santoyo, S. Turriff
; Student Numbers:      040-786-592, 040-683-089, 040-787-289
; Date:                 April 5th, 2015
;
; Purpose:              Adds two digits and divides them to determine if it is
;                       divisable by 10.
;
; Preconditions:        Calculated value of Add_Even is stored in Accumulator A
;                       Calculated value of Add_Odd is stored in Accumulator B
;
; Notes:
;
;
;
; Postcondition:        D contains the remainder. If 0, then it's a valid CC.
;                       X is destroyed

Validate_CC
                        aba             ; Add two values together
                        daa             ; Decimal adjustment
                        tab             ; Transer A to B
                        clra
                        ldx     #$10    ; Load X with 10
                        idiv            ; Divide D by X,
                        ldx     #$0000  ; Clearing the contents of X
                        rts