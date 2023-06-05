.org 0x1000 ; 1
.include "printlib.inc"
    
.cseg ; 
; Start of the program - after the reset
.org 0
    jmp initialization

; Start of the program - main program
.org 0x100
length: .db 6 ; definition of read-only constant in the code memory (one byte with value 6) 1
string: .db " Eggs are done    so you are",0 ; string terminated by zero (not by character '0') 1 
 
wait_loop: 
    push r10    
    in r10, SREG    ; 2
    push r10        ; store status register 2
    push r28
    ldi r27, 90
    ldi r26, 255
wait3: ldi r26, 255
wait2: ldi r25, 255
wait:  Dec r25
    brne wait
    Dec r26
    brne wait2
    Dec r27
    brne wait3
    pop r28
    pop r28
    out SREG, r28   
    pop r28
    ret
    
initialization:
    call init_disp
    ldi r16, 0x3A
    ldi r17, 2
    call show_char
    ldi r20, 15; seconds
    ldi r21, 1; minutes
    ldi r31, 10 ; in order to split number
    ldi r30, 48 ; for output
    mov r16, r21
    call output_minutes
    jmp start
 
start:
    mov r16, r20
    ldi r18, 0
    call output_seconds
    call wait_loop
    tst r20
    breq zero_seconds
    dec r20
    jmp start

zero_seconds:
    push r10    
    in r10, SREG    ; 2
    push r10        ; store status register 2
    push r28
    tst r21
    breq end_init
    dec r21
    mov r16, r21
    ldi r19, 0
    call output_minutes
    ldi r20, 59
    pop r28
    pop r28
    out SREG, r28   
    pop r28
    jmp start
    
output_seconds: 
    sub r16, r31
    brmi decimal_convert
    inc r18
    jmp output_seconds
    
output_minutes:
    sub r16, r31
    brmi decimal_convert_minutes
    inc r19
    
decimal_convert: 
    push r10    
    in r10, SREG    ; 2
    push r10        ; store status register 2
    push r28
    add r16, r31
    add r16, r30
    ldi r17, 4
    call show_char
    mov r16, r18
    add r16, r30
    ldi r17, 3
    call show_char
    pop r28
    pop r28
    out SREG, r28   
    pop r28
    ret
    
decimal_convert_minutes:
    push r10    
    in r10, SREG    ; 2
    push r10        ; store status register 2
    push r28
    add r16, r31
    add r16, r30
    ldi r17, 1
    call show_char
    mov r16, r19
    add r16, r30
    ldi r17, 0
    call show_char
    pop r28
    pop r28
    out SREG, r28   
    pop r28
    ret
            
end_init:
    ldi r30, low(2*string) 
    ldi r31, high(2*string)  
end_init2:
    lpm r16, Z+
    tst r16; Check if r16 is zero (end of string)
    breq end_init3
    jmp end_init2
end_init3:
    call wait_loop
    ldi r30, low(2*string) 
    ldi r31, high(2*string)  
    mov r17, r23

finale_output:
    lpm r16, Z+
    
loop:
    tst r16; Check if r16 is zero (end of string)
    breq end; 
    call show_char ; display a character in register R16 to position from register R17
    inc r17
    cpi r17, 0x10
    brne finale_output ; if not equal, go to next_position
    ldi r17, 0x40 ; set r17 to 64 (0x40)
    jmp finale_output
end:
    ldi r17, 0x50
    call wait_loop
    jmp clear;
    
    
    
clear:
    call show_char
    dec r17
    tst r17
    breq end_init3
    jmp clear