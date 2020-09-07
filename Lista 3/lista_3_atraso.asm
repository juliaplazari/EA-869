;
; lista3.asm
;
; Created: 5/22/2019 2:35:51 PM
; Author : julia e barbara
;

;carregar parâmetro em r16, sendo 10 o parâmetro para 0,1; 20 para 0,2 e assim por diante
	ldi r16, 50

;primeiro loop
loop1:
	cp r19, r16 ;compara o r19 com o r16 (parâmetro)
		breq fim ; quando forem iguais o programa é encerrado
	clr r20 ;clear no r20 para que o loop2 sempre comece com esse registrador no 0
	inc r19 ;incrementar o r19
	rjmp loop2 ;vai para o segundo loop
	rjmp loop1 ;repete primeiro loop, a quantidade de vezes que ele se repete depende do parâmetro carregado em r16

loop2:
	cpi r20, 57 ;compara r20 com 57 (número de vezes que esse loop deve ser executado)
		breq volta ;quando for igual volta para o primeiro loop
	inc r20 ;incrementa o r20
	clr r18 ;clear no r18 para que a rotina sempre comece com esse registrador no 0
	call rotina ;chama a rotina
	rjmp loop2 ;repete o segundo loop, este será repetido 57 vezes para cada 1 vez do primeiro loop

volta:
	rjmp loop1 ;retorna ao primeiro loop quando o segundo tiver sido executado 57 vezes

rotina:
	cpi r18, 255 ;compara r18 com 255 (número de vezes que a rotina deve ser executado)
		breq retorno ;quando for igual retornará para o código
	inc r18 ;incrementar o r18
	call rotina ;chamar a rotina novamente
	
	retorno:
		ret ;retorno ao fim do código

fim:
	break ;finaliza o programa
