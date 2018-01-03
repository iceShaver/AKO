.686
.model flat
public _liczba_procesorow
extern _GetSystemInfo@4	:	PROC
.data
SYSTEM_INFO_STRUCT_SIZE	equ	36
.code
_liczba_procesorow PROC
	push	ebp
	mov		ebp, esp
	sub		esp, SYSTEM_INFO_STRUCT_SIZE
	push	esp
	call	_GetSystemInfo@4
	mov		eax, [esp+20]
	add		esp, SYSTEM_INFO_STRUCT_SIZE
	pop		ebp
	ret
_liczba_procesorow ENDP
END