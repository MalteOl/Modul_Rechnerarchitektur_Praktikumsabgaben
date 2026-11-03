@ Programmgeruest zur Aufgabe 3 vom Termin4 RASS2025
@ Name:	Manfred Pester
@ Datum:	17.10.2024
@ letzte ￃﾄnderung: 13.02.2025

    .file   "wandel.S"
    .text       	@ legt eine Textsection fuer PrgrammCode + Konstanten an
    .align  2       @ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
                    @ d.h. die unteren 2 Bit sind 0
	.global wandel	@ nimmt wandel in die globale Sysmboltabelle auf
	.type	wandel, function
	
@ Programm zum wandeln eines String mit nur Zeichen aus dem 7-bit ASCII Zeichensatz
@ in einen String nach UTF-8 Standard 

wandel:
	
@r0 ASCII-String
@r1 @UTF-8 String

push {r4,r5,r6,r7,r8,r9,r10,r11}
mov r4,#0

loop:
	@ r0 iteriert ￼ber r0 in r2 als Zwischenschritt String Zeichen f￼r Zeichen Hallo in r2 H, dann ￼berschreibt er in a, l, l, o

	ldrb r2, [r0], #1 @load the first byte into r2
	ldrb r3, [r0] @load the second byte into r3
	
	@ae
	cmp r3,#'e' @ausgelesenes Zeichen ein Umlaut?
	cmpeq r2,#'a'
	moveq r2,#0xC3 @ #'￤' (Teil 1)
	moveq r3,#0xA4 @ #'￤' (Teil 2)
	streqb r2,[r1],#1
	streqb r3,[r1],#1
	addeq r0,r0,#1
	addeq r4,r4,#1
	
	beq loop
	
	@Ae
	cmp r3,#'e' @ausgelesenes Zeichen ein Umlaut?
	cmpeq r2,#'A'
	moveq r2,#0xC3 @ #'ￄ' (Teil 1)
	moveq r3,#0x84 @ #'ￄ' (Teil 2)
	streqb r2,[r1],#1
	streqb r3,[r1],#1
	addeq r0,r0,#1
	addeq r4,r4,#1

	
	beq loop
	
	@oe
	cmp r3,#'e' @ausgelesenes Zeichen ein Umlaut?
	cmpeq r2,#'o'
	moveq r2,#0xC3 @ #'￶' (Teil 1)
	moveq r3,#0xB6 @ #'￶' (Teil 2)
	streqb r2,[r1],#1
	streqb r3,[r1],#1
	addeq r0,r0,#1
	addeq r4,r4,#1

	
	beq loop
	
	@Oe
	cmp r3,#'e' @ausgelesenes Zeichen ein Umlaut?
	cmpeq r2,#'O'
	moveq r2,#0xC3 @ #'ￖ' (Teil 1)
	moveq r3,#0x96 @ #'ￖ' (Teil 2)
	streqb r2,[r1],#1
	streqb r3,[r1],#1
	addeq r0,r0,#1
	addeq r4,r4,#1


	beq loop

	@ue
	cmp r3,#'e' @ausgelesenes Zeichen ein Umlaut?
	cmpeq r2,#'u'
	moveq r2,#0xC3 @ #'￼' (Teil 1)
	moveq r3,#0xBC @ #'￼' (Teil 2)
	streqb r2,[r1],#1
	streqb r3,[r1],#1
	addeq r0,r0,#1
	addeq r4,r4,#1

	
	beq loop

	@Ue
	cmp r3,#'e' @ausgelesenes Zeichen ein Umlaut?
	cmpeq r2,#'U'
	moveq r2,#0xC3 @ #'ￜ' (Teil 1)
	moveq r3,#0x9C @ #'ￜ' (Teil 2)
	streqb r2,[r1],#1
	streqb r3,[r1],#1
	addeq r0,r0,#1
	addeq r4,r4,#1

	
	beq loop

	@sz
	cmp r2,#'s'
	cmpeq r3,#'z'
	moveq r2,#0xC3 @ #'￟' (Teil 1)
	moveq r3,#0x9F @ #'￟' (Teil 2)
	streqb r2,[r1],#1
	streqb r3,[r1],#1
	addeq r0,r0,#1
	addeq r4,r4,#1

	
	beq loop

	
	
	strb r2, [r1], #1 @ store r2 into r1, r2=r2+1, nur wenn kein Umlaut	

einUmlaut:	
	cmp r2,#0	@Flags setzen, letztes Byte 0

	bne loop @Bed. am Ende angelangt? if Z=1, es kommt \a f￼r line feed \n und danach 0 beim Durchsteppen	

	mov r0,r4
	pop {r4,r5,r6,r7,r8,r9,r10,r11}

	bx	lr
	
	
		
.wandel_end:
	.size	wandel,.wandel_end-wandel
.end	@ End of File
