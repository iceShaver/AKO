; program przyklˆadowy (32-bit)
.686
.model	flat
extern _ExitProcess@4	: PROC
extern	__write			: PROC
public	_main

.data	
tekst	db	10, 'Nazywam si',0A9H,' Kamil Kr',0A2H,'likowski', 10
		db	'M',0A2H,'j pierwszy 32-bitowy program '
		db	'asemblerowy dzia',88H,'a ju',0BEH,' poprawnie!', 10
koniec_tekst	db ?
.code	
_main	PROC
	mov ecx, OFFSET koniec_tekst - OFFSET tekst ; liczba znakOw wy˜swietlanego tekstu

	; wywoˆlanie funkcji write z biblioteki jezyka C
	push	ecx						; liczba znakow wy˜swietlanego tekstu
	push	dword PTR OFFSET tekst	; poˆlozenie obszaru ze znakami
	push	dword PTR 1				; uchwyt urzadzenia wyj˜sciowego
	call	__write					; wy˜wietlanie znakow
	add		esp, 12					; usuniecie parametrow ze stosu
	;zakonczenie wykonywania programu
	push	dword PTR 0				; kod powrotu programu
	call	_ExitProcess@4
_main	ENDP
END