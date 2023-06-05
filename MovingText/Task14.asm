.org 0x1000 ; 1
.include "printlib.inc"
    
.cseg ; 
; Start of the program - after the reset
.org 0 
    jmp start

; Start of the program - main program
.org 0x100
length: .db 6 ; definition of read-only constant in the code memory (one byte with value 6) 1
string: .db "LONDON BRIDGE IS FALLING DOWN",0 ; string terminated by zero (not by character '0') 1

overflow2:
    ldi r18, 0x40
    jmp step_initialize2
   
start:
    ldi r27, 0x30
    ldi r30, low(2*string) 
    ldi r31, high(2*string) 
    call init_disp 
    
first_iteration:; finding out how many characters in text we have       
    lpm r16, Z+
    inc r29
    tst r16; Check if r16 is zero (end of string)
    brne first_iteration;
    
overflow:
    ldi r18, 0
    jmp step_initialize2
    
wait_loop: 
    push r10    
    in r10, SREG    ; 2
    push r10        ; store status register 2
    push r28
    ldi r22, 64
    ldi r21, 255
wait3: ldi r21, 255
wait2: ldi r20, 255
wait:  Dec r20
    brne wait
    Dec r21
    brne wait2
    Dec r22
    brne wait3
    pop r28
    pop r28
    out SREG, r28   
    pop r28
    ret

step_initialize2:
    ldi r30, low(2*string) 
    ldi r31, high(2*string)   
    ldi r16, ' '
    mov r17, r18
    dec r17
    call show_char
    ldi r17, 0x4F
    
    cpi r18, 0x50
    BRSH overflow
    cpi r18, 0x51
    BRSH overflow
    cpi r18, 0x10
    breq overflow2
    cpi r18, 0x11
   
    
    call show_char
    mov r17, r18
    lpm r16, Z+
    
loop:
    call show_char ; display a character in register R16 to position from register R17
    
    inc r17 ; increment position
    cpi r17, 0x10 ; check if r17 is 16 (0x10)
    brne next_step ; if not equal, go to next_position
    
    ldi r17, 0x40 ; set r17 to 64 (0x40)
    
    
next_step:
    lpm r16, Z+
    
next_position:
    tst r16; Check if r16 is zero (end of string)
    brne loop ; If not equal, continue the loop
    inc r18
    cpi r17, 0x10
    brne thecall
    ldi r17, 0x40
    call wait_loop

thecall:
    call wait_loop
    jmp step_initialize2
    