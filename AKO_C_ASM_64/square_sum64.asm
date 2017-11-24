public	square_sum64
.code
square_sum64 proc
	push	rbp
	mov		rbp, rsp
	push	rbx
	push	r11

	mov		r11, rdx
	mov		rax, rcx
	mul		rax
	mov		rbx, rax

	mov		rax, r11
	mul		rax
	add		rax, rbx

	pop		r11
	pop		rbx
	pop		rbp
	ret
square_sum64 endp
end