; float szereg_przemienny(unsigned n);
.686
.model flat
public _szereg_przemienny
.data
two dword 1.0
one		dword 1.0
.code
_szereg_przemienny proc
	push	ebp
	mov		ebp, esp
	push	ecx
	push	edx
	; --------------------------------------------------------
	fld1		; denominator
	fldz		; sum
	mov		ecx, [ebp+8]
	mov		edx, 0 ; counter
	test	ecx, ecx
	jz		finish
	lp1:		; st(0) = sum
		fld1	; st(0) = 1 st(1)=sum
		fdiv	st(0),st(2)	; st(0) = elem st1 = sum st2=denom
		fxch
		bt		edx, 0
		jnc		dodaj
		fsub	st(0), st(1)
		jmp		continue
		dodaj:
		fadd	st(0),st(1)
		continue:	;sum elem, denom
		fxch	; elem sum denom
		fstp	st(0) ; sum denom
		fxch	;denom, sum
		fmul	two
	
		inc		edx
		loop lp1
	finish:
	; --------------------------------------------------------
	pop		edx
	pop		ecx
	pop		ebp
	ret
_szereg_przemienny endp
end