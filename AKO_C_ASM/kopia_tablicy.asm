; int * kopia_tablicy(int tabl[], unsigned int n);
; zwraca wskaŸnik na kopiê tablicy tylko z elementami o parzystej wartoœci, reszta wyzerowana
.686
.model flat
public _kopia_tablicy
extern _malloc	:	PROC
extern _calloc	:	PROC
.code
_kopia_tablicy PROC
	push	ebp
	mov		ebp, esp
	push	esi
	push	edi
	push	ecx
	push	edx
	; ----------------------------------------------
	mov		esi, [ebp+8]	; src arr addr
	mov		ecx, [ebp+12]	; src arr size
	push	ecx
	call	_calloc			; __cdecl -> care stack, eax, ecx, edx	
	pop		ecx
	cmp		eax, 0
	je		error			; if malloc ret 0
	shr		ecx, 2
	mov		edi, eax
	lp1:
		mov		edx, [esi]
		bt		edx, 0
		jc		continue	; if odd
		mov		[edi], edx
		continue:
		add		esi, 4
		add		edi, 4
		loop	lp1
	error:
	; ----------------------------------------------
	pop		edx
	pop		ecx
	pop		edi
	pop		esi
	pop		ebp
	ret
_kopia_tablicy ENDP
END