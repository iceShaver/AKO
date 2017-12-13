; keyboard interrupt
.386
rozkazy	SEGMENT use16
		ASSUME	CS:rozkazy

	key_int_handle	PROC
		push	ax
		push	bx
		; ----------------------------------------
		in		al, 60H
		call	print_AL
		; ----------------------------------------
		pop		bx
		pop		ax
		jmp		dword PTR cs:wektor9
		wektor9	dd	?
	key_int_handle	ENDP


	print_AL	PROC
		push	ax
		push	cx
		push	dx
		push	bx
		push	es
		; ----------------------------------------
		mov		bx, 0B800H
		mov		es, bx
		mov		bx, 0
		mov		cl, 10
		mov		ah, 0
		div		cl
		add		ah, 30H
		mov		es:[bx+4], ah	; jednosci
		mov		ah, 0
		div		cl
		add		ah, 30H
		mov		es:[bx+2], ah	; dziesiatki
		add		al, 30H
		mov		es:[bx+0], al	; setki
		mov		al, 00001111B
		mov		es:[bx+1], al
		mov		es:[bx+3], al
		mov		es:[bx+5], al
		; ----------------------------------------
		pop		es
		pop		bx
		pop		dx
		pop		cx
		pop		ax
		ret
	print_AL	ENDP

	main:
		mov		al, 0
		mov		ah, 5
		int		10

		mov		ax, 0
		mov		ds, ax
		
		mov		eax, ds:[36]
		mov		cs:wektor9, eax
		
		mov		ax, SEG key_int_handle
		mov		bx, OFFSET key_int_handle
		cli
		mov		ds:[36], bx	; OFFSET
		mov		ds:[38], ax	; SEGMENT
		sti
		waiting_for_key:
		mov		ah, 1
		int		16H
		jz		waiting_for_key
		mov		ah, 0
		int		16H
		cmp		ax, 2D78H
		jne		waiting_for_key
		
		mov		eax, cs:wektor9
		cli
		mov		ds:[36], eax
		sti
		mov		al, 0
		mov		ah, 4CH
		int		21H
rozkazy ENDS
	nasz_stos	SEGMENT stack
		db 128 dup(?)
	nasz_stos	ENDS
END main