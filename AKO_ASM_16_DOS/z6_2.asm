; gwiazdki.asm
; wyœwietlanie * w takt przerwañ zegarowych
; x- zakoñczenie
.386
rozkazy SEGMENT	use16
		ASSUME	CS:rozkazy

	clock_handle	PROC
		push	ax
		push	bx
		push	es
		; --------------------------------------
		dec		cs:licznik_obiegow_petli
		jnz		finish
		mov		ax, 0B800H	; adres pamiêci ekranu / 16
		mov		es, ax
		mov		bx, cs:licznik ; zmienna licznik zawiera adres bie¿¹cy w pamiêci ekranu
		
		mov		byte PTR es:[bx], '*'
		mov		byte PTR es:[bx+1], 00000111B ; white on black
	
		add		bx, 2
		cmp		bx, 4000
		jb		continue
		mov		bx, 0	; ca³y ekran zpisany -> zeruj adres bie¿¹cy
		continue:
		mov		cs:licznik, bx	; bie¿¹cy adres do zmiennej licznik
		mov		cs:licznik_obiegow_petli, 18
		finish:
		; --------------------------------------

		pop		es
		pop		bx
		pop		ax
		jmp		dword PTR cs:wektor8
		licznik		dw	320	 ; wyœwietlanie od drugiego wiersza
		wektor8		dd	?
		licznik_obiegow_petli db 18	; 1000/55ms
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
	
		; wpisanie nowej procedury obs³ugi przerwania
		mov		ax, SEG clock_handle	; czêœæ segmentowa adresu
		mov		bx, OFFSET clock_handle	; offset adresu
		cli
		mov		ds:[32], bx
		mov		ds:[34], ax
		sti
	
	waiting:
		mov		ah, 1
		int	16H
		jz		waiting
	
		; odczytanie kodu klawisza
		mov		ah, 0
		int		16H
		cmp		al, 'x'
		jne		waiting	
	
		; odtworzenie oryginalnej procedury obs³ugi przerwania zegarowego
		mov		eax, cs:wektor8
		cli
		mov		ds:[32], eax
		sti
	
		mov		al, 0
		mov		ah, 4CH
		int		21H

rozkazy ENDS

nasz_stos	SEGMENT stack
	db	128 dup (?)
nasz_stos	ENDS

END	start