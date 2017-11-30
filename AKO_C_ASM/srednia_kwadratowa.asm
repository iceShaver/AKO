; float srednia_kwadratowa(float * arr, unsigned size);;
.686
.model	flat
public	_srednia_kwadratowa
.data	
one		dword +1.0
.code
_srednia_kwadratowa	proc
	push	ebp
	mov		ebp, esp
	push	ecx
	push	ebx
	push	esi
	; -------------------------------------------------------------------------------
	finit	
	mov		ebx, [ebp+8]		; array address
	mov		ecx, [ebp+12]		; count of numbers
	mov		esi, 0				; array index
	fldz						; load 0.0 as initial sum of general nominator
	lp1:
		fld		dword PTR[ebx+esi] ; read next value
		fmul	st(0), st(0)		; square
		fadd	st(1), st(0)		; nominator sum w st(1)
		fstp	st(0)
		add		esi, 4
		loop	lp1
	fild	dword PTR[ebp+12]
	fxch
	fdiv	st(0),st(1)	; div nominator / n
	fsqrt
	; --------------------------------------------------------------------------------
	pop		esi
	pop		ebx
	pop		ecx
	pop		ebp
	ret
_srednia_kwadratowa	endp
end