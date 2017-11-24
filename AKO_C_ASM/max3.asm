.686
.model	flat
public	_max3
.code
_max3	PROC
	push	ebp
	mov		ebp, esp

	mov		eax, [ebp+8]	; a
	cmp		eax, [ebp+12]
	jge		x_wieksza
	mov		eax, [ebp+12]	; b
	cmp		eax, [ebp+16]
	jge		y_wieksza
	wpisz_z:
		mov		eax, [ebp+16]
	zakoncz:
		pop		ebp
		ret
	x_wieksza:
		cmp		eax, [ebp+16]
		jge		zakoncz
		jmp		wpisz_z
	y_wieksza:
		cmp		eax, [ebp+12]
		jmp		zakoncz
_max3 ENDP
END