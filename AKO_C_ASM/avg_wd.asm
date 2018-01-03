; float avg_wd(int n, void *tablica, void *wagi);
.686
.model flat
public	_avg_wd
.code
_avg_wd	PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	push	edi
	mov		ecx, [ebp+8]
	mov		esi, [ebp+12]
	mov		edi, [ebp+16]
	fldz							; st0=nom
	fldz							; st0=denom, st1=nom
	lp1:
		fld		dword PTR[edi]		; st0=wag, st1=denom, st2=nom
		fld		dword PTR[esi]		; st0=el, st1=wag, st2=denom, st3=nom
		fmul	st(0), st(1)		; el_wag=el*wag
		faddp	st(3), st(0)		; nom=nom+el_wag
									; st0=wag, st1=denom, st2=nom
		faddp	st(1), st(0)		; denom=denom+wag
									; st1=denom, st2=nom
		add		esi, 4
		add		edi, 4
		loop	lp1
	fdivp	st(1), st(0)
	pop		edi
	pop		esi
	pop		ebx
	pop		ebp
	ret
_avg_wd	ENDP
END