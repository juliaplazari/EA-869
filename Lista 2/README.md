# Lista 2

## Item 1

Programa que computa o valor do n-ésimo termo da sequência de Fibonacci de maneira recursiva.

## Item 2

Programa que gera uma sequência de símbolos de acordo com a codificação AMI.

A codificação AMI (Alternated Mark Inversion) representa cada bit de informação (bi) por meio de um símbolo do alfabeto ternário ci ∈
{-1,0,1} de acordo com a seguinte regra:

- 0 se bi = 0
- 1 se bi = 1 e o último bit foi codificado como - 1
- -1 se bi = 1 e o último bit foi codificado como 1

A sequência de bits de informação (entrada) está armazenada em um conjunto de N bytes da
memória de programa a partir da posição rotulada como vetor, sendo que o primeiro byte nesta
área de memória indica o valor de N. 

A sequência de símbolos codificados deverá ser gravada na memória de dados (SRAM). Ou seja,
a codificação de cada bit do vetor de entrada será um byte armazenado na memória de
dados. Então, no total serão gravados 8N bytes.
