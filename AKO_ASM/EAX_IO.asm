.686
.model	flat
extern	_ExitProcess@4	:	PROC
extern	__read			:	PROC
extern	__write			:	PROC
public	_main
.data
hex_decoder	byte	'0123456789ABCDEF'
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
	push	edi		; adres stosu pod którym sa wczystane znaki
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
	pop		ebp
	pop		edi
	pop		esi
	pop		edx
	pop		ecx
	pop		ebx
		ret
read_to_EAX	ENDP

read_to_EAX_hex	PROC
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi
	push	ebp
	sub		esp, 12
	mov		esi, esp
	push	dword PTR 10
	push	esi
	push	dword PTR 0
	call	__read
	add		esp, 12
	mov		eax, 0
	start_conv:
		mov		dl, [esi]
		inc		esi
		cmp		dl, 10
		je		finished
		cmp		dl, '0'
		jb		start_conv
		cmp		dl, '9'
		ja		move_on
		sub		dl, '0'
	append:
		shl		eax, 4
		or		al, dl
		jmp		start_conv
	move_on:
		cmp		dl, 'A'
		jb		start_conv
		cmp		dl, 'F'
		ja		move_on_2
		sub		dl, 'A' - 10
		jmp		append
	move_on_2:
		cmp		dl, 'a'
		jb		start_conv
		cmp		dl, 'f'
		ja		start_conv
		sub		dl, 'a' - 10
		jmp		append
	finished:
		add		esp, 12
		pop		ebp
		pop		edi
		pop		esi
		pop		edx
		pop		ecx
		pop		ebx
		ret
read_to_EAX_hex	ENDP

print_EAX	PROC
	pusha
	sub		esp, 12
	mov		edi, esp
	mov		esi, 10		; chars index
	mov		ebx, 10		; divisor (dzielnik)

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
		mov		byte PTR [edi][0], 20H
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
	mov		ecx, 8
	mov		ebx, 1
	lp2:
		cmp		byte PTR[edi][ebx], '0'
		jne		lp2_break
		mov		byte PTR[edi][ebx], ' '
		inc		ebx
		loop	lp2
	lp2_break:
	push	10
	push	edi
	push	1
	call	__write
	add		esp, 24
	popa
	ret
print_EAX_hex	ENDP

_main	PROC
	push	0
	call	_ExitProcess@4
_main	ENDP
END