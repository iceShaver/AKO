; unsigned NWD(unsigned a, unsigned b)
.686
.model flat
public _NWD
.code
_NWD	PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	push	edi
	mov		esi, [ebp+8]	; a
	mov		edi, [ebp+12]	; b
	cmp		esi, edi
	jne		else1
	mov		eax, esi
	jmp		koniec
	else1:
	cmp		esi, edi
	jbe		else2
	sub		esi, edi
	push	edi
	push	esi
	call	_NWD
	add		esp, 8
	jmp		koniec
	else2:
	sub		edi, esi
	push	edi
	push	esi
	call	_NWD
	add		esp, 8
	koniec:
	pop		edi
	pop		esi
	pop		ebx
	pop		ebp
	ret
_NWD	ENDP
END