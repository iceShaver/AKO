.686
.model flat
extern	_ExitProcess@4	:	PROC
extern	__write			:	PROC
.data
		byte	0A0H
		byte	0FFH
		byte	043H
d_658h	byte	000H
		byte	020H
		byte	07FH
		byte	0C3H
data_out dword ?
.code
_main PROC	
	fld		dword ptr d_658h
	fst		dword ptr data_out
	push	0
	call	_ExitProcess@4
_main ENDP
END