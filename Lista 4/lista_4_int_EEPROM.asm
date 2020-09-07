;
; Atividade 4.asm
;
; Created: 6/7/2019 4:31:53 PM
; Author :  Julia Lazari RA: 200298
;			Barbara Dill RA: 213394
;

;define endere�o inicial de escrita na EEPROM
.equ END_EEPROM = 0x00ab

;in�cio do c�digo
.cseg
	;em 0x00, temos o vetor de interrup��o para o reset
	.org 0x0000
	rjmp reset
	;em 0x002C, temos o vetor de interrup��o para a EEPROM
	.org 0x002C
	rjmp EEPROM_vetor
	;os vetores de interrup��o do ATMega terminam em 0x0034, ent�o o programa pode come�ar depois disso
	.org 0x0034		
;alocar bytes na mem�ria de programa
dados: .db 4, 0x76, 0xbd, 0x45, 0x6d

reset: 
	;colocar no registrador X o end de acesso inicial � EEPROM
	ldi r27,high(END_EEPROM)
	ldi r26,low(END_EEPROM)
	
	;definir o endere�o inicial de acesso � mem�ria de programa
	ldi ZH,high(dados*2)
	ldi ZL,low(dados*2)

	;carrega em r20 o valor do n�mero de bytes que deve ser escrito
	lpm r20,Z+; n�mero 4 vai ser gravado no r20

	;habilitar a flag de interrup��es da EEPROM
		sbi EECR,3
	;habilitar a flag geral de interrup��es
		sei


;programa principal
/* Enquanto a mem�ria EEPROM n�o estiver pronta para nova opera��o, o programa gasta tempo com algumas oper��es
	  O conte�do de r20 � comparado com 0, para descobrir quando todos os dados foram escritos */

main:
	cpi r20, 0 ;compara o r20 (onde est� armazenado o n�mero de dados a serem escritos) com 0
	breq final ;caso seja 0 encerra-se o programa
	/*programa para gastar tempo */
	loop:
		add r17,r18 ;somar conte�do de r17 e r18
		cp r16,r18 ;comparar r16 e r18
		breq continua ;caso r16 seja igual a r18
		inc r18 ;incremeta valor de r18
		rjmp loop
	continua: 
		inc r16 ;aumenta o valor de r16 (soma come�a novamente)
		cpi r16, 255
		breq volta
	rjmp main
	volta: 
		clr r16 ;zera r16 para come�ar novamente
		rjmp main
		

EEPROM_vetor:
	in r12, SREG ;salva valor do registrador de estados em r12
	out EEARH, r27 ;valor do reg X indica o end de mem�ria para escrita
	out EEARL, r26
	lpm r21, Z+ ;coloca em r21 o dado que deve ser escrito 
	inc r26 ;incrementa XL
	out EEDR, r21
	sbi EECR, 2 ;seta master enable da EEPROM
	sbi EECR, 1 ;seta write enable da EEPROM
	dec r20 ;indica que um byte foi escrito na EEPROM
	out SREG, r12 ;devolve a SREG sua condi��o inicial (antes da op de escrita)
	reti ;retorna da interrup��o

final:
	in r24, EECR ;desabilitar a flag de interrup��es da EEPROM
	andi r24, 0xF7
	out EECR, r24
	break ;encerra programa


