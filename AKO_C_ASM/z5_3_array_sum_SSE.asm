; float array_sum_SSE(char * a_src, char * b_src, char * dest, unsigned count);

.686
.model flat
public	_array_sum_SSE
.data	

.code
_array_sum_SSE proc
	push	ebp
	mov		ebp, esp
	; -----------------------------------------

	; -----------------------------------------
	pop		ebp
	ret
_array_sum_SSE endp
end