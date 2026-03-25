;
; ex4-15.asm
;
; Created: 25/3/2569 22:59:43
; Author : LENOVO
;
.include "m328pdef.inc"
.device atmega328p

.def temp=r16
.def v1=r17
.def v2=r18
.def v3=r19

; Replace with your application code
start:
	ldi temp, 0xff
	out ddrb, temp

	ldi temp, 0xf0
	out ddrc, temp

	ldi temp, 0b01110000
	out ddrd, temp

main:
	in v1, pind
	in v2, pinc
	mov v3, v1

	andi v1, 0x0f
	andi v2, 0x0f
	; extend bit logic
	sbrc v1, 3
	ori  v1, 0xF0
	sbrc v2, 3
	ori  v2, 0xF0

	andi v3, 0b10000000
	breq low_mode ; if Zero flag set its low
high_mode:
	add  v1, v2
	rjmp display
low_mode:
	sub  v1, v2
display:
	out portb, v1
	rjmp main