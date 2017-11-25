; AVX 2.0 examples
public	FMA
.data
scalarA		dword	4 dup (?) ; scalarA param
.code
FMA proc
	push	rbp
	mov		rbp, rsp
	push	rbx
	push	rsi
	push	rdi
	;-----------------------------
	mov		rsi, rcx	; matrix A address
	mov		rdi, rdx	; matrix B address
	; calc loop counter
	mov		rdx, 0
	mov		rbx, 32
	mov		rax, r9
	div		rbx
	xchg	rdx, rax
	cmp		rax, 0
	jne		finish
	mov		rcx, rdx

	lp1:
		vmovups			XMMWORD PTR scalarA, xmm2 ; multiplier
		vbroadcastss	ymm2, scalarA
		vmovaps			ymm0, YMMWORD PTR [rsi]
		vmovaps			ymm1, YMMWORD PTR [rdi]
		VFMADD132PS		ymm0, ymm1, ymm2
		vmovaps			YMMWORD PTR [rsi], ymm0
		add				rsi, 8*4
		add				rdi, 8*4
		loop lp1

	finish:
	;-----------------------------
	pop		rdi
	pop		rsi
	pop		rbx
	pop		rbp
	ret
FMA endp
end