.686
.model flat
public _square_sum
.code
_square_sum  proc
	push	ebp
	mov		ebp, esp

	push	ebx
	mov		eax, [ebp+8]
	mul		eax
	mov		ebx, eax
	mov		eax, [ebp+12]
	mul		eax
	add		eax, ebx

	pop		ebx
	pop		ebp
	ret
_square_sum endp
end