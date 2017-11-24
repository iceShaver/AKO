; wczytywanie i wyswietlanie tekstu wielkimi literami
; for CP 852
.686
.model	flat

extern	_ExitProcess@4	:	PROC
extern	__write			:	PROC
extern	__read			:	PROC
public _main

.data
cmd_txt		byte	'Prosz',0A9H,' napisa',86H,' jaki',98H,' tekst'
			byte	' i nacisn',0A5H,86H,' Enter', 10
end_cmd_txt	byte	?

storage		byte	80 dup (?)
chars_count	dword	?


.code
_main	PROC
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


	; change chars
	mov		chars_count, eax
	mov		ecx, eax
	mov		ebx, 0 ; index
	lp1:
		mov		dl, storage[ebx]

		; check polish chars
		cmp		dl, 0A5H	; ¹
		je		ch_a
		cmp		dl, 86H		; æ
		je		ch_c
		cmp		dl, 0A9H	; ê
		je		ch_e
		cmp		dl, 88H		; ³
		je		ch_l
		cmp		dl, 0E4H	; ñ
		je		ch_n
		cmp		dl, 0A2H	; ó
		je		ch_o
		cmp		dl, 98H		; œ
		je		ch_s
		cmp		dl, 0ABH		; Ÿ
		je		ch_x
		cmp		dl, 0BEH	; ¿
		je		ch_z

		; check regular chars
		cmp		dl, 'a'
		jb		continue	; omit if below 'a'
		cmp		dl, 'z'
		ja		continue	; omit if above 'z'
		jmp		ch_sub_20h

		continue:
			inc		ebx
			loop	lp1
	
	; print changed txt to stdout
	push	chars_count
	push	OFFSET storage
	push	1	; stdout
	call	__write
	add		esp, 12 ; stack cleanup

	; exit program
	push	0
	call	_ExitProcess@4

ch_sub_20h:
	sub		dl, 20h
	mov		storage[ebx], dl
	jmp		continue
ch_a:
	mov		storage[ebx], 0A4H
	jmp		continue
ch_c:
	mov		storage[ebx], 8FH
	jmp		continue
ch_e:
	mov		storage[ebx], 0A8H
	jmp		continue
ch_l:
	mov		storage[ebx], 9DH
	jmp		continue
ch_n:
	mov		storage[ebx], 0E3H
	jmp		continue
ch_o:
	mov		storage[ebx], 0E0H
	jmp		continue
ch_s:
	mov		storage[ebx], 97H
	jmp		continue
ch_x:
	mov		storage[ebx], 8DH
	jmp		continue
ch_z:
	mov		storage[ebx], 0BDH
	jmp		continue

_main	ENDP
END