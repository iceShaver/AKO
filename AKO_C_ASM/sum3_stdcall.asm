.686
.model flat
public _sum3
.code
_sum3 proc stdcall, arg1:dword, arg2:dword, arg3:dword
	mov		eax, 0
	add		eax, arg1
	add		eax, arg2
	add		eax, arg3
	ret
_sum3 endp
end