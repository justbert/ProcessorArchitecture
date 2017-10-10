; CC_Validation.asm
;
#include C:\68HCS12\registers.inc
;
;
; Authors:              J. Bertrand, J. Santoyo, S. Turriff
; Student Numbers:      040-786-592, 040-683-089, 040-787-289
;
; Purpose:              Credit Card Number Validation

; -- Complete the following equ statements using BINARY values
; Hardware Configuration
DIGIT2_PP1      equ     %1110                     ; HEX Display MSB (left most digit)
DIGIT1_PP2      equ     %0111                     ; Display LSB (left most digit)
;

; DO NOT CHANGE THE DELAY_VALUE; OTHERWISE THE VALUES WILL INCORRECTLY BE DISPLAYED
; IN THE SIMULATOR
DELAY_VALUE     equ     64                      ; HEX Display Multiplexing Delay
CORRECT_CC      equ     00
; CARD numbers to validate are stored commencing at $1000

                org     $1000
StartOFNumbers
#include        15W_WED_CC_Numbers.txt                  ; substitute the appropriate file name here.
EndOFNumbers

; --  Do not change the code below here --
;     Place your results here as you loop through your solution
                org     $1030
InvalidResult   ds      1                       ; Count of Invalid CARDs processed
ValidResult     ds      1                       ; Count of Valid CARDs processed
; -- end of Do not change the code below here

                org     $2000
; Using iteration, loop through ALL of the Credit Card numbers to validate them,
; updating InvalidResult and ValidResult each loop. Once all six cards have been
; validated, then you are finished the loop and you can start executing the
; code at label Finished.
;
; -- Your code goes below here
                lds     #$2000                  ; Load Stack
                clr     InvalidResult           ; Clear memory location of InvalidRseult
                clr     ValidResult             ; Clear memory location of ValidResult
                clra                            ; Clear A
                clrb                            ; Clear B
                ldx     #$0000                  ; Clear X
                ldy     #StartOfNumbers         ; Load the beginning address of the CCs
ProcessCC       ldaa    0,y                     ; Load A with digit 0
                ldab    2,y                     ; Load B with digit 2
                jsr     Add_Even                ;
                pshb                            ; Push value of Add_Even to Stack for use in Valdation
                ldaa    1,y                     ; Load A with digit 1
                ldab    3,+y                    ; Load B with digit 2
                iny                             ; Increment Y to set to the next correct first value
                jsr     Add_Odd
                pula                            ; Pull value of Add_Even from the Stack
                jsr     Validate_CC             ; Jump to Validate_CC
                cmpb    CORRECT_CC              ; Compare the returned value of Validate_C to a correct
                beq     IncrementValid          ; If true, branch and, increment ValidResult
                inc     InvalidResult           ; ELSE increment InvalidResult
                bra     EndIncrements           ;
IncrementValid  inc     ValidResult             ;
                bra     EndIncrements
EndIncrements   cpy     #EndOfNumbers           ; Compare current address of Y to end of CARDS
                blo     ProcessCC               ; If CARD numbers still remaining, process card.

; --  Do not change the code below here --
Finished        jsr     Config_HEX_Displays
Display         ldaa    ValidResult
                ldab    #DIGIT2_PP1             ; select MSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; delay for DELAY_VALUE milliseconds
                ldaa    InValidResult
                ldab    #DIGIT1_PP2             ; select LSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; delay for DELAY_VALUE milliseconds
                bra     Display                 ; endless loop


; Filenames without a "C:\68HCS12\Lib\" path MUST be placed in the SOURCE FOLDER
#include Add_Odd.asm                            ; you write this one
#include Add_Even.asm                           ; you write this one
#include Validate_CC.asm                        ; you write this one
#include Config_HEX_Displays.asm                ; provided to you - no changes permitted
#include Hex_Display.asm                        ; provided to you - no changes permitted
#include C:\68HCS12\Lib\Delay_ms.asm            ; Library File    - no changes permitted

                end

************************* No Code Past Here ****************************