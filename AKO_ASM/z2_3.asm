.686
.model flat
extern	_ExitProcess@4	:	PROC	
extern	_MessageBoxW@16	:	PROC
extern	_MessageBoxA@16	:	PROC
public	_main
.data
caption	word	'Z','n','a','k','i',0
text	word	'T','o',' ','j','e','s','t',' '
		word	'w','i','e','l','b',0142H, 0105H, 'd', ' '
		word	0D83DH, 0DC2BH ; UTF-16 BE
		word	' ','i',' '
		word	's',0142H,'o',0144H, ' '
		word	0D83dH,0DC18H,0
.code
_main	PROC
	push	0
	push	OFFSET caption
	push	OFFSET text
	push	0
	call	_MessageBoxW@16

	push	0
	call	_ExitProcess@4
_main ENDP
END