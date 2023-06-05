Moving text
Implement a program that will display the inscription defined in memory on the device display. 
After starting the program, the inscription will appear on display and will leave at the end (i.e. the display will be empty again). This will be repeated.

The program should display any inscription defined in the program’s memory, terminated by a zero. The text is defined in the program memory as a constant behind the .db pseudo-instruction.
The text size is limited at 30 characters max.

To adjust the speed, use wait-loops called as subroutines. The processor is clocked at 16 MHz.

