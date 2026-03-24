;
; ex4-3_code.asm
;
; Created: 24/3/2569 19:54:20
; Author : LENOVO
;
.include "m328pdef.inc"
.device ATMEGA328p
.DEF TEMP = R16
.DEF VARS1 = R17
.DEF VARS2 = R18

.cseg
.org 0x0000
start:
    ldi TEMP, 0xFF
	out DDRB, TEMP

	ldi TEMP, 0xF0
	out DDRC, TEMP
	out DDRD, TEMP
main:
	in   VARS1, PINC
	in   VARS2, PIND
	andi VARS1, 0x0F
	andi VARS2, 0x0F

	sbrc VARS1, 3
	ori  VARS1, 0xF0
	
	sbrc VARS2, 3
	ori  VARS2, 0xF0

	muls VARS1, VARS2
	out  PORTB, R0
	rjmp main