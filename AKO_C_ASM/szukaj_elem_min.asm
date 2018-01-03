; int * szukaj_elem_min(int tablica[], int n)
.686
.model flat
public _szukaj_elem_min
.code
_szukaj_elem_min proc
	push	ebp
	mov		ebp, esp
	push	ecx
	push	esi
	push	ebx
	; ---------------------------------
	mov		esi, [ebp+8]	; src arr addr
	mov		ecx, [ebp+12]	; arr len
	mov		eax, esi		; cur min addr
	lp1:
		mov		ebx, [eax]
		cmp		ebx, [esi]
		jle		lp1_continue
		mov		eax, esi
		lp1_continue:
		add		esi, 4
		loop	lp1
	; ---------------------------------
	pop		ebx
	pop		esi
	pop		ecx
	pop		ebp
	ret	
_szukaj_elem_min endp
end