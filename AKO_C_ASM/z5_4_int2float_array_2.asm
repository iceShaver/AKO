;void int2float_array(int*src, float*dest)
.686
.xmm
.model flat
public _int2float_array
.code
_int2float_array proc
	push	ebp
	mov		ebp, esp
	push	esi
	push	edi
	;-------------------------
	mov		esi, [ebp+8]
	mov		edi, [ebp+12]
	cvtpi2ps xmm5, qword PTR[esi]
	movups	[edi], xmm5
	;-------------------------
	pop		edi
	pop		esi
	pop		ebp
	ret
_int2float_array endp
end
