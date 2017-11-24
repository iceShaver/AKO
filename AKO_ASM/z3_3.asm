.686
.model	flat
extern	_ExitProcess@4	: PROC
extern	__write			: PROC
public	_main
extern	__read			: PROC
.data
storage		byte 12 dup (?)
decimal		dword 10	; multiplier
txt			byte 'Given number is too big', 10
txt_end		byte ?
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
print_EAX	PROC
	pusha
	mov		esi, 10		; chars index
	mov		ebx, 10		; divisor (dzielnik)

	convert:
		mov		edx, 0	; put 0 in high part of divident (dzielna)
		div		ebx
		add		dl, 30H	; to ASCII
		mov		storage[esi], dl
		dec		esi
		cmp		eax, 0
		jne		convert

	fill:
		or		esi, esi
		jz		print						; if ESI==0
		mov		byte PTR storage[esi], 20H	; space
		dec		esi
		jmp		fill

	print:
		mov		byte PTR storage[0], 20H
		mov		byte PTR storage[11], 10
		push	dword PTR 12
		push	dword PTR OFFSET storage
		push	dword PTR 1
		call	__write
		add		esp, 12
	popa
	ret
print_EAX	ENDP

_main	PROC
	call	read_to_EAX
	cmp		eax, 60000
	ja		too_big
	mul		eax
	call	print_EAX
	jmp exit
	too_big:
		mov	    eax, dword PTR OFFSET txt_end - OFFSET txt
		push	eax
		push	dword PTR OFFSET txt
		push	dword PTR 1
		call	__write
		add		esp, 12
	exit:
	push	dword PTR 0
	call	_ExitProcess@4
_main	ENDP
END