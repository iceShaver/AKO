.686
.model flat
extern	_ExitProcess@4	:	PROC
extern	__write			:	PROC
.data
txt		byte	'Hello world!',10
end_txt	byte	?
.code
_main PROC	
	mov		ebx, OFFSET end_txt - OFFSET txt
	push	ebx
	push	OFFSET txt
	push	1	; stdout
	call	__write
	add		esp, 12	; stack cleanup

	push	0
	call	_ExitProcess@4
_main ENDP
END