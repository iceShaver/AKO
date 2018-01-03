.686
.model flat
extern	_ExitProcess@4	:	PROC
.data
liczba	dword	-1268.478
wynik	qword	?
.code
_main PROC	
	lea		esi, liczba
	lea		edi, wynik
	; -------------------------------------
	mov		eax, dword PTR[esi]
	shr		eax, 31
	mov		ebx, dword PTR[esi]
	shl		ebx, 1
	shr		ebx, 1+23
	sub		ebx, 127
	add		ebx, 1023
	mov		ecx, dword PTR[esi]
	shl		ecx, 9
	shr		ecx, 9
	shl		eax, 31
	mov		edx, eax
	shl		ebx, 20
	or		edx, ebx
	mov		eax, ecx
	shr		eax, 3
	or		edx, eax
	mov		[edi+4], dword PTR edx
	shl		ecx, 29
	mov		[edi], dword PTR ecx
	nop

	; -------------------------------------
	push	0
	call	_ExitProcess@4
_main ENDP
END