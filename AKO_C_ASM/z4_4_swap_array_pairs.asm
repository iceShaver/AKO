.686
.model flat
public _swap_array_pairs
.code
_swap_array_pairs proc
	push	ebp
	mov		ebp, esp
	add		ebp, 8
	push	ebx
	push	ecx
	push	eax
	push	edx

	mov		ebx, [ebp]		; array adress
	mov		ecx, [ebp + 4]	; number of elements
	dec		ecx
	lp1:
		mov		eax, [ebx]
		cmp		eax, [ebx+4]
		jg		swap
		jmp		continue
		swap:
			mov		edx, [ebx+4]
			mov		[ebx+4], eax
			mov		[ebx], edx
		continue: 
			add		ebx, 4
			loop	lp1
	pop		edx
	pop		eax
	pop		ecx
	pop		ebx
	pop		ebp
	ret
_swap_array_pairs endp
end