.686
.xmm
.model	flat
public	_add_3_arrays
.data
align	16
arr_a	dword	1.0, 2.0, 3.0, 4.0
arr_b	dword	2.0, 3.0, 4.0, 5.0
number	byte	1
align	16
arr_c	dword	3.0, 4.0, 5.0, 6.0
.code
_add_3_arrays proc
	push	ebp
	mov		ebp, esp
	push	eax
	; ---------------------------
	mov		eax, [ebp+8]

	movaps	xmm2, arr_a
	movaps	xmm3, arr_b
	movaps	xmm4, arr_c
	addps	xmm2, xmm3
	addps	xmm2, xmm4
	movups	[eax], xmm2
	; ---------------------------
	pop		eax
	pop		ebp
	ret
_add_3_arrays endp
end