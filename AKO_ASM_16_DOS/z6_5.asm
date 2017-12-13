; linie.asm
.386
instructions	SEGMENT	use16
				ASSUME	cs:instructions

	line	PROC
		push	ax
		push	bx
		push	es
		push	dx
		; ----------------------------------------------
		mov		eax, 0A000H		; video memory address for 13H mode
		mov		es, ax
		mov		dx, cs:flaga_przekatnej
		cmp		dx, 0
		je		diagonal1
		cmp		dx, 1
		je		diagonal2
		cmp		dx, 2
		je		finish
		diagonal1:
		mov		bx, cs:pixel_address
		mov		al, cs:color
		mov		dx, cs:licznik
		test	dx,dx
		jp		even_diagonal1
		mov		es:[bx], al	
		add		bx, 321
		jmp		next_diagonal1
		even_diagonal1:
		mov		es:[bx], al
		mov		es:[bx+1], al
		add		bx, 322
		next_diagonal1:
		inc		dx
		mov		cs:licznik, dx
		cmp		bx, 319*200
		jb		diagonal1_continue
		mov		bx, 308
		mov		dx, 1
		mov		cs:flaga_przekatnej, dx
		diagonal1_continue:
		mov		cs:pixel_address, bx
		jmp finish
		diagonal2:
		mov		bx, cs:pixel_address
		mov		al, cs:color
		mov		dx, cs:licznik
		test	dx,dx
		jp		even_diagonal2
		mov		es:[bx], al	
		add		bx, 319
		jmp		next_diagonal2
		even_diagonal2:
		mov		es:[bx], al
		mov		es:[bx-1], al
		add		bx, 318
		next_diagonal2:
		inc		dx
		mov		cs:licznik, dx
		cmp		bx, 319*199
		jb		diagonal2_continue
		mov		dx, 2
		mov		cs:flaga_przekatnej, dx
		diagonal2_continue:
		mov		cs:pixel_address, bx
		finish:
		; ----------------------------------------------
		pop		dx
		pop		es
		pop		bx
		pop		ax
		jmp		dword PTR cs:vector8
	
		color			db	1
		pixel_address	dw	10
		increase		dw	0
		vector8			dd	?
		licznik			dw	0
		flaga_przekatnej db 0
	line	ENDP

	main:
		mov		ah, 0
		mov		al, 13H
		int		10H
		mov		bx, 0
		mov		es, bx
		mov		eax, es:[32]
		mov		cs:vector8, eax
		mov		ax, SEG line
		mov		bx, OFFSET line
		cli
		mov		es:[32], bx
		mov		es:[34], ax
		sti
		waiting:
		mov		ah, 1
		int		16H
		jz		waiting
		mov		ah, 0
		mov		al, 3H
		int		10H
		mov		eax, cs:vector8
		mov		es:[32], eax
		mov		ax, 4C00H
		int		21H
instructions	ENDS
my_stack	SEGMENT	stack
	db	256 dup (?)
my_stack	ENDS
END	main
