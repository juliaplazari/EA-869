;
; Fibonacci.asm
;
; Created: 5/13/2019 1:08:46 PM
; Author : julia e barbara
;


start:
    ;colocar o valor de n no r16
		ldi r16, 8
	;resultado será armazenado em r17
	;índice será armazenado em r23
	; registrador aux r21 começa em 0
	; registrador aux r22 começa em 1
		ldi r22, 1
	;caso n=0
		cp r16,r23
		breq fim
	;indice 1
		inc r23
		ldi r17, 1
	;chamar subrotina
		call fib
	;encerrar código
		rjmp fim

fib:
	;compara índice e n
		cp r23, r16
		;sair da subrotina se for igual
			breq retorno
	;adiciona r21 e r17
		add r17, r21
	;armazenar valores dos registradores na pilha
		push r17
		push r22
	;colocar o valor de r22 em r21
		pop r21
	;colocar o valor de r17 em r22
		pop r22
	;incrementa r23
		inc r23
	;chamar a subrotina novamente
		call fib

	retorno:
		;retornar
		ret

fim:
	break

