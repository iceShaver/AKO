; void szyfruj(char * tekst)
.686
.model flat
public _szyfruj
.data
prev_number  DWORD 0
.code
_szyfruj PROC
	push	ebp
	mov		ebp, esp
	push	esi
	push	ebx
	push	eax
	; -------------------------------------
	call	reset_get_next_number
	mov		esi, [ebp+8]
	mov		ebx, 0
	lp1:
		mov		bl, [esi]
		cmp		bl, 0
		je		break
		call	get_next_number
		xor		bl, al
		mov		[esi], bl
		inc		esi
		jmp		lp1
	break:
		
	; -------------------------------------
	pop		eax
	pop		ebx
	pop		esi
	pop		ebp
	ret
_szyfruj ENDP

get_next_number PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	push	ecx
	; -------------------------------------
	cmp		prev_number, 0
	jne		next
	mov		eax, 52525252H
	mov		prev_number, eax
	jmp		exit
	next:
	mov		ecx, prev_number
	mov		eax, ecx
	mov		ebx, eax
	shr		eax, 30
	shr		ebx, 31
	xor		eax, ebx	; a
	mov		ebx, ecx
	shl		ebx, 1
	bt		eax, 0
	adc		ebx, 0
	mov		eax, ebx
	mov		prev_number, eax
	exit:
	; -------------------------------------
	pop		ecx
	pop		ebx
	pop		ebp
	ret
get_next_number ENDP

reset_get_next_number PROC
	mov		prev_number, 0
	ret
reset_get_next_number ENDP

END