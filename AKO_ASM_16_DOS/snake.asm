; gwiazdki.asm
; wy�wietlanie * w takt przerwa� zegarowych
; x- zako�czenie
.386
rozkazy SEGMENT	use16
		ASSUME	CS:rozkazy

	key_int_handle	PROC
		push	ax
		push	bx
		; ----------------------------------------
		in		al, 60H
	;		call	print_AL
		;mov	cs:key, al
		cmp		al, 72 ; up
		je		ok	
		cmp		al, 75 ; left
		je		ok
		cmp		al, 80 ; down
		je		ok
		cmp		al, 77 ; right
		je		ok
		jmp		no_ok
		ok:
		mov		cs:key, al
		no_ok:
		; ----------------------------------------
		pop		bx
		pop		ax
		jmp		dword PTR cs:wektor9
		wektor9	dd	?
		key		db	77
	key_int_handle	ENDP

	clock_handle	PROC
		push	ax
		push	bx
		push	es
		; --------------------------------------
		mov		ax, 0B800H	; adres pami�ci ekranu / 16
		mov		es, ax
		mov		bx, cs:licznik ; zmienna licznik zawiera adres bie��cy w pami�ci ekranu
		
		mov		byte PTR es:[bx], '*'
		mov		byte PTR es:[bx+1], 00000111B ; white on black
		
		mov		al, cs:key
		cmp		al, 72
		je		up	
		cmp		al, 75
		je		left
		cmp		al, 80
		je		down
		cmp		al, 77
		je		right
		jmp		key_continue
		up:
		sub		bx, 80*2
		jmp		key_continue
		left:
		sub		bx, 2
		jmp		key_continue
		down:
		add		bx, 80*2
		jmp		key_continue
		right:
		add		bx, 2
		jmp		key_continue

		key_continue:
		;add		bx, 2
		;cmp		bx, 4000
		;jb		continue
		;mov		bx, 0	; ca�y ekran zpisany -> zeruj adres bie��cy
		;continue:
		mov		cs:licznik, bx	; bie��cy adres do zmiennej licznik
		; --------------------------------------
		pop		es
		pop		bx
		pop		ax
		jmp		dword PTR cs:wektor8
		licznik		dw	320	 ; wy�wietlanie od drugiego wiersza
		wektor8		dd	?
	clock_handle	ENDP	
	
	
	; main
	start:
		mov		al, 0	; ustawienie strony 0 dla trybu tekstowego
		mov		ah, 5
		int		10
	
		mov		ax, 0
		mov		ds, ax	; zerowanie DS
	
		; zapis starego wektora8 do zmiennej wektor8(4 bajty)
		mov		eax, ds:[32]	; 0*16 + 32
		mov		cs:wektor8, eax
		mov		eax, ds:[36]
		mov		cs:wektor9, eax
	
		; wpisanie nowej procedury obs�ugi przerwania
		mov		ax, SEG clock_handle	; cz�� segmentowa adresu
		mov		bx, OFFSET clock_handle	; offset adresu
		mov		cx, SEG key_int_handle
		mov		dx, OFFSET key_int_handle
		cli
		mov		ds:[32], bx
		mov		ds:[34], ax
		mov		ds:[36], dx
		mov		ds:[38], cx
		sti
	
	waiting:
		mov		ah, 1
		jmp		waiting ; TODO: exit!!!
	
		mov		eax, cs:wektor8
		mov		ebx, cs:wektor9
		cli
		mov		ds:[32], eax
		mov		ds:[36], ebx
		sti
	
		mov		al, 0
		mov		ah, 4CH
		int		21H

rozkazy ENDS

nasz_stos	SEGMENT stack
	db	128 dup (?)
nasz_stos	ENDS

END	start