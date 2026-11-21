global _start

section .text
_start:                             ;colcando os dois números em registradores
    mov rax, 5                      ; rax = 5
    mov rbx, 3                      ; rbx = 3
    add rax, rbx                    ; rax = rax + rbx

    mov rdi, rax                    ; o resultado vira o código de saída
    mov rax, 60                     ; syscall exit                   
    syscall
