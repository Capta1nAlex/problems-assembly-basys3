; routines for work with display
.org 0x1000 ; 1
.include "printlib.inc"

; Start of the program - after the reset
.org 0 ; 2
    jmp start

; Start of the program - main program
.org 0x100 ; 3  
start:   
    call init_disp
    ldi r16, 0x11 // enter number needed
    mov r18, r16
    lsr r16
    lsr r16
    lsr r16
    lsr r16
    lsl r18
    lsl r18
    lsl r18
    lsl r18
    lsr r18
    lsr r18
    lsr r18
    lsr r18
    ldi R19, 48
    ldi R20, 7

    cpi R16, 10           ; check if the digit is >= 10 (needs to be converted to A-F)
    brcs ascii_0         ; if the digit is < 10, add 48 ('0') to make it an ASCII character
    add R16, R20          ; if the digit is >= 10, add 55 ('A'-10) to make it A-F
    ascii_0:
    add R16, R19         ; add 48 ('0') to make it an ASCII character
    
    cpi R18, 10           ; check if the digit is >= 10 (needs to be converted to A-F)
    brcs ascii_1         ; if the digit is < 10, add 48 ('0') to make it an ASCII character
    add R18, R20          ; if the digit is >= 10, add 55 ('A'-10) to make it A-F
    ascii_1:
    add R18, R19         ; add 48 ('0') to make it an ASCII character
    
    
    ldi r17, 0
    call show_char
    mov r16, r18
    ldi r18, 1;
    ldi r17, 1;
    call show_char

end:
    