; wczytywanie i wyswietlanie tekstu wielkimi literami w MessageBoxW
; for CP 852
.686
.model	flat

extern	_ExitProcess@4	:	PROC
extern	__write			:	PROC
extern	__read			:	PROC
extern	_MessageBoxW@16	:	PROC
public _main

.data
caption		word	'W','i','e','l','k','i','e',' ','l','i','t','e','r','y',0
cmd_txt		byte	'Prosz',0A9H,' napisa',86H,' jaki',98H,' tekst'
			byte	' i nacisn',0A5H,86H,' Enter', 10
end_cmd_txt	byte	?

storage		byte	80 dup (?)
storage_uni	word	80 dup (0)
chars_count	dword	?


.code
_main:
	; print cmd_txt to stdout
	mov		ecx, OFFSET end_cmd_txt - OFFSET cmd_txt	; text length
	push	ecx
	push	OFFSET cmd_txt	; cmd_txt mem addr
	push	1	; stdout
	call	__write
	add		esp, 12	; stack cleanup

	; read row from stdio
	push	80	; max chars number
	push	OFFSET storage
	push	0	; stdin
	call	__read
	add		esp, 12	; stack cleanup

	mov		chars_count, eax ; __read puts in eax read chars count
	mov		ecx, eax
	mov		ebx, 0 ; index
	mov		eax, 0 ; storage_uni index
	lp1:
		mov		edx, 0h;
		mov		dl, storage[ebx]

		; check polish small chars
		cmp		dl, 0A5H	; ¹
		je		ch_a
		cmp		dl, 086H		; æ
		je		ch_c
		cmp		dl, 0A9H		; ê
		je		ch_e
		cmp		dl, 088H		; ³
		je		ch_l
		cmp		dl, 0E4H		; ñ
		je		ch_n
		cmp		dl, 0A2H		; ó
		je		ch_o
		cmp		dl, 098H		; œ
		je		ch_s
		cmp		dl, 0ABH		; Ÿ
		je		ch_x
		cmp		dl, 0BEH		; ¿
		je		ch_z

		; check polish big chars
		cmp		dl, 0A5H		; ¹
		je		ch_a
		cmp		dl, 086H		; æ
		je		ch_c
		cmp		dl, 0A9H		; ê
		je		ch_e
		cmp		dl, 088H		; ³
		je		ch_l
		cmp		dl, 0E3H		; ñ
		je		ch_n
		cmp		dl, 0E0H		; ó
		je		ch_o
		cmp		dl, 097H		; œ
		je		ch_s
		cmp		dl, 08DH		; Ÿ
		je		ch_x
		cmp		dl, 0BDH		; ¿
		je		ch_z

		; check regular chars
		cmp		dl, 'a'
		jb		continue	; omit if below 'a'
		cmp		dl, 'z'
		ja		continue	; omit if above 'z'
		jmp		ch_20h

		continue:
			mov		storage_uni[2*ebx], dx
			;mov		storage_uni[2*ebx+1], 0h
			;add		ebx, 2
			inc		ebx
			dec		ecx
			jnz		lp1
	
	; show wnd with changed txt
	mov		storage_uni[2*ebx], 0h	; string null terminator
	; mov		storage_uni[2*ebx+1], 0h	
	push	0	; MB_OK
	push	OFFSET caption
	push	OFFSET storage_uni
	push	0	; hWND
	call	_MessageBoxW@16

	; exit program
	push	0
	call	_ExitProcess@4

ch_20h:
	sub		dx, 20h
	jmp		continue
ch_a:
	mov		dx, 0105H
	jmp		continue
ch_c:
	mov		dx, 0107h
	jmp		continue
ch_e:
	mov		dx, 0119h
	jmp		continue
ch_l:
	mov		dx, 0142h
	jmp		continue
ch_n:
	mov		dx, 0144h
	jmp		continue
ch_o:
	mov		dx, 00F3h
	jmp		continue
ch_s:
	mov		dx, 015Bh
	jmp		continue
ch_x:
	mov		dx, 017Ah
	jmp		continue
ch_z:
	mov		dx, 017Ch
	jmp		continue
END