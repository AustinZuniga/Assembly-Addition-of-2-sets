stseg segment
	db 32 dup(?)
stseg ends
;----------------
dtseg segment
org 0020h
data_in db 10d,20d,15d,25d,30d
org 0030h
data_in2 db 11d,12d,17d,18d,19d
org 0040h
sum db ?
dtseg ends
;----------------
cdseg segment
main proc far
assume cs:cdseg, ds:dtseg, ss:stseg
	mov ax,dtseg
	mov ds,ax
	mov si,offset data_in
	mov di,offset data_in2
	mov cx,06
	mov dl,00

mov_loop:       mov al,[si]
		mov bl,[di]
		add al,bl
		add dl,al
		mov sum,dl
		inc si
		inc di
		dec cx
		jnz mov_loop
		mov ah,4ch
		int 21h
main endp
cdseg ends
end main