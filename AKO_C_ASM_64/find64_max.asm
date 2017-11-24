public	find64_max
.code
find64_max proc
	push	rbx
	push	rsi
	mov		rbx, rcx
	mov		rcx, rdx
	mov		rsi, 0
	mov		rax, [rbx+rsi*8]
	dec		rcx
	ptl1:
		inc		rsi
		cmp		rax, [rbx+rsi*8]
		jge		continue
		mov		rax, [rbx+rsi*8]
		continue: loop ptl1
	pop		rsi
	pop		rbx
	ret
find64_max endp
end