; float srednia_harm(float*arr, unsigned n);
.686
.model	flat
public	_srednia_harm
.data	
one		dword +1.0
.code
_srednia_harm	proc
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
	fldz						; load 0.0 as initial sum of general denominator
	lp1:
		fld		dword PTR[ebx+esi] ; read next value
		fld		one				; small numerator
		fdiv	st(0), st(1)	; summand of general denominator: st(0)=1, st(1)=value
		faddp	st(2), st(0)	; sum fractions
		fstp	st(0)			; pop
		add		esi, 4
		loop	lp1
	fild	dword PTR[ebp+12]
	fdiv	st(0), st(1)
	; --------------------------------------------------------------------------------
	pop		esi
	pop		ebx
	pop		ecx
	pop		ebp
	ret
_srednia_harm	endp
end