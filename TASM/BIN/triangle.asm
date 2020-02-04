.model small
.stack 100h
.data
    Prompt1 db "Input Triangle Size: $"
    Prompt2 db 10,13,"Input Triangle Symbol: $"
    Newline db 10,13,"$"
.code
main:
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
    jz term
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
    push dx
    mov bx, 1
    mov ah, 9
    mov dx, OFFSET Newline
    int 21h
    pop dx

    push dx
    push cx

    

    ; push bp ; save BP
    ; mov bp, sp ; set base pointer

    call triangle
    
    term:
    mov ax, 4c00h
    int 21h



    ; outer loop. bx line number

triangle:
    ; pop cx
    ; pop dx

    size EQU WORD PTR ss:[bp+4]
    character EQU WORD PTR ss:[bp+6]

    push bp ; save BP
    mov bp, sp ; set base pointer

    mov cx, size ; retrieve parameter 1
    mov dx, character ; retrieve parameter 2

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
    pop dx
    dec cx
    jnz printSymbol
    ; print new line
    push dx
    mov ah, 9
    mov dx, OFFSET Newline
    int 21h
    pop dx
    pop cx
    inc bx
    dec cx
    jnz printLine
    ; terminate program

    mov sp, bp ; restore original SP
    pop bp ; restore BP

    ret
END main
