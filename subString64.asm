section .data
	num db 0
	pos db 0
	
	arr times 5 db 0
	arr1 times 5 db 0
	
	text1 db 'Nhap vao 1 String: '
	lent1 equ $-text1
	text2 db 'Nhap vao 1 SubString: '
	lent2 equ $-text2
	
	text3 db'Cac vi tri xuat hien:', 10
	lent3 equ $-text3
	
	text4 db'So lan xuat hien: '
	lent4  equ $-text4
	
	text5 db 'found', 10
	len5 equ $-text5

	text6 db 'not found', 10
	len6 equ $-text6
	
section .bss
	text resb 100
	text_len equ 100
	find resb 100
	find_len equ 100
	count resb 0
 
section .text
	global _start
_start :
	;print text 1
	mov rax,1
	mov rdi,1
	mov rsi,text1
	mov rdx,lent1
	syscall
	; get string
	mov rax, 0
	mov rdi, 0
	mov rsi, text
	mov rdx, text_len
	syscall
	;print text 2
	mov rax,1
	mov rdi,1
	mov rsi,text2
	mov rdx,lent2
	syscall
	; get sub string
	mov rax, 0
	mov rdi, 0
	mov rsi, find
	mov rdx, find_len
	syscall
	;print text 3
	mov rax, 1
	mov rdi,1
	mov rsi,text3
	mov rdx,lent3
	syscall
	; print location where found sub string
	mov rdi,text
	mov rsi,find
	mov rcx,0
	mov byte[count], 0
	cmp byte[rsi],10
	je _done
	lap:
		mov al,[rdi+rcx]
		mov bl,[rsi+rcx]
		cmp byte[rsi+rcx],10
		je found
		cmp byte[rdi+rcx],10
		je notfound 
		cmp al,bl
		je next
		jmp initAgain
	next :
		inc rcx
		jmp lap
 
	initAgain :
		inc  rdi
		mov rcx, 0
		mov rsi,find
		jmp lap
	 notfound:
		
		cmp byte[rdi], 10
		je _done
		jmp initAgain
	
	 found:
		mov rax, 4
		mov rdi, 1
		mov rsi, text5
		mov rdx, len5
		syscall
		jmp _done1
 
_done:	
	mov rax, 4
		mov rdi, 1
		mov rsi, text6
		mov rdx, len6
		syscall
	
	
_done1:
	; print Enter
	mov byte[pos], 10
	mov rax,4
	mov rdi,1
	mov rsi,pos
	mov rdx,2
	syscall
_end:
	mov rax, 60
	syscall
 
