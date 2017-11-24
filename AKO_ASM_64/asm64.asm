extern	_write		:	PROC
extern	ExitProcess	:	PROC
public	main
.data
txt		byte	'Nazywam si',0A9H,' Kamil Kr',0A2H,'likowski',10
		byte	'M',0A2H,'j pierwszy 64-bitowy program asemblerowy '
		byte	'dzia',88H,'a ju',0BEH,' poprawnie!', 10
txt_end	byte	?
.code
main PROC
	mov		rcx, 1	; stdout
	mov		rdx, offset txt
	mov		r8, offset txt_end - offset txt
	sub 	rsp, 40 ; stack preparation for _write
	call	_write
	add		rsp, 40
	sub		rsp, 8
	mov		rcx, 0
	call	ExitProcess
main ENDP
END