; Add_Odd.asm
; Authors:              J. Bertrand, J. Santoyo, S. Turriff
; Student Numbers:      040-786-592, 040-683-089, 040-787-289
; Date:                 April 5th, 2015
;
; Purpose:              Subroutine to add two digits together
;
; Preconditions:        First digit is stored in Accumulator A
;                       Second digit is stored in Accumulator B
;
; Notes:
;
;
;
; Postcondition:        A is destroyed
;                       B contains calculated value

Add_Odd
                        aba             ; Adds the content of B to A
                        daa
                        tab             ; Transfer contents
                        clra            ; Remove uneeded value in A
                        rts