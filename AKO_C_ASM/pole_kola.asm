; void pole_kola(float * pr);
.686
.model flat
public _pole_kola
.code
_pole_kola	PROC
	push	ebp
	mov		ebp, esp
	pusha	
	mov		esi, [ebp+8]
	fld		dword PTR[esi]
	fmul	st(0), st(0)
	fldpi
	fmul	st(0), st(1)
	fst		dword PTR[esi]
	popa
	pop		ebp
	ret
_pole_kola	ENDP
END