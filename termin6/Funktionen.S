// von: Manfred Pester
// vom: 18.09.2013
// @ int Operationen(volatile unsigned int* u_int_Taster, volatile unsigned int* u_int_LedsOn) 
@ Diese Funktion soll auf 
@ - LED DS1 (Bit 8) das Ergebnis von SW1 AND SW2 anzeigen 
@ - LED DS2 (Bit 9) das Ergebnis von SW1 OR SW2 anzeigen 
@ - LED DS3 (Bit 10) das Ergebnis von SW1 EOR SW2 anzeigen 
@ - LED DS4 und 5 (Bit 11/12) das Ergebnis von SW1 ADD SW2 anzeigen 
@ - LED DS6 und 7 (Bit 13/14) das Ergebnis von SW1 SUB SW2 anzeigen 
@ und bei gedrueckter TASTE SW3 (Bit 5) soll die Funktion ein TRUE (Wert ungleich 0) ansonsten FALSE (Wert gleich 0) an das aufrufende Programm zurueck geben.
@ ACHTUNG die Tasten und auch die Leuchtdioden sind Low-Aktiv beschaltet.
	.file	"Funktionen.S" 
	.text 
	.align	2 
	.global	Operationen 
	.type	Operationen, %function 
Operationen:

mov r6,#0
push {r4-r10}
ldr r2,[r0]          @r0=PDSR aus diesem können SW1 bis 3 gelesen werden, CODR schaltet LEDs ein

LSRS R2,R2,#4        @r4=SW1
MOVCS r4,#0
MOVCC r4,#1

LSRS R2,R2,#1        @r5=SW2
MOVCS r5,#0
MOVCC r5,#1

LSRS R2,R2,#1        @r0=SW3
MOVCS r0,#0
MOVCC r0,#1

// AND	 
AND r7,r4,r5         @DS1=SW1 AND SW2
lsl r7,#8
orr r6,r6, r7
str r6,[r1]

// ORR	 
ORR r7,r4,r5         @DS2=SW1 OR SW2
lsl r7,#9
orr r6,r6, r7 
str r6,[r1]

// EOR 

eor r7,r4,r5         @DS3=SW1 EOR SW2
lsl r7,#10
orr r6,r6,r7
str r6,[r1]
 

// ADDITION	 
add r7,r4,r5      @DS4/5=SW1+SW2

and r8,r7,#1
lsr r9,r7,#1
and r9,r9,#1

lsl r8,#12
lsl r9,#11

orr r6,r6,r8
orr r6,r6,r7
str r6,[r1]


// SUBTRAKTION 
sub r7,r4,r5         @DS6/7=SW1-SW2
and r7,r7,#3

and r8,r7,#1
lsr r9,r7,#1
and r9,r9,#1

lsl r8,#14
lsl r9,#13

orr r6,r6,r8
orr r6,r6,r9

str r6,[r1]
@ mov r0 , #1

pop {r4-r10}
// Beenden 

 bx lr
 
.Lfe1: 
	.size	Operationen,.Lfe1- Operationen 
// End of File


//










