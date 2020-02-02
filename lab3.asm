.model small
.stack 100h
.data
	Prompt1	db "Input Triangle Size: $"
	Prompt2	db 10,13,"Input Triangle Symbol: $"
	Newline	db 10,13,"$"
.code
start:
	; initialize data segment
	mov ax, @data
	mov ds, ax
	; print prompt text
	mov ah, 9
	mov dx, OFFSET Prompt1
	int 21h
	; input number (will be stored as an ASCII character in AL)
	mov ah, 1
	int 21h
	; set counter register to input number
	; (subtract '0' from input ASCII character to get a number)
	sub al, '0'
	xor cx, cx
	mov cl, al
	; ask for triangle symbol
	mov ah, 9
	mov dx, OFFSET Prompt2
	int 21h
	; read input symbol
	mov ah, 1
	int 21h
	mov dl, al
	mov bx, 1
	; outer loop. bx line number
	printLine:
	; save our counter
	push cx
	mov cx, bx
	; inner loop
	; for loop that will print the symbols
	printSymbol:
	; protect bx and dx, then print symbol in dl
	push dx
	push bx
	mov ah, 2
	int 21h
	pop bx
	dec cx
	jnz printSymbol
	; print new line
	mov ah, 9
	mov dx, OFFSET Newline
	int 21h
	pop dx
	pop cx
	dec cx
	inc bx
	; mov dl, cl
	; mov ah, 2
	; int 21h
	jnz printLine
	; terminate program
	mov ax, 4c00h
	int 21h
END start
