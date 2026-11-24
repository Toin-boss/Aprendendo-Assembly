# Registradores de uso geral de 64 bits (x86-64)

A arquitetura x86-64 possui **16 registradores de uso geral** de 64 bits.

## Registradores clássicos (herdados do x86)

| Registrador | Nome / função principal |
|-------------|-------------------------|
| **RAX** | Acumulador; operações aritméticas, valor de retorno de funções e número da syscall no Linux |
| **RBX** | Base; uso geral, preservado entre chamadas de função (callee-saved) |
| **RCX** | Contador; loops e deslocamentos; 4º argumento de função na System V |
| **RDX** | Dados; multiplicação/divisão e 3º argumento de função |
| **RSI** | Índice de origem (*source index*); 2º argumento de função e operações de string |
| **RDI** | Índice de destino (*destination index*); 1º argumento de função e operações de string |
| **RBP** | Ponteiro de base do *stack frame* |
| **RSP** | Ponteiro de topo da pilha (*stack pointer*) |

## Registradores novos do x86-64

| Registrador | Função / observação |
|-------------|---------------------|
| **R8** | 5º argumento de função |
| **R9** | 6º argumento de função |
| **R10** | Uso geral; 4º argumento de syscall no Linux |
| **R11** | Uso geral; usado pela instrução `syscall` (guarda RFLAGS) |
| **R12** | Uso geral (callee-saved) |
| **R13** | Uso geral (callee-saved) |
| **R14** | Uso geral (callee-saved) |
| **R15** | Uso geral (callee-saved) |

## Observações úteis

- **RSP** e **RBP**, embora contados entre os 16, têm funções especiais com a pilha e geralmente não são usados para dados comuns.
- Cada registrador possui versões menores. Exemplo: `RAX` (64 bits) → `EAX` (32) → `AX` (16) → `AL` (8).
- Nos registradores **R8 a R15**, os nomes das versões menores são `R8D` (32 bits), `R8W` (16 bits) e `R8B` (8 bits).

## Convenções de chamada (Linux)

- **Argumentos de função (System V AMD64):** `RDI`, `RSI`, `RDX`, `RCX`, `R8`, `R9`
- **Syscalls:** número em `RAX`; argumentos em `RDI`, `RSI`, `RDX`, `R10`, `R8`, `R9`
