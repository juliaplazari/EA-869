;
; item1.asm
;
; Created: 5/5/2019 11:59:06 AM
; Author : julin
;


; Replace with your application code
start:
    ;carregar n no r16
		ldi r16, 7
	;r17 (resultado da soma) e r18 (compara��o) iniciam com 0

loop:
	;somar um ao r18
		inc r18
	;somar conte�do de r17 e r18
		add r17,r18
	;comparar r16 e r18
		cp r16,r18
	;se igual sair do loop
		breq acabou
	;se n�o for continua normalmente
		rjmp loop

acabou:
	break
