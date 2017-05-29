section .data
	text1 db 'Nhap so n: '
	lent1 equ $-text1
	arr times 100 db 0
	count dd 0
	count2 dd 0
	space dd ' ', 10
	lenSpace equ $-space
section .bss
	n resb 10
	lenn equ $-n
 
	num resb 10
	lenNum equ $-num
section .text
	global _start
_start:
	;print text 1
	mov eax, 4
	mov ebx, 1
	mov ecx, text1
	mov edx, lent1
	int 80h
 
	; get n
	mov eax, 3
	mov ebx, 0
	mov ecx, n
	mov edx, lenn
	int 80h
 
	; convert n (string) to number
	mov esi,n
	mov bl,10
	mov al,0
	lo :
		cmp byte[esi],10
		je ok
		mul bl
		mov cl,[esi]
		sub cl,'0'
		add al,cl
 
		inc esi
		jmp lo
ok:
	mov esi, arr
	mov byte[count], al
 
 
; nhap cac phan tu vao mang
 
	_next:
		cmp byte[count], 0
		je decCount
 
		mov eax, 3
		mov ebx, 0
		mov ecx, num
		mov edx, lenNum
		int 80h
 
		mov edi,num
		mov bl,10
		mov al,0
		lo1:
			cmp byte[edi],10
			je _next1
			mul bl
			mov cl,[edi]
			sub cl,'0'
			add al,cl
 
			inc edi
			jmp lo1
 
 
		_next1:
			mov [esi], al
			inc esi
			sub byte[count], 1
			jmp _next 
decCount:
 
	dec esi	
	mov [count2], esi 	
	mov edi, arr
	mov eax, [edi]
 
sort:
	cmp edi, [count2]
	jg init
	mov esi, edi
	inc esi
	bbsort: 
		cmp esi, [count2]
		jg continue
		mov eax, [esi]
		cmp [edi], eax
		jg swap
		inc esi
		jmp bbsort
	continue:
		inc edi
		jmp sort
	swap:
		mov al, [esi]
		mov bl, [edi] 
		mov [esi], bl
		mov [edi], al
 
		inc esi
		jmp bbsort
init:
	mov esi, arr
_print:
	cmp esi, [count2]
	jg _end
	add byte[esi], '0'
	mov eax, 4
	mov ebx, 1
	mov ecx, esi
	mov edx, 1	
	int 80h
 
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, lenSpace	
	int 80h
 
	inc esi
	jmp _print
 
_end:
	mov eax, 1
	xor ebx,ebx
	int 80h
