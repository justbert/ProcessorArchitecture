; Add_Even.asm
; Authors:              J. Bertrand, J. Santoyo, S. Turriff
; Student Numbers:      040-786-592, 040-683-089, 040-787-289
; Date:                 April 5th, 2015
;
; Purpose:              Subroutine which validates 2 digits of a 4 digit
;                       Credit Card number by multiplying the digits by themselves,
;                       crossadding the product if it is larger than 9,
;                       then adding the these two products together.
;
; Preconditions:        First digit is stored in Accumulator A
;                       Second digit is stored in Accumulator B
;
; Notes:
;
;
;
; Postcondition:        X is destroyed
;                       A is destroyed
;                       B contains calculated value
Add_Even
                        pshb                    ; Push digit two to stack for later use
                        jsr     MultiplyDigit
                        pula                    ; Pull digit two from stack
                        pshb                    ; Push digit one after validation operations to stack
                        jsr     MultiplyDigit
                        pula                    ; Pull digit one after validation from stack
                        aba                     ; Add the two inputed digits together
                        daa                     ; Decimal adjust the sum
                        tab                     ; Transfer to the B register                                          R
                        clra                    ; Clear A
                        rts

; Purpose:              Subroutine which multiplies a digit by 2, then
;                       cross-adds the product if it is over 9.
;
; Preconditions:        Digit is stored in Accumulator A
;
; Notes:
;
;
;
; Postcondition:        A is destroyed
;                       B contains calculated value

MultiplyDigit           tab                     ; Transfer A to B, to allow multiplication by two
                        aba                     ; Add value of B to A
                        daa                     ; Decimal adjust
                        tab                     ; Transfer correct value into B
                        clra                    ; Value in A not needed
                        cmpb    #$10            ;
                        blo     SkipCrossAdd
                        jsr     CrossAdd
SkipCrossAdd            rts

; Purpose:              Subroutine which crossadds the a decimal number.
;
; Preconditions:        Number is stored in Accumulator B
;
; Notes:
;
;
;
; Postcondition:        X is destroyed
;			A is destroyed
;                       B contains calculated value
;
CrossAdd                ldx     #$10             ;
                        idiv                     ; Divide by 10 to split the MSB from the LSB                     ;
                        abx                      ; Add the remainder in B to X
                        pshx                     ; Push X to stack
                        puld                     ; Cross-Added value stored in B
                        rts