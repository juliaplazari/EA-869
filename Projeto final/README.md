# Projeto final

Programa em linguagem Assembly para o ATMega328P que controla a frequência
com que um LED pisca, de acordo com o pressionamento de um botão externo.

O sistema deve manter o LED piscando continuamente, sendo que o intervalo de tempo em que o
LED permanece aceso/apagado pode ser alterado por meio de um botão.
Inicialmente, o LED permanece aceso durante 1 segundo e, em seguida, fica apagado por mais 1
segundo. Cada vez que o botão é pressionado, este tempo é reduzido pela metade, de modo que o
LED passa a piscar mais rapidamente (os intervalos são de 1s, 0,5 s e 0,25 s).

**LED:** usamos o LED incorporado ao Arduino, que pode ser acionado pelo bit 5 da PORTA B (PB5). 

**Botão:** tratado pela interrupção externa INT0, ou seja, o pressionamento do botão deve gerar 
uma solicitação de interrupção no pino 2 da PORTA D (borda de subida)

