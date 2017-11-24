.686
.model	flat
extern	__write			:	PROC
extern	__read			:	PROC
extern	_ExitProcess@4	:	PROC
public	_main
.data
hex_decoder	byte	'0123456789ABCDEF'
.code
read_to_EAX	PROC
	push	ECX
	push	EDX
	push	EBX
	push	EDI
	sub		esp, 12
	mov		edi, esp
	push	dword PTR 12
	push	edi
	push	dword PTR 0
	call	__read
	add		esp, 12

	mov		eax, 0
	mov		ebx, edi
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
	add		esp, 12
	pop		edi
	pop		EBX
	pop		EDX
	pop		ECX
		ret
read_to_EAX	ENDP
print_EAX_hex	PROC
	pusha
	sub		esp, 12
	mov		edi, esp	; stack 12-bit storage pointer
	mov		ecx, 8
	mov		esi, 1
	lp1:
		rol		eax, 4
		mov		ebx, eax
		and		ebx, 0000000FH
		mov		dl, hex_decoder[ebx]
		mov		[edi][esi], dl
		inc		esi
		loop	lp1
	mov		byte PTR[edi][0], 10
	mov		byte PTR[edi][9], 10
	push	10
	push	edi
	push	1
	call	__write
	add		esp, 24
	popa
	ret
print_EAX_hex	ENDP

_main	PROC
	call	read_to_EAX	
	call	print_EAX_hex	
	push	0
	call	_ExitProcess@4
_main ENDP
END