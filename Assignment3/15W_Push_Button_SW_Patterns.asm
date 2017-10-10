; 15W_Push_Button_SW_Patterns.asm

#include C:\68HCS12\registers.inc

; Author:       J. Bertrand
; Course:       CST8216 Processor Architecture Winter Sessions
; S/N:          040-786-592
; Date:         March 18th, 2015

; Purpose       To read in the values of SW2, SW3, SW4 and SW5
;                and display their equivalent binary values on
;               the LEDs on Port B on Dragon 12+ Trainer
;
;               e.g. if SW2 is pressed, then the bit pattern for binary 2
;               (00000010) is displayed on the LEDs
;

STACK   equ     $2000

FLICKER_DELAY   equ     125     ; 1/8 of a second delay value

SW2     equ     %11110111       ; SW2 pressed = this pattern on PTH
SW3     equ     %11111011       ; SW3 pressed = this pattern on PTH
SW4     equ     %11111101       ; SW4 pressed = this pattern on PTH
SW5     equ     %11111110       ; SW5 pressed = this pattern on PTH

ALL_ON  equ     %11111111       ; b7 downto b0 all on
LED2    equ     %00000010       ; bit pattern for binary 2
LED3    equ     %00000101       ; bit pattern for binary 3
LED4    equ     %00001000       ; bit pattern for binary 4
LED5    equ     %00001001       ; bit pattern for binary 5

        org     $2000
        lds     #STACK
        jsr     Config_SWs_and_LEDs
START   ldab    #ALL_ON
        jsr     Display_Value   ; all LEDs turned ON
Get_SW  ldaa    PTH             ; get data from Switches
SW2_L   cmpa    #SW2            ; Is SW2 presssed? bit 3 = 0 ?
        bne     SW3_L           ; No, try next SW
        ldab    #LED2           ; Yes, so set up to display Switch #: 2 base 2
        jsr     Display_Value   ; send pattern to LEDs
        bra     Get_SW          ; get another SW value
SW3_L   cmpa    #SW3            ; Is SW2 presssed? bit 3 = 0 ?
        bne     SW4_L           ; No, try next SW
        ldab    #LED3           ; Yes, so set up to display Switch #: 2 base 2
        jsr     Display_Value
        bra     Get_SW          ; get another SW value
SW4_L   cmpa    #SW4            ; Is SW2 presssed? bit 3 = 0 ?
        bne     SW5_L           ; No, try next SW
        ldab    #LED4           ; Yes, so set up to display Switch #: 2 base 2
        jsr     Display_Value
        bra     Get_SW          ; get another SW value
SW5_L   cmpa    #SW5            ; Is SW2 presssed? bit 3 = 0 ?
        bne     RESTART           ; No, try next SW
        ldab    #LED5           ; Yes, so set up to display Switch #: 2 base 2
        jsr     Display_Value
        bra     Get_SW          ; get another SW value
RESTART jsr     START

Display_Value
        stab    PORTB           ; value to LEDs
        ldaa    #FLICKER_DELAY  ; Delay 1/8 th of a second
        jsr     Delay_ms        ; to avoid flicker
        rts

#include C:\68HCS12\Lib\Config_SWs_and_LEDs.asm
#include C:\68HCS12\Lib\Delay_ms.asm

        end