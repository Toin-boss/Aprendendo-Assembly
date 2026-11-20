global _start                   ;Torna o rótulo visível para o linker(aquele que executa o arquivo .o). É o ponto de entrada

section .data                   ;Área da memória para dados inicializados
msg db "Olá, mundo", 10         ;msg é o rótulo(nome dado a um endereço de memória). db (define bytes) grava os bytes de do texto na memória
len equ $ - msg                 ;$ é o endereço atual(logo após o texto); equ cria uma constante, sem ocupar na memória

section .text                   ;mov (destino), (origem). mov é uma instrução básica para transferência de dados
_start:
    mov rax, 1                  ;rax(Accumulator) = número da chamada(1 = write)
    mov rdi, 1                  ;rdi(Destination Index) = 1° argumento: onde escrever (1 = saída padrão, o terminal)
    mov rsi, msg                ;rsi(Source Index) = 2° argumento: endereço dos dados (msg)
    mov rdx, len                ;rdx(Data) = 3° argumento: quantos bytes escrever (len)
    syscall

    mov rax, 60                 ;essa é a chamada para sair (exit)
    xor rdi, rdi                ;zera rdi (qualquer valor XOR ele mesmo dá 0). É mais rápido que mov rdi, 0 e é um idioma comum
    syscall