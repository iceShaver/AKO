; unsigned int kwadrat (unsigned int a);
.686
.model flat
public _kwadrat
.code
_kwadrat PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	; -------------------------------------
	mov		eax, [ebp+8]
	cmp		eax, 0
	je		exit
	cmp		eax, 1
	je		exit
	mov		ebx, eax
	sub		eax, 2
	push	eax
	call	_kwadrat
	add		esp, 4
	lea		ecx, [4*ebx]
	add		eax, ecx
	sub		eax, 4
	exit:
	; -------------------------------------
	pop		ebx
	pop		ebp
	ret
_kwadrat ENDP
END