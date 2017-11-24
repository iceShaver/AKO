.686
.model flat
public _dec_ptr_ptr
.code
_dec_ptr_ptr PROC
	push	ebp
	mov		ebp, esp

	add		ebp, 8
	push	ebx
	mov		ebx, [ebp]
	mov		ebx, [ebx]
	dec		dword ptr [ebx]

	pop		ebx
	pop		ebp
	ret
_dec_ptr_ptr ENDP
end