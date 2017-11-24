.686
.model	flat
public _max4
.code
_max4	PROC
	push	ebp
	mov		ebp, esp
	add		ebp, 4
	push	ecx
	push	ebx

	mov		ecx, 3
	mov		eax, [ebp+16]
	lp1:
		cmp		eax, [ebp + 4 * ecx]
		jge		continue
		mov		eax, [ebp + 4 * ecx]
		continue: loop	lp1
			
	pop		ebx
	pop		ecx
	pop		ebp
	ret
_max4	ENDP
END