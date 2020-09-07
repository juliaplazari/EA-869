;
; codificação.asm
;
; Created: 5/23/2019 10:34:21 AM
; Author : julina
;


.dseg
	codigo: .byte 24

	.cseg		
	vetor: .db 3, 0x86, 0x73, 0xa4

			ldi r27, 0x01
			ldi r26, 0xff
			ldi r30, 0x00		; gravando o endereço de memoria que está o N 
			ldi r31, 0x00		
			lpm					; passando o dado do N para r0
			mov r16, r0			; r16 é o regitrador em que está o N
			ldi r17, 0			; r17 é um registrador auxiliar para o loop da leitura
leitura:	cp r17, r16			; no momento que r17 é igual a r16 ele para de ler os dados
			breq fimdaleitura
			inc r17				; incrementa r17
			inc r30				; incrementa r30 que é um registrador auxiliar de leitura, e assim será lido o proximo dado
			lpm					; passando o dado a ser analisado para r0
			mov r18, r0			; r18 é o regitrador em que está o dado
			ldi r21, 0			; registrador q armazena o valor anterior do bit do dado
			ldi r22, 0			; registrador para analisar os 8 bits de cada dado
dado:		cpi r22, 8			; compara se for igual a 8 todos os bits foram analisados e pode ir para o proximo dado
			breq fimdado
			inc r22				; incrementa r22
			lsl r18				; move todos os bits a esquerda, bit7 vai para o carry e o bit0 fica igual a 0
			rol r19				; move os bits a esquerda e coloca no bit 7 o carry da instrução anterior
			cpi r19, 0			; analisa se o bit é igual a 0
			breq zero			; caso for zero ele pula 
			cpi r21, 1			; se não for 0, irá ser 1 e precisa analisar qual era o bit codificado anterior
			breq negativo		; caso o bit anterior for igual a 1 positivo, ele pula para escrever o resultado
			ldi r20, 1			; se o bit codificado anterior não for igual a 1, ele escreve o resultado como 1 positivo
			mov r21, r20		; e o resultado será colocado no r21, para poder usar no proximo loop como bit codificado anteriormente
			jmp clear
negativo:	ldi r20, 0xff		; o resultado da codificação vai ser -1
			mov r21, r20		; e o resultado será colocado no r21, para poder usar no proximo loop como bit codificado anteriormente
			jmp clear 
zero:		ldi r20, 0			; caso o bit analisado for 0, será escrito 0 no resultado
clear:		clr r19				; limpa o r19 para a analise do proximo bit
			st x+, r20			; escrever resultado na SRAM
			jmp dado 
fimdado:	jmp leitura

fimdaleitura: break
