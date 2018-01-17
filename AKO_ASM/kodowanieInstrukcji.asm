.686
.model flat
public _main
.data
dane dword ?
.code
_main PROC
	nop
	etyk: add eax, 2
	je etyk
	nop
	ret
_main ENDP
END	