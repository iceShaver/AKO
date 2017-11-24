.686
.model flat
extern	_ExitProcess@4	:	PROC
extern	_MessageBoxA@16	:	PROC
.data
;2x^2-x-15=0
wsp_a	dword	+2.0
wsp_b	dword	-1.0
wsp_c	dword	-15.0
dwa		dword	2.0
cztery	dword	4.0
x1		dword	?
x2		dword	?
d_err_c	byte	'Delta',0
d_err_t	byte	'Delta ujemna',0

.code
_main PROC
	finit
	fld		wsp_a
	fld		wsp_b
	fst		st(2)			; ST(0)=b, ST(1)=a, ST(2)=b
	fmul	st(0), st(0)
	fld		cztery			; ST(0)=4.0, ST(1)=b^2, ST(2)=a, ST(3)=b
	fmul	st(0), st(2)	; 4a
	fmul	wsp_c			; 4ac
	fsubp	st(1), st(0)	; b2-4ac	ST(0)=b2-4ac, ST(1)=a, ST(2)=b
	fldz					; ST(0)=0, ST(1)=b2-4ac, ST(2)=a, ST(3)=b
	fcomi	st(0), st(1)
	fstp	st(0)
	ja		delta_ujemna	; ST(0)=b2-4ac, ST(1)=a, ST(2)=b
	fxch	st(1)			; swap(ST(0), ST(1))	ST(0)=a, ST(1)=b2-4ac, ST(2)=b
	fadd	st(0), st(0)	; 2*a
	fstp	st(3)			; ST(0)=b2-4ac, ST(1)=b, ST(2)=2*a
	fsqrt
	fst		st(3)			; ST(0)=sqrt(b2-4ac), ST(1)=b, ST(2)=2a, ST(3)=ST(0)
	fchs
	fsub	st(0), st(1)	; -b-sqrt(d)
	fdiv	st(0), st(2)	; x1
	fstp	x1				; ST(0)=b, ST(1)=2a, ST(2)=sqrt(b2-4ac)
	fchs
	fadd	st(0), st(2)
	fdiv	st(0), st(1)
	fstp	x2

	fstp	st(0)			; oczyszczenie stosu
	fstp	st(0)

	push	0
	call	_ExitProcess@4
	delta_ujemna:
		push	0
		push	OFFSET d_err_t
		push	OFFSET d_err_c
		push	0
		call	_MessageBoxA@16
		push	0
		call	_ExitProcess@4

_main ENDP
END

