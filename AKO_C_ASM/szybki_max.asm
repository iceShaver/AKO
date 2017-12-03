; float array_sum_SSE(char * a_src, char * b_src, char * dest, unsigned count);

.686
.xmm
.model flat
public	_szybki_max
.data	

.code
_szybki_max proc
	push	ebp
	mov		ebp, esp
	push	esi
	push	ebx
	push	edi
	push	eax
	push	ecx
	; -----------------------------------------
	mov		esi, [ebp+8]	; A
	mov		edi, [ebp+12]	; B
	mov		ebx, [ebp+16]	; result
	mov		eax, [ebp+20]	; counter
	mov		edx, 0
	mov		ecx, 4
	div		ecx
	mov		ecx, eax
	lp1:
		movups	xmm5, [esi]
		movups	xmm6, [edi]
		maxps	xmm5, xmm6
		movups	[ebx], xmm5
		add		esi, 16
		add		edi, 16
		add		ebx, 16
		loop	lp1

	; -----------------------------------------
	pop		ecx
	pop		eax
	pop		edi
	pop		ebx
	pop		esi
	pop		ebp
	ret
_szybki_max endp
end