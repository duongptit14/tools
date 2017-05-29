section .data
	num db 0
	pos db 0
	
	arr times 5 db 0
	arr1 times 5 db 0
	
	text1 db 'Nhap vao 1 String: '
	lent1 equ $-text1
	text2 db 'Nhap vao 1 SubString: '
	lent2 equ $-text2
	
	text3 db'Cac vi tri xuat hien:'
	lent3 equ $-text3
	
	text4 db'So lan xuat hien: '
	lent4  equ $-text4
	
section .bss
	text resb 100
	text_len equ 100
	find resb 100
	find_len equ 100
	count resb 0
 
section .text
	global main
main:
	;print text 1
	mov eax,4
	mov ebx,1
	mov ecx,text1
	mov edx,lent1
	int 80h
	; get string
	mov eax, 3
	mov ebx, 0
	mov ecx, text
	mov edx, text_len
	int 80h
	;print text 2
	mov eax,4
	mov ebx,1
	mov ecx,text2
	mov edx,lent2
	int 80h
	; get sub string
	mov eax, 3
	mov ebx, 0
	mov ecx, find
	mov edx, find_len
	int 80h
	;print text 3
	mov eax,4
	mov ebx,1
	mov ecx,text3
	mov edx,lent3
	int 80h
	; print location where found sub string
	mov edi,text
	mov esi,find
	mov ecx,0
	mov byte[count], 0
	cmp byte[esi],10
	je _done
	lap:
		mov al,[edi+ecx]
		mov bl,[esi+ecx]
		cmp byte[esi+ecx],10
		je found
		cmp byte[edi+ecx],10
		je notfound 
		cmp al,bl
		je next
		jne initAgain
	next :
		inc ecx
		jmp lap
 
	initAgain :
		inc edi
		mov ecx, 0
		mov esi,find
		jmp lap
	 notfound:
		
		cmp byte[edi], 10
		je _done
		jmp initAgain
	
	 found:
		add byte[count], 1
		mov eax,edi
		sub eax,text ;  eax = begin index of sub-string in string
		mov esi,arr
		;mov byte[num], al
		;mov al, byte[num]
		mov bl,10
		pushArr:
			div bl
			add ah,'0'
			mov [esi],ah
			cmp al,0
			je ok
			mov ah,0
			inc esi
			jmp pushArr
		ok: ; add space between 2 number 
			inc esi
			mov byte[esi], 32
		PrintArr: ; print number
			mov eax,4
			mov ebx,1
			mov ecx,esi
			mov edx,1
			int 80h
			dec esi
			cmp esi,arr
			jl next1
			jmp PrintArr
			
	next1:	
		cmp byte[edi], 10
		je _done
		jmp initAgain
 
_done:	
	;print enter
	mov byte[pos], 10
	mov eax,4
	mov ebx,1
	mov ecx,pos
	mov edx,1
	int 80h
	;print text 4
	mov eax,4
	mov ebx,1
	mov ecx,text4
	mov edx,lent4
	int 80h
	; print count
		mov eax,[count]
		mov esi,arr1
		mov byte[num], al
		mov al, byte[num]
		mov bl,10
		pushArr1:
			div bl
			add ah,'0'
			mov [esi],ah
			cmp al,0
			je PrintArr1
			mov ah,0
			inc esi
			jmp pushArr1
		PrintArr1:
			mov eax,4
			mov ebx,1
			mov ecx,esi
			mov edx,1
			int 80h
			dec esi
			cmp esi,arr1
			jl _done1
			jmp PrintArr1
_done1:
	; print Enter
	mov byte[pos], 10
	mov eax,4
	mov ebx,1
	mov ecx,pos
	mov edx,1
	int 80h
_end:
	mov eax,1
	xor ebx,ebx
	int 80h
 