; linie.asm
.386
instructions	SEGMENT	use16
				ASSUME	cs:instructions

	line	PROC
		push	ax
		push	bx
		push	es
		; ----------------------------------------------
		mov		eax, 0A000H		; video memory address for 13H mode
		mov		es, ax
		mov		bx, cs:pixel_address
		mov		al, cs:color
		mov		es:[bx], al		; color code to video memory
		add		bx, 320			; next row
		cmp		bx, 320*200		; end of line
		jb		line_continue
		next_line:
		add		word PTR cs:increase, 2
		mov		bx, 10
		add		bx, cs:increase
		inc		cs:color
		line_continue:
		mov		cs:pixel_address, bx
		; ----------------------------------------------
		pop		es
		pop		bx
		pop		ax
		jmp		dword PTR cs:vector8
	
		color			db	1
		pixel_address	dw	10
		increase		dw	0
		vector8			dd	?
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
