;
; Projeto_final.asm
;
; Created: 6/15/2019 2:07:06 PM
; Author :  J�lia L�zari RA: 200298
;			B�rbara Dill RA: 213394


;in�cio do c�gido
.cseg
	;em 0x00, temos o vetor de interrup��o para o reset
	.org 0x0000
	rjmp reset
	/*em 0x0002, temos o desvio para a rotina 
	de servi�o associada a INT0 (externa)*/
	.org 0x0002
	rjmp INT0_vetor
	/*o vetor de interrup��o termina em 0x0034, 
	a partir de onde podemos come�ar o programa*/
	.org 0x0034	

reset:
	; configurar interrup��o externa INT0
 
	;setar os dois bits menos significativos - a INT0 ser� ativada na borda de subida do pino 2 da porta D
	/* A vari�vel pr�-definida EICRA est� relacionada a um endere�o de I/O mapeada em mem�ria
	   Por isso, devemos usar as instru��es lds/sts (load/store) para lidar com este endere�o */
	
	/*carregar 0x03 no EICRA para que a 
	interrup��o aconte�a na borda de subida*/
	lds r16,EICRA 
	ori r16,0x03
	sts EICRA,r16

	;habilitar a interrup��o INT0
	/* 	   A vari�vel pr�-definida EIMSK est� relacionada a um endere�o de I/O (isolada)
	   Por isso, devemos usar as instru��es in/out para lidar com este endere�o	*/

	/*;carregar 0x01 no EIMSK para 
	que a INT0 seja habilitada*/
	in r16,EIMSK 
	ori r16,0x01
	out EIMSK,r16

	;inicializa o contador relacionado ao bot�o
	clr r17

	;setar bit 5 do DDRB - definir como sa�da
	sbi 0x04, 5
	
	;zerar bit 2 do DDRD - definir como entrada
	cbi 0x0b, 2

	;habilitar todas as interrup��es
	sei	

;c�digo principal
main:
	
	/*configurar o atraso (carregar o par�metro em r21)
	 de acordo com o valor no contador*/
		cpi r17, 0
			breq primeiro
		cpi r17, 1
			breq segundo
		cpi r17, 2
			breq terceiro
	;caso o contador esteja no 0 o atraso ser� de 1s (par�metro igual a 100)
		primeiro:
			ldi r21, 100 ;carrega par�metro em r21
			call led ;chama a rotina que pisca o led
			rjmp main ;retorna ao main
	;caso o contador esteja no 1 o atraso ser� de 0,5s (par�metro igual a 50)
		segundo:
			ldi r21, 50 ;carrega par�metro em r21
			call led ;chama a rotina respons�vel por piscar o led
			rjmp main ;retorna ao main
	;caso o contador esteja no 2 o atraso ser� de 0,25s (par�metro igual a 25)
		terceiro:
			ldi r21, 25 ;carrega par�metro em r21
			call led ;chama a rotina respons�vel por piscar o led
			rjmp main ;retorna ao main				
	;configurar led para que ele pisque com um intervalo de acordo com o estado atual
		led: 
			sbi 0x05, 5 ;seta bit 5 do PORTB - acende led
			call atraso ;chama rotina de atraso
			cbi 0x05, 5 ;zera bit 5 do PORTB - apaga led
			call atraso ;chama a rotina de atraso
			ret
INT0_vetor:
	;rotina de servi�o da interrup��o externa (bot�o)

	;salva o regist. de estado
	/* 	   A vari�vel pr�-definida SREG est� relacionada a um endere�o de I/O (isolada)
	   Por isso, devemos usar as instru��es in/out para lidar com este endere�o	*/
	in r13,SREG
	;altera o contador
	cpi r17, 2 ;compara se o contador � igual a 2 (m�ximo valor que ele assume)
		brne incrementar ;caso n�o, incrementa o contador
		clr r17 ;caso sim, zera o contador
		rjmp terminar
	incrementar:
		inc r17 ;incrementa contador
	terminar:
		out SREG,r13; restaura o regist. de estado
		reti

/*rotina de atraso*/
atraso:
		cp r19, r21 ;compara o r19 com o r21 (par�metro)
			breq fim ; quando forem iguais o programa � encerrado
		clr r20 ;clear no r20 para que o rotina2 sempre comece com esse registrador no 0
		inc r19 ;incrementar o r19
		call rotina1 ;vai para o segundo rotina
		call atraso ;repete primeira rotina (qtd de repeti��es de acordo com o valor em r16)
		
		fim:
		/*apagar o conte�do dos regs para que a rotina possa ser executada novamente */
			clr r18 
			clr r19
			clr r20
			ret ;retorna ao programa principal (main)s

	rotina1:
		cpi r20, 57 ;compara r20 com 57 (n�mero de vezes que essa rotina deve ser executado)
			breq volta ;quando for igual volta para o primeira rotina
		inc r20 ;incrementa o r20
		clr r18 ;clear no r18 para que a rotina3 sempre comece com esse registrador no 0
		call rotina2 ;chama a rotina3
		call rotina1 ;repete a segunda rotina, este ser� repetido 57 vezes para cada 1 vez da primeira

		volta:
			ret ;retorna � primeira rotina quando a segunda tiver sido executado 57 vezes

	rotina2:
		cpi r18, 255 ;compara r18 com 255 (n�mero de vezes que a rotina deve ser executado)
			breq retorno ;quando for igual retornar� para o c�digo
		inc r18 ;incrementar o r18
		call rotina2 ;chamar a rotina novamente
	
		retorno:
			ret ; retorna � segunda rotina

