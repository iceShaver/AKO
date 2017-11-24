.686
.model	flat
extern	_ExitProcess@4	: PROC
extern	__write			: PROC
public	_main
extern	__read			: PROC
.data
storage		byte 12 dup (?)
decimal		dword 10	; multiplier
.code
read_to_EAX	PROC
	push	ECX
	push	EDX
	push	EBX
	push	dword PTR 12
	push	dword PTR OFFSET storage
	push	dword PTR 0
	call	__read
	add		esp, 12

	mov		eax, 0
	mov		ebx, OFFSET storage
	get_chars:
		mov		cl, [ebx]
		inc		ebx
		cmp		cl, 10
		je		return
		sub		cl, 30H
		movzx	ecx, cl
		mul		dword PTR decimal
		add		eax, ecx
		jmp		get_chars
	return:
	pop		EBX
	pop		EDX
	pop		ECX
		ret
read_to_EAX	ENDP
_main	PROC
	call	read_to_EAX	
	push	dword PTR 0
	call	_ExitProcess@4
_main	ENDP
END