; float array_sum_SSE(char * a_src, char * b_src, char * dest, unsigned count);

.686
.xmm
.model flat
public	_array_sum_SSE
.data	

.code
_array_sum_SSE proc
	push	ebp
	mov		ebp, esp
	push	esi
	push	ebx
	push	edi
	; -----------------------------------------
	mov		esi, [ebp+8]	; A
	mov		edi, [ebp+12]	; B
	mov		ebx, [ebp+16]	; result
	movups	xmm5, [esi]
	movups	xmm6, [edi]
	paddsb	xmm5, xmm6
	movups	[ebx], xmm5
	; -----------------------------------------
	pop		edi
	pop		ebx
	pop		esi
	pop		ebp
	ret
_array_sum_SSE endp
end