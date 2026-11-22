# Assembly x86-64: diferenças entre sistemas operacionais

A CPU é a mesma, então as instruções (`mov`, `add`, `jmp`...) não mudam. A diferença está em três pontos: **como falar com o kernel**, **o formato do executável** e **a convenção de chamada**.

---

## 1. Syscalls (a maior diferença)

| Sistema | Como chamar o kernel | Observações |
|---------|----------------------|-------------|
| **Linux** | Instrução `syscall`; número em `rax`; argumentos em `rdi, rsi, rdx, r10, r8, r9` | Interface estável e documentada. Ex.: `write` = 1, `exit` = 60. Dá para programar sem libc. |
| **macOS** | Instrução `syscall`, com prefixo nos números (`0x2000000 + n`) | Ex.: `exit` = `0x2000001`. A Apple não garante estabilidade; o recomendado é usar a libc. |
| **Windows** | Não há syscalls documentados; chama-se a API em DLLs (`kernel32.dll`) | Ex.: `WriteFile`, `ExitProcess`. Os números internos mudam entre versões. |

### Exemplo: sair do programa com código 0

**Linux**
```nasm
mov rax, 60        ; syscall exit
xor rdi, rdi       ; código 0
syscall
```

**macOS**
```nasm
mov rax, 0x2000001 ; syscall exit
xor rdi, rdi       ; código 0
syscall
```

**Windows**
```nasm
extern ExitProcess
sub rsp, 40        ; shadow space + alinhamento
xor ecx, ecx       ; código 0
call ExitProcess
```

---

## 2. Convenção de chamada de funções

| Sistema | Argumentos inteiros | Extras |
|---------|---------------------|--------|
| **Linux e macOS** (System V) | `rdi, rsi, rdx, rcx, r8, r9` | — |
| **Windows** (x64) | `rcx, rdx, r8, r9` | 32 bytes de *shadow space* na pilha antes de cada `call` |

---

## 3. Formato do executável e ferramentas

| Sistema | Formato | Montar e ligar | Depurador |
|---------|---------|----------------|-----------|
| **Linux** | ELF | `nasm -f elf64` + `ld` | GDB |
| **macOS** | Mach-O | `nasm -f macho64` + `ld` (com flags do SDK) | LLDB |
| **Windows** | PE | `nasm -f win64` + linker do MSVC ou MinGW | x64dbg / WinDbg |

> **Atenção:** em Macs com Apple Silicon a arquitetura é ARM64, então o assembly é outro (não é x86-64).

---

## 4. Detalhes menores

- **Nomes de símbolos:** o macOS exige `_` no início (`_main`, `_start`).
- **Alinhamento da pilha:** 16 bytes antes de um `call` é obrigatório nos três sistemas.
- **Sintaxe:** NASM (Intel) funciona nos três; o GNU `as` usa AT&T por padrão.

---

## Resumo

| | Linux | macOS | Windows |
|---|---|---|---|
| Kernel | `syscall` (estável) | `syscall` (instável, prefixo) | API em DLLs |
| Args de função | `rdi, rsi, rdx, rcx, r8, r9` | igual ao Linux | `rcx, rdx, r8, r9` + shadow space |
| Executável | ELF | Mach-O | PE |
| Debug | GDB | LLDB | x64dbg / WinDbg |

**Para aprender:** o Linux é o ambiente mais simples (syscalls diretos, sem camadas extras). Depois, portar para outro SO é basicamente trocar a "cola" com o sistema, não a lógica do programa.
