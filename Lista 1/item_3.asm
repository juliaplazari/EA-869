;
; item3.asm
;
; Created: 5/5/2019 5:55:49 PM
; Author : julin
;


; Replace with your application code
start:
    ;colocar o número que se quer verificar
		ldi r16, 1
loop:
	;usando r17 para contabilizar o loop
		inc r17
	;deslocar para esquerda
		lsl r16
	;colocar em outro reg
		ror r15
	;comparar r17 com 4 para saber se é o fim do loop
		cpi r17, 4
		breq continuacao
		rjmp loop
continuacao:
	;comparar r16 e r15
		cp r15,r16
		breq final
		brne not 

final:
	;colocar 1 no r20 se for um palíndromo
		ldi r20,1
		break
not:
	break

	

	
		

	
	
		
