.686
.model	flat
extern	__write			:	PROC
extern	_ExitProcess@4	:	PROC
public	_main
.data
chars		byte	12 dup (?)
.code
print_EAX	PROC
	pusha
	mov		esi, 10		; chars index
	mov		ebx, 10		; divisor (dzielnik)

	convert:
		mov		edx, 0	; put 0 in high part of divident (dzielna)
		div		ebx
		add		dl, 30H	; to ASCII
		mov		chars[esi], dl
		dec		esi
		cmp		eax, 0
		jne		convert

	fill:
		or		esi, esi
		jz		print						; if ESI==0
		mov		byte PTR chars[esi], 20H	; space
		dec		esi
		jmp		fill

	print:
		mov		byte PTR chars[0], 10
		mov		byte PTR chars[11], 10
		push	dword PTR 12
		push	dword PTR OFFSET chars
		push	dword PTR 1
		call	__write
		add		esp, 12
	popa
	ret
print_EAX	ENDP
	

_main	PROC
	mov		eax, 1	; number
	mov		ecx, 50	; numbers count
	mov		edx, 1	; diff
	lp1:
		call	print_EAX	
		add		eax, edx
		inc		edx
		loop lp1
	push	dword PTR 0
	call	_ExitProcess@4
_main	ENDP
END