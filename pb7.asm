; Se citeste o cifra a (0-9). Sa se determine daca este in multimea {2,4,9}.

section .data
    UserMsg db 'Introdu o cifra: '  
    len_UserMsg equ $-UserMsg
    msg_1 db 'Cifra apartine multimii {2,4,9}', 0xa
    len_msg_1 equ $-msg_1
    msg_2 db 'Cifra NU apartine multimii {2,4,9}', 0xa
    len_msg_2 equ $-msg_2

section .bss
    digit resb 1   ;-------> Declar variabila digit careia ii aloc 1 byte de memorie

section .text
    global _start
_start:
    mov eax, 4     ;--------> Afisarea mesajului "Introdu o cifra:"
    mov ebx, 1
    mov ecx, UserMsg
    mov edx, len_UserMsg
    int 80h

    mov eax, 3     ;--------> Citirea variabilei 'digit'
    mov ebx, 0
    mov ecx, digit
    mov edx, 1
    int 80h

    mov ecx, [digit]   ;-----> Stocarea valoarei variabilei digit in registrul ecx 
    sub ecx, '0'       ;-----> Conversie din ASCII in decimal 


_if_2:             
    cmp ecx, 2    ;----------> if (digit == 2)
    je _YES       ;               jump la eticheta _YES
    

_if_4:               
    cmp ecx, 4    ;----------> if (digit == 4)  
    je _YES       ;               jump la eticheta _YES


_if_9:
    cmp ecx, 9    ;----------> if (digit == 9)
    je _YES       ;               jump la eticheta _YES

_NO:
    mov eax, 4       ;-------> In cazul in care digit != 2,4,9 se afiseaza mesajul "Cifra NU apartine multimii {2,4,9}"
    mov ebx, 1
    mov ecx, msg_2
    mov edx, len_msg_2
    int 80h

    jmp _exit            

_YES:                ;-------> In cazul in care digit == 2,4,9 se afiseaza mesajul "Cifra apartine multimii {2,4,9}"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_1
    mov edx, len_msg_1
    int 80h

_exit:              ;-------> Iesirea din program
    mov eax, 1
    mov ebx, 0
    int 80h
