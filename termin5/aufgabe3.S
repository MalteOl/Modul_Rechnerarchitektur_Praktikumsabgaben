// Name:		Matrikelnummer:
// Name:		Matrikelnummer:
// Datum:

	.file	"aufgabe3.S"
	.text			@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align	2		@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
				@ unteren 2 Bit sind 0
	.global	main		@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type	main,function
main:
mov r0,#0  @Total
mov r3,#4  @Counter


loop: 	

Add_instr: 

	ldr r1,Table		@Table=39
	add r0,r0,r1				@ein Element in Table weitergehen
	ldr r2,Add_instr			@in r2 Befehl ldr r1, Table laden
	ADD r2,r2,#4				@wir gehen byteweise im Array durch 
	str r2, Add_instr			@selbstmodifizierender Code
	subs r3,r3,#1          			@Counter um 1 dekrementieren
	str r3,Count				@4 in r3 storen

	@cmp r3,#0
	bpl loop				@Counter >= 0?


Halt:
	b	Halt

//; Data definitions
//Total 	DEFW 0 ; Total - initially zero
Total:	.word	0
//One 	DEFW 1 ; The number one
//Count 	DEFW 4 ; Loop counter (loop 5x)
Count:	.word	4
//Table 	DEFW 39 ; The numbers to total ...
//	DEFW 25 ;
//	DEFW 4 ;
//	DEFW 98 ;
//	DEFW 17 ;
Table:	.word	39, 25, 4, 98, 17


.Lfe1:
	.size	main,.Lfe1-main

// End of File
