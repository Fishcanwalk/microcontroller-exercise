;
; ex4-14.asm
;
; Created: 25/3/2569 22:18:18
; Author : LENOVO
;
.include "m328pdef.inc"
.device atmega328p

.def temp=r16
.def quotient=r17
.def sw1=r18
.def sw2=r19

; Replace with your application code
start:
	ldi temp, 0x00
	out ddrb, temp

	ldi temp, 0xf0
	out ddrc, temp

	ldi temp, 0xff
	out ddrd, temp
main:
	in sw1, pinc
	in sw2, pinb

	andi sw1, 0x0f ; use pc0-3
	breq divide_by_zero
	clr  quotient
divide_loop:
	sub  sw2, sw1
	brcs end_divide_loop
	inc  quotient
	rjmp divide_loop
end_divide_loop:
	out portd, quotient
	rjmp main
divide_by_zero:
	ldi quotient, 0xff
	out portd, quotient
	rjmp main