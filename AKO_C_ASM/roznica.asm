; int roznica(int * odjemna, int ** odjemnik);
.686
.model flat
public _roznica
.code
_roznica PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	; ------------------------------------------------
	mov		eax, [ebp+8]
	mov		eax, [eax]
	mov		ebx, [ebp+12]
	mov		ebx, [ebx]
	mov		ebx, [ebx]
	sub		eax, ebx
	; ------------------------------------------------
	pop		ebx
	pop		ebp
	ret
_roznica ENDP
END