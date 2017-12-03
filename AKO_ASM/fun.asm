.686
.model flat
extern _ExitProcess@4	: PROC
extern __write			: PROC
extern _MessageBoxA@16	: PROC
extern _MessageBoxW@16	: PROC
.data
caption		word 'K','o','m','u','n','i','k','a','t',0
bufor		db	50H, 6FH, 0C5H, 82H, 0C4H, 85H, 63H, 7AH, 65H, 6EH, 69H, 65H, 20H			
			db	7AH, 6FH, 73H, 74H, 61H, 0C5H, 82H, 6FH, 20H, 6EH, 61H, 77H, 69H			
			db	0C4H, 85H, 7AH, 61H, 6EH, 65H, 2EH			
			db	0E2H, 91H, 0A4H	; kod znaku '5' w k?-ku (kod 3-bajtowy)
			db	0
wynik		word 256 dup(?)
daty		dword 12 dup(?)
.code
_print_holidays	PROC
	push	ebp
	mov		ebp, esp
	;----------------------------------
	movzx	ecx, cl
	mov		eax, [ebx+ecx-1]
	mov		esi, 0
	mov		edi, 0
	lp1:
		bt		eax, esi
		jnc		continue
		inc		edi
		sub		esp, 4
		mov		edx, esi
		add		edx, 30H
		add		dl, 1
		mov		[esp], dl
		mov		[esp+1], byte PTR '.'
		mov		edx, ecx
		add		edx, 30H
		mov		[esp+2], dl
		mov		[esp+3], byte PTR 0AH
		continue:
			inc		esi
			cmp		esi, 30
			jbe		lp1

		lea		eax, [4*edi]
		push	eax
		lea		eax, [esp+4]
		push	eax
		push	1
		call	__write
		lea		eax, [edi*4]
		add		eax, 12
		add		esp, eax
	;----------------------------------
	pop		ebp
	ret
_print_holidays	ENDP


_utf8_2_utf16_bytes_count	PROC
	mov		ecx, 0
	lea		esi, bufor
	lp1:
		mov		al, [esi]
		cmp		al, 7FH
		jbe		one_byte
		cmp		al, 0DFh
		jbe		two_bytes
		jmp		three_bytes
		one_byte:
			inc		esi
			jmp		continue
		two_bytes:
			add		esi, 2
			jmp		continue
		three_bytes:
			add		esi, 3
			jmp		continue
		continue:
			add		ecx, 2
			cmp		al, 0
			jne		lp1
_utf8_2_utf16_bytes_count	ENDP

_utf8_2_utf16 PROC
	push	ebp
	mov		ebp, esp
	push	eax
	push	ebx
	push	ecx
	push	esi
	push	edi
	;--------------------------------------
	mov		esi, [ebp + 8]	; source ptr
	mov		edi, [ebp + 12] ; destination ptr
	mov		ecx, [ebp + 16]	; bytes count
	add		ecx, esi		; end source ptr

	lp1:
		mov		eax, 0
		mov		al, [esi]
		cmp		al, 7FH
		jbe		one_byte
		cmp		al, 0DFH
		jbe		two_bytes
		jmp		three_bytes

	
		one_byte:
			inc		esi
			jmp		continue


		two_bytes:
			shl		ax, 8+2
			shr		ax, 2		; ax = 000xxxxx ????????
			mov		al, [esi+1]	; ax = 000xxxxx 10xxxxxx
			shl		al, 2
			shr		ax, 2		; ax = 00000xxxxxxxxxxx
			add		esi, 2
			jmp		continue


		three_bytes:
			shl		ax, 8+3
			shr		ax, 3		; ax = 0000xxxx ????????
			mov		al, [esi+1]	; ax = 0000xxxx 10xxxxxx
			shl		al, 2		; ax = 0000xxxx xxxxxx00
			shr		ax, 2		; ax = 000000xx xxxxxxxx
			shl		ax, 6		; ax = xxxxxxxx xx000000
			mov		bl, [esi+2]
			shl		bl, 2
			shr		bl, 2		; bl = 00xxxxxx
			or		al, bl		; ax = xxxxxxxx xxxxxxxx
			add		esi, 3
			jmp		continue

		continue:
			mov		[edi], ax
			add		edi, 2
			cmp		esi, ecx
			jb		lp1
	mov		[edi], dword PTR 0
	;--------------------------------------
	pop		edi
	pop		esi
	pop		ecx
	pop		ebx
	pop		eax
	pop		ebp
	ret
_utf8_2_utf16 ENDP

dodaj PROC
	mov		esi, [esp]
	mov		eax, [esi]
	add		eax, [esi+4]
	ret
dodaj ENDP
_main PROC
;--------------------------------------------------
;	mov		ecx, OFFSET wynik - OFFSET bufor
;	push	ecx
;	push	OFFSET wynik
;	push	OFFSET bufor
;	call	_utf8_2_utf16
;	add		esp, 12
;	push	0
;	push	OFFSET caption
;	push	OFFSET wynik
;	push	0
;	call	_MessageBoxW@16
;--------------------------------------------------
	
;call dodaj
;dd	5
;dd	7

	mov eax, 01110000000000000000000000000111b
	mov	daty, eax
	lea ebx, daty
	mov	cl, 1
	call _print_holidays
	push 0
	call	_ExitProcess@4
_main ENDP
END