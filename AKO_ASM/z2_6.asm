; co drugi znak ASCII
; for CP 852
.686
.model	flat

extern	_ExitProcess@4	:	PROC
extern	__write			:	PROC
extern	__read			:	PROC
extern	_MessageBoxA@16	:	PROC
public _main

.data
caption		byte	'Wielkie litery',0
cmd_txt		byte	'Prosz',0A9H,' napisa',86H,' jaki',98H,' tekst'
			byte	' i nacisn',0A5H,86H,' Enter', 10
end_cmd_txt	byte	?
flag		byte	1
storage		byte	80 dup (?)
alt_storage	byte	80 dup (?)
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

	mov		chars_count, eax ; __read puts in eax read chars count
	mov		ecx, eax
	mov		ebx, 0 ; index
	lp1:
		mov		dl, storage[ebx]
		cmp		dl, 0A5H	; ¹
		je		ch_a
		cmp		dl, 086H	; æ
		je		ch_c
		cmp		dl, 0A9H	; ê
		je		ch_e
		cmp		dl, 088H	; ³
		je		ch_l
		cmp		dl, 0E4H	; ñ
		je		ch_n
		cmp		dl, 0A2H	; ó
		je		ch_o
		cmp		dl, 098H	; œ
		je		ch_s
		cmp		dl, 0ABH	; Ÿ
		je		ch_x
		cmp		dl, 0BEH	; ¿
		je		ch_z

		; check polish chars (upper-case)
		cmp		dl, 0A4H	; ¹
		je		ch_a
		cmp		dl, 08FH	; æ
		je		ch_c
		cmp		dl, 0A8H	; ê
		je		ch_e
		cmp		dl, 09DH	; ³
		je		ch_l
		cmp		dl, 0E3H	; ñ
		je		ch_n
		cmp		dl, 0E0H	; ó
		je		ch_o
		cmp		dl, 097H	; œ
		je		ch_s
		cmp		dl, 08DH	; Ÿ
		je		ch_x
		cmp		dl, 0BDH	; ¿
		je		ch_z

		; check regular chars
		cmp		dl, 'a'
		jb		continue	; omit if below 'a'
		cmp		dl, 'z'
		ja		continue	; omit if above 'z'
		jmp		ch_20h

		continue:
			inc		ebx
			;loop	lp1
			dec		ecx		
			jnz		lp1
	
	jmp		alternate
	alternate_return:
	; show wnd with changed txt
	mov		alt_storage[ebx], 0	; string null terminator
	push	0	; MB_OK
	push	OFFSET caption
	push	OFFSET alt_storage
	push	0	; hWND
	call	_MessageBoxA@16

	; exit program
	push	0
	call	_ExitProcess@4


	ch_10h:
		sub		storage[ebx], 10h
		jmp		continue
	
	ch_20h:
		sub		dl, 20h
		mov		storage[ebx], dl
		jmp		continue
	
	ch_a:
		mov		storage[ebx], 0A5h
		jmp		continue
	ch_c:
		mov		storage[ebx], 0C6h
		jmp		continue
	ch_e:
		mov		storage[ebx], 0CAh
		jmp		continue
	ch_l:
		mov		storage[ebx], 0A3h
		jmp		continue
	ch_n:
		mov		storage[ebx], 0D1h
		jmp		continue
	ch_o:
		mov		storage[ebx], 0D3h
		jmp		continue
	ch_s:
		mov		storage[ebx], 08Ch
		jmp		continue
	ch_x:
		mov		storage[ebx], 08Fh
		jmp		continue
	ch_z:
		mov		storage[ebx], 0AFh
		jmp		continue

	alternate:
		mov		ecx, chars_count
		mov		eax, 0		; storage index
		mov		ebx, 0		; alt_storage index
		lp2:
			cmp		storage[eax], 20H
			je		change_flag
			change_flag_return:
			cmp		flag, 0
			je		lp2_continue
			mov		dl, storage[eax]
			mov		alt_storage[ebx], dl
			inc		ebx
			lp2_continue:
			inc		eax
			loop	lp2

	jmp alternate_return

	change_flag:
		cmp		flag, 0
		je		to_1
		mov		flag, 0
		jmp		change_flag_return
		to_1:
		mov		flag, 1
		jmp		change_flag_return
_main ENDP
END