; MessageBoxA, MessageBoxW
.686
.model flat
extern	_ExitProcess@4	:	PROC
extern	_MessageBoxA@16	:	PROC
extern	_MessageBoxW@16	:	PROC

public	_main

.data	
	tytul_unicode	dw	'T','e','k','s','t',' ','w',' '
					dw	'f','o','r','m','a','c','i','e',' '
					dw	'U','T','F','-','1','6',0105h, 0
	tekst_unicode	dw	'K','a','z','d','y',' ','z','n','a','k',' '
					dw	'z','a','j','m','u','j','e',' '
					dw	'1','6',' ','b','i','t','o','w',0
	tytul_Win1250	db	'Tekst w standardzie Windows 1250', 0
	tekst_Win1250	db	'Kazdy znak zajmuje 8 bitow', 0

.code
_main	PROC
	push	0	; stala MB_OK
	push	OFFSET tytul_Win1250
	push	OFFSET tekst_Win1250
	push	0
	call	_MessageBoxA@16

	push	0
	push	OFFSET tytul_unicode
	push	OFFSET tekst_unicode
	push	0
	call	_MessageBoxW@16

	push	0
	call	_ExitProcess@4
_main	ENDP
END