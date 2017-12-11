; float szereg_przemienny(unsigned n);
.686
.model flat
public _szereg_przemienny
.data
two		dword 2.0
one		dword 1.0
.code
_szereg_przemienny proc
	push	ebp
	mov		ebp, esp
	push	ecx
	push	edx
	; --------------------------------------------------------
	finit
	fldz		; sum
	fld1		; denominator
	mov		ecx, [ebp+8]
	mov		edx, 0		; counter for parity test
	test	ecx, ecx
	jz		finish
	lp1:		; st0=denominator, st1=sum
		fld1	; st0=element, st1=denominator, st2=sum 
		fdiv	st(0), st(1)
		bt		edx, 0
		jc		minus
		faddp	st(2), st(0)
		jmp		continue
		minus:
		fsubp	st(2), st(0)
		continue:	; st0=denominator, st1=sum
		fmul	two
		inc		edx
		loop lp1
	finish:
	fxch
	; --------------------------------------------------------
	pop		edx
	pop		ecx
	pop		ebp
	ret
_szereg_przemienny endp
end