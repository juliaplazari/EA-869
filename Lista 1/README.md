# Lista 1

## Item 1

Programa em em linguagem Assembly que determina a soma de todos os números naturais de 1 a n,
definindo n no início do programa e o armazenando no registrador r16. 



## Item 2 (teórico)

Como atingir os seguintes objetivos:

a) Isolar os bits 3 e 4 do registrador r16.

Para isolar os bits 3 e 4 do registrador podemos usar a instrução ANDI (logical AND with immediate):
- andi rd,k (sendo rd o registrador e k o valor)
- andi r16, 24
sendo que 24 é o decimal corresponde a uma máscara para os bits 3 e 4 (00011000)
A função faz um and bit a bit e usando o 00011000 teremos todos os bits iguais a 0,
exceto pelo b3 e b4 que irão manter seu valor.

b)  Setar os bits 2 e 7 do registrador r16.

Para setar os bits 2 e 7 do registrador podemos usar a instrução SBR (set bits in register):
- sbr rd,k (sendo rd o registrador e k o número com os bits que se deseja setar em nível alto)
- sbr r16, 132
sendo que 132 é o número decimal que corresponde aos bits 2 e 7 setados 10000100
Com essa função é possível setar bits específicos, enquanto os demais bits permanecem como estavam.

c) Apagar (zerar) os bits 6, 5 e 1 do registrador r16.

Para apagar (zerar) os bits 6,5 e 1 do registrador podemos usar a instrução CBR (clear bit in I/O register)
- cbr rd,k (sendo rd o registrador e k o número com os bits que se deseja zerar em nível alto)
- cbr r16, 98
sendo que 98 é o número decimal que corresponde aos bits 6,5 e 1 setados 01100010
Com essa função é possível zerar bits específicos, enquanto os demais permanecem como estavam.

## Item 3

Programa que verifica se a cadeia de bits armazenada no registrador r16 é um **palíndromo**.
A resposta é armazenada no registrador r20 (‘1’ caso r16 seja um palíndromo, e ‘0’ caso contrário).

OBS: Uma sequência é considerada um palíndromo se o mesmo conteúdo é observado
quando lemos a sequência da esquerda para a direita, e da direita para a esquerda. (ex: 1001)

## Item 4

Programa que realiza a divisão inteira ente dois números naturais a e b, sendo que eles estão inicialmente 
armazenados na memória de programa (Flash)












