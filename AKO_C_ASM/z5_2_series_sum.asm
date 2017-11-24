; float series_sum(float x, unsigned n);
.686
.model flat
public _series_sum
.data
count	dword	20

counter	dword	2
one		dword	+1.0
x		dword	?
.code
_series_sum proc
	push	ebp
	mov		ebp, esp
	push	ecx
	; --------------------------------------------------------
	finit
	fld		one			; sum
	fld		one			; denominator
	mov		ecx, [ebp+8]
	mov		x, ecx
	fld		dword ptr[ebp+8]	; x
	mov			ecx, count		; count of terms
	dec			ecx				
	lp1:				; st(0)=x, st(1)=denominator, st(2)=sum
		fld		st(0)
		fdiv	st(0), st(2)
		faddp	st(3), st(0)
		fmul	x			; next nominator
		fxch
		fimul	counter		; next denominator
		fxch	
		inc		counter
		loop	lp1
	fstp	st(0)
	fstp	st(0)

	; --------------------------------------------------------
	pop		ecx
	pop		ebp
	ret
_series_sum endp
end