public	sum7
.code
sum7 proc
	mov		rax, 0
	add		rax, rcx
	add		rax, rdx
	add		rax, r8
	add		rax, r9
	add		rax, [rsp + 40]
	add		rax, [rsp + 48]
	add		rax, [rsp + 56]
	ret
sum7 endp
end