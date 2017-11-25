; SSE examples
.686
.XMM
.model	 flat
public	_add_SSE
public	_sqrt_SSE
public	_invert_SSE

.code

; void add_SSE(float * p_array, float * q_array, float * r_array);
_add_SSE proc
	push	ebp
	mov		ebp,esp
	push	ebx
	push	esi
	push	edi
	;--------------------------------------------------------------
	mov		esi, [ebp+8]	; p-array address (src)
	mov		edi, [ebp+12]	; q-array address (src)
	mov		ebx, [ebp+16]	; r-array address (src)
	movups	xmm5, [ebp+8]		; load 4 numbers of p-array into xmm5 
	movups	xmm6, [edi]		; load 4 numbers of q-array into xmm6
	addps	xmm5, xmm6		; sum 4 numbers
	movups	[ebx], xmm5		; move 4 numbers from xmm5 to r-array
	;--------------------------------------------------------------
	pop		edi
	pop		esi
	pop		ebx
	pop		ebp
	ret
_add_SSE endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void sqrt_SSE(float * src, float * dest);
_sqrt_SSE proc
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	;-------------------------------------------------------------
	mov		esi, [ebp+8]	; p-array adsress
	mov		ebx, [ebp+12]	; r-array address
	movups	xmm6, [esi]
	sqrtps	xmm5, xmm6
	movups	[ebx], xmm5
	;-------------------------------------------------------------
	pop		esi
	pop		ebx
	pop		ebp
	ret
_sqrt_SSE endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void invert_SSE(float * src, float * dest);
_invert_SSE proc
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	;-------------------------------------------------------------
	mov		esi, [ebp+8]
	mov		ebx, [ebp+12]
	movups	xmm6, [esi]
	rcpps	xmm5, xmm6
	movups	[ebx], xmm5
	;-------------------------------------------------------------
	pop		esi
	pop		ebx
	pop		ebp
	ret
_invert_SSE endp
end