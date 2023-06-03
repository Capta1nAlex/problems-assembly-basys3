Write a program that displays the entered eight-bit number in hexadecimal on the display
The number to be displayed will be "hard-coded" in the code. E.g.

ldi r16, 0x5A
Output is made with custom library
Use shift and mask instructions to get one hex digit (or two hex digits).
Use comparison and addition to make the digit an ASCII character (code 'A' is 65, code '0' is 48).
The trainee can enter any number from the range 0x00-0xff and the program must (after translation) display it correctly.
