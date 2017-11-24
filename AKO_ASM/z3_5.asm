.686
.model	flat
extern	_ExitProcess@4	:	PROC
extern	__write			:	PROC
extern	__read			:	PROC
public	_main
.data
hex_decoder	byte	'0123456789ABCDEF'
.code
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
	mov		eax, 0A20H
	call	print_EAX_hex	
	push	0
	call	_ExitProcess@4
_main	ENDP
END