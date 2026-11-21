global _start

section .bss                    ; Área para dados não inicializados
resultado resb 2                ; reserva 2 bytes (dígitos + quebra de linha)

section .text
_start:
    mov rax, 5
    add rax, 3                  ; rax = 8

    add rax, '0'                ; converte número em caractere ASCII
    mov [resultado], al         ; guarda o caractere na memória
    mov byte [resultado+1], 10  ; quebra de linha

    mov rax, 1                  ; write
    mov rdi, 1                  ; stdout
    mov rsi, resultado          ; endereço do texto
    mov rdx, 2                  ; 2 bytes
    syscall

    mov rax, 60                 ; exit
    xor rdi, rdi
    syscall

    ; O [resultado] significa "o conteúdo na memória nesse endereço"
    ; al é a parte baixa de 8 bits do rax. Usa-se al porque queremos gravar só 1 byte
    
    ; Esse código só funciona para resultados de um dígito (0 a 9). Para números maiores
    ; é preciso converter dividindo por 10 em um laço. 