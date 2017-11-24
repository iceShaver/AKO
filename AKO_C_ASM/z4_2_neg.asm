.686
.model	flat
public _neg
.code
_neg PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	add		ebp, 8
	mov		ebx, [ebp]
	neg		dword ptr [ebx]
	pop		ebx
	pop		ebp
	ret
_neg ENDP
end