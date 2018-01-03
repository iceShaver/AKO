; char * komunikat (char * tekst);
.686
.model flat
extern _malloc : proc
public _komunikat
.data 
txt			byte	'Blad.',0
txt_len		equ		$ - txt
.code
_komunikat proc
	push	ebp
	mov		ebp, esp
	push	edi
	push	esi
	push	ecx
	push	edx
	push	ebx
	; ----------------------------------------
	mov		esi, [ebp + 8]	; src arr ptr in esi
	mov		ecx, esi
	; calc str len
	lp1:
		mov		al, [ecx]
		cmp		al, 0
		je		lp1_break
		lp1_continue:
		inc		ecx
		jmp		lp1
	lp1_break:
	sub		ecx, esi
	; malloc 
	add		ecx, txt_len	; dest arr len in ecx
	push	ecx
	call	_malloc
	pop		ecx
	mov		edi, eax
	mov		edx, edi			; dest arr ptr in edi
	; copy src arr
	mov		al, [esi]
	lp2:
		cmp		al, 0
		je		lp2_break
		mov		[edi], al
		inc		esi
		inc		edi
		mov		al, [esi]
		jmp		lp2
	lp2_break:
	; copy Blad at the end
	mov		ecx, txt_len
	mov		esi, 0
	lp3:
		mov		al, txt[esi]
		mov		[edi], al
		inc		edi
		inc		esi
		loop	lp3
	mov		eax, edx
		
	; ----------------------------------------
	pop		ebx
	pop		edx
	pop		ecx
	pop		esi
	pop		edi
	pop		ebp
	ret	
_komunikat endp
end