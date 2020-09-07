;
; item4.asm
;
; Created: 5/5/2019 6:23:09 PM
; Author : julin
;


; Replace with your application code
start:
	.org 0x04
	.cseg
	consts: .db 7,2

	;carregar valor no z
		ldi zh, 0
		ldi zl, 8

	;carregar o valor a no r16
		lpm r16,Z+
	;carregar o valor b no r15
		lpm r17,Z+

loop:
	;comparar r16 com o valor de b para saber se sai do loop
		cp r16,r17
		brlt fim
	;subtrair b de a
		sbc r16,r17
	;adicionar 1 ao r18 
		inc r18
	;voltar ao loop
		rjmp loop


fim:
	break
