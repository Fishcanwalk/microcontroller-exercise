;
; ex4-8.asm
;
; Created: 24/3/2569 21:31:04
; Author : LENOVO
;
.include "m328pdef.inc"
.device ATMEGA328p
.def TEMP=R16
.def VARS1=R17
.def VARS2=R18
.cseg
.org 0x0000
	rjmp start

BIN_TO_GRAY_TABLE:	
		.DB 0b0000, 0b0001
		.DB 0b0011, 0b0010
		.DB 0b0110, 0b0111
		.DB 0b0101, 0b0100
		.DB 0b1100, 0b1101
		.DB 0b1111, 0b1110
		.DB 0b1010, 0b1011
		.DB 0b1001, 0b1000

GRAY_TO_BIN_TABLE:
		.DB 0b0000, 0b0001
		.DB 0b0011, 0b0010
		.DB 0b0111, 0b0110
		.DB 0b0100, 0b0101
		.DB 0b1111, 0b1110
		.DB 0b1100, 0b1101
		.DB 0b1000, 0b1001
		.DB 0b1011, 0b1010

start:
	ldi	TEMP, 0xFF
	out DDRD, TEMP
	ldi TEMP, 0x00
	out DDRB, TEMP
	ldi TEMP, 0b11111110
	out DDRC, TEMP
main:
	in VARS1, PINB
	in VARS2, PINC
	
	andi VARS1, 0x0F	; use 4 bit

	andi VARS2, 0x01
	cpi  VARS2, 0x01
	brne convert_gray_to_binary	; high: binary->gray, low: gray->binary
convert_bin_to_gray:
	ldi ZL, low(BIN_TO_GRAY_TABLE*2)
	ldi ZH, high(BIN_TO_GRAY_TABLE*2)
	rjmp lookup
convert_gray_to_binary:
	ldi ZL, low(GRAY_TO_BIN_TABLE*2)
	ldi ZH, high(GRAY_TO_BIN_TABLE*2)
lookup:
	add ZL, VARS1
	ldi TEMP, 0
	adc ZH, TEMP
	lpm VARS1, Z
display_led:
	out PORTD, VARS1
	rjmp main