.686
.model	flat
extern	_ExitProcess@4	:	PROC
extern	__read			:	PROC
extern	__write			:	PROC
public	_main
.data
.code
read_to_EAX	PROC
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi
	push	ebp
	sub		esp, 12
	mov		edi, esp
	push	dword PTR 12
	push	edi
	push	dword PTR 0
	call	__read
	add		esp, 12
	mov		esi, 0	; flaga minusa
	mov		eax, 0
	mov		ebx, edi
	;	sprawdz czy jest minus
	mov		cl, [ebx]

	cmp		cl, '-'
	jne		get_chars
	mov		esi, 1
	inc		ebx

	get_chars:
		mov		cl, [ebx]
		inc		ebx
		cmp		cl, 10
		je		return
		sub		cl, 30H
		movzx	ecx, cl
		mov		edi, 10
		mul		edi
		add		eax, ecx
		jmp		get_chars
	return:
	;	if minus
	cmp		esi, 1
	jne		continue_minus
	neg		eax
	continue_minus:
	add		esp, 12
	pop		ebp
	pop		edi
	pop		esi
	pop		edx
	pop		ecx
	pop		ebx
		ret
read_to_EAX	ENDP

print_EAX	PROC
	pusha
	sub		esp, 12
	mov		edi, esp	; stack pinter with output numbers
	mov		esi, 10		; chars index
	mov		ebx, 10		; divisor (dzielnik)
	cmp		eax, 0
	jl		is_minus
	mov		ecx, 0		; minus flag
	jmp		convert
	is_minus:
	mov		ecx, 1
	neg		eax
	convert:

		mov		edx, 0	; put 0 in high part of divident (dzielna)
		div		ebx
		add		dl, 30H	; to ASCII
		mov		[edi][esi], dl
		dec		esi
		cmp		eax, 0
		jne		convert

	fill:
		or		esi, esi
		jz		print						; if ESI==0
		mov		byte PTR [edi][esi], 20H	; space
		dec		esi
		jmp		fill

	print:
		cmp		ecx, 1
		je		minus
		mov		byte PTR [edi][0], 20H
		jmp		continue_print
		minus:
		mov		byte PTR [edi][0], '-'
		continue_print:
		mov		byte PTR [edi][11], 10
		push	dword PTR 12
		push	edi
		push	dword PTR 1
		call	__write
		add		esp, 12
	add		esp, 12
	popa
	ret
print_EAX	ENDP

_main	PROC
	call	read_to_EAX	
	inc		EAX
	call	print_EAX
	push	0
	call	_ExitProcess@4
_main	ENDP
END