.686
.model flat
extern	_ExitProcess@4	:	PROC
.data
x	dword	5

.code
_main PROC
	finit
	fild	x	; load x onto stack
	fldl2e		; log_2 e
	fmulp		st(1), st(0)	; x*log_2 e
	fst			st(1)			; copy st(0) to st(1)
	frndint
	fsub	st(1), st(0)	; calc fractional part
	fxch		; st(0) - fractional part, st(1) - int part
	f2xm1		; calc val of exp function for fract part
	fld1
	faddp	st(1), st(0)
	fscale	; mul 2^int part
	fstp	st(1)
	push	0
	call _ExitProcess@4
_main ENDP
END

