.686
.model flat
public	_inc
.code
_inc	PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	add		ebp, 8
	mov		ebx, [ebp]
	inc		dword ptr[ebx]
	pop		ebx
	pop		ebp
	ret
_inc	ENDP
END