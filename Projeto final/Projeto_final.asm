;
; Projeto_final.asm
;
; Created: 6/15/2019 2:07:06 PM
; Author :  Júlia Lázari RA: 200298
;			Bárbara Dill RA: 213394


;início do cógido
.cseg
	;em 0x00, temos o vetor de interrupção para o reset
	.org 0x0000
	rjmp reset
	/*em 0x0002, temos o desvio para a rotina 
	de serviço associada a INT0 (externa)*/
	.org 0x0002
	rjmp INT0_vetor
	/*o vetor de interrupção termina em 0x0034, 
	a partir de onde podemos começar o programa*/
	.org 0x0034	

reset:
	; configurar interrupção externa INT0
 
	;setar os dois bits menos significativos - a INT0 será ativada na borda de subida do pino 2 da porta D
	/* A variável pré-definida EICRA está relacionada a um endereço de I/O mapeada em memória
	   Por isso, devemos usar as instruções lds/sts (load/store) para lidar com este endereço */
	
	/*carregar 0x03 no EICRA para que a 
	interrupção aconteça na borda de subida*/
	lds r16,EICRA 
	ori r16,0x03
	sts EICRA,r16

	;habilitar a interrupção INT0
	/* 	   A variável pré-definida EIMSK está relacionada a um endereço de I/O (isolada)
	   Por isso, devemos usar as instruções in/out para lidar com este endereço	*/

	/*;carregar 0x01 no EIMSK para 
	que a INT0 seja habilitada*/
	in r16,EIMSK 
	ori r16,0x01
	out EIMSK,r16

	;inicializa o contador relacionado ao botão
	clr r17

	;setar bit 5 do DDRB - definir como saída
	sbi 0x04, 5
	
	;zerar bit 2 do DDRD - definir como entrada
	cbi 0x0b, 2

	;habilitar todas as interrupções
	sei	

;código principal
main:
	
	/*configurar o atraso (carregar o parâmetro em r21)
	 de acordo com o valor no contador*/
		cpi r17, 0
			breq primeiro
		cpi r17, 1
			breq segundo
		cpi r17, 2
			breq terceiro
	;caso o contador esteja no 0 o atraso será de 1s (parâmetro igual a 100)
		primeiro:
			ldi r21, 100 ;carrega parâmetro em r21
			call led ;chama a rotina que pisca o led
			rjmp main ;retorna ao main
	;caso o contador esteja no 1 o atraso será de 0,5s (parâmetro igual a 50)
		segundo:
			ldi r21, 50 ;carrega parâmetro em r21
			call led ;chama a rotina responsável por piscar o led
			rjmp main ;retorna ao main
	;caso o contador esteja no 2 o atraso será de 0,25s (parâmetro igual a 25)
		terceiro:
			ldi r21, 25 ;carrega parâmetro em r21
			call led ;chama a rotina responsável por piscar o led
			rjmp main ;retorna ao main				
	;configurar led para que ele pisque com um intervalo de acordo com o estado atual
		led: 
			sbi 0x05, 5 ;seta bit 5 do PORTB - acende led
			call atraso ;chama rotina de atraso
			cbi 0x05, 5 ;zera bit 5 do PORTB - apaga led
			call atraso ;chama a rotina de atraso
			ret
INT0_vetor:
	;rotina de serviço da interrupção externa (botão)

	;salva o regist. de estado
	/* 	   A variável pré-definida SREG está relacionada a um endereço de I/O (isolada)
	   Por isso, devemos usar as instruções in/out para lidar com este endereço	*/
	in r13,SREG
	;altera o contador
	cpi r17, 2 ;compara se o contador é igual a 2 (máximo valor que ele assume)
		brne incrementar ;caso não, incrementa o contador
		clr r17 ;caso sim, zera o contador
		rjmp terminar
	incrementar:
		inc r17 ;incrementa contador
	terminar:
		out SREG,r13; restaura o regist. de estado
		reti

/*rotina de atraso*/
atraso:
		cp r19, r21 ;compara o r19 com o r21 (parâmetro)
			breq fim ; quando forem iguais o programa é encerrado
		clr r20 ;clear no r20 para que o rotina2 sempre comece com esse registrador no 0
		inc r19 ;incrementar o r19
		call rotina1 ;vai para o segundo rotina
		call atraso ;repete primeira rotina (qtd de repetições de acordo com o valor em r16)
		
		fim:
		/*apagar o conteúdo dos regs para que a rotina possa ser executada novamente */
			clr r18 
			clr r19
			clr r20
			ret ;retorna ao programa principal (main)s

	rotina1:
		cpi r20, 57 ;compara r20 com 57 (número de vezes que essa rotina deve ser executado)
			breq volta ;quando for igual volta para o primeira rotina
		inc r20 ;incrementa o r20
		clr r18 ;clear no r18 para que a rotina3 sempre comece com esse registrador no 0
		call rotina2 ;chama a rotina3
		call rotina1 ;repete a segunda rotina, este será repetido 57 vezes para cada 1 vez da primeira

		volta:
			ret ;retorna à primeira rotina quando a segunda tiver sido executado 57 vezes

	rotina2:
		cpi r18, 255 ;compara r18 com 255 (número de vezes que a rotina deve ser executado)
			breq retorno ;quando for igual retornará para o código
		inc r18 ;incrementar o r18
		call rotina2 ;chamar a rotina novamente
	
		retorno:
			ret ; retorna à segunda rotina

