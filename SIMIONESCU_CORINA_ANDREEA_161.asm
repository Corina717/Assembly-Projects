; Simionescu Corina Andreea, grupa 161
; Tema 2, problema 5: sinh[x]

section .data

msg1 db "Introdu numarul x: ", 0
msg2 db "Rezultatul pentru sinh(x) este", 0
msg3 db "Afisare" , 0
fmstr db "%s", 10, 0 ; format afisare string 
fmflt db "%lf", 10, 0; fromat afisare float
e_la_x dq 1
e_la_xneg dq 1
num2 dq 2
plus dq 1
num dq 1
counter dq 0
e dq 2
formatin db "%d", 0
formatout db "%d",10,0


section .bss

result resq 1
dif resq 1
modulo resq 1
x resq 1

section .text
global _start

extern printf ; declare the function as external
extern scanf ; declare the function as external

_start:
; Initializare functie
push rbp
mov rbp, rsp
sub rsp,16


; Afisare msg1 : Introdu numarul x
mov rax, 0
mov rdi, fmstr   ; Primul argument pentru printf 
mov rsi, msg1    ; Al doilea argument pentru printf 
call printf

; Citirea lui x
mov rax, 0
mov rsi, x
mov rdi, formatin
call scanf

; Calculez e la x
_for:

mov rax, [counter]    ; Contorul este in rax
mov rbx, [x]
cmp rax,rbx           ; if ( rax < rbx )           
jl _lower              ;   jump to _lower                           


mov rax, [e_la_x] ; rax is equal
mov [dif], rax 
jmp _sinh


_lower:
mov rbx, [counter]
mov rcx, [plus]
add rbx,rcx
mov [counter],rbx
mov rax, [e_la_x]
imul qword [e]
mov [e_la_x], rax
jmp _for            ; Se sta in _for pana cand rax == x 

_sinh:

mov rax, [num] 
mov rdx,0
idiv qword [e_la_x]
mov [e_la_xneg], rax
   
mov rsi, [e_la_xneg]
lea rdi, [formatout]    
xor eax, eax
call printf


; Scadere e^x cu e^(-x)
mov rax, [dif]
sub rax, [e_la_xneg]
mov [dif], rax

; Impart la 2 scaderea anterior obtinuta 
mov rax, [dif]
mov rdx, 0
idiv qword [num2]
mov [result], rax
mov [modulo], rdx

mov rax, 0
mov rdi, fmstr  ; Primul argument pentru printf
mov rsi, msg2   ; Al doilea argument pentru printf
call printf

   
mov rsi, [result]
lea rdi, [formatout]    
xor eax, eax
call printf

    
; Iesirea din program
exit:
mov	eax,1       ;system call number (sys_exit)
int	0x80        ;call kernel