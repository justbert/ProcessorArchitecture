; A3A_Array.asm

#include C:\68HCS12\registers.inc

; Author:       J. Bertrand
; Course:       CST8216 Processor Architecture Winter 2015
; S/N:          040-786-592
; Date:         March 18th, 2015

; Purpose      Move the values of one array to the end of another array so that
;              they mirror eachother. While doing that, add the the values of
;               the array together.
;

; Program Constants
STACK                   equ     $2000                   ; Set Stack

                        org     $1000
Source_Array            db      $13,$04,$4F,$74,$8B,$04
EndSource
Destination_Array       ds      EndSource-Source_Array
Result                  ds      2

                        org     $2000
                        lds     #STACK
                        ldx     #Source_Array
                        ldy     #Destination_Array+5
                        clr     Result                       ; Clear result to $0000
START                   ldab    1,x+
                        stab    1,y-
                        addd    Result                   ; Add result to D since
                        std     Result
                        clra
                        clrb
                        cpx     #EndSource               ; Check to see passed array memory
                        bne     START                    ; if not, got to START
                        end