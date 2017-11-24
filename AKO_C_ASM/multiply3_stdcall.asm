.686
.model	flat
public _multiply3
.code
_multiply3 PROC stdcall, arg1:dword, arg2:dword, arg3:dword
	push	edx
	mov		ecx, 0
	mov		edx, 0
	mov		eax, arg1
	imul	arg2
	imul	arg3
	pop		edx
	ret
_multiply3 endp
end