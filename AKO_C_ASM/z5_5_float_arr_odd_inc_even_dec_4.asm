;void float_arr_odd_inc_even_dec_4(float * arr)
.686
.xmm
.model flat
public	_float_arr_odd_inc_even_dec_4
.data
ones	dword	1.0, 1.0, 1.0, 1.0
.code
_float_arr_odd_inc_even_dec_4 proc
	push		ebp
	mov			ebp, esp
	push		esi
	; ---------------------------------
	mov			esi, [ebp+8]
	movups		xmm0, [esi]
	movups		xmm1, ones
	addsubps	xmm0, xmm1
	movups		[esi], xmm0
	; ---------------------------------
	pop			esi
	pop			ebp
	ret
_float_arr_odd_inc_even_dec_4 endp
end