# important [note](./x64_cheatsheet.pdf)

## registers

8-byte register |  Bytes 0-3 |  Bytes 0-1 | Byte 0|
----------------|------------|------------|-------|
%rax            |  %eax      |  %ax       |  %al
%rcx            |  %ecx      |  %cx       |  %cl
%rdx            |  %edx      |  %dx       |  %dl
%rbx            |  %ebx      |  %bx       |  %bl
%rsi            |  %esi      |  %si       |  %sil
%rdi            |  %edi      |  %di       |  %dil
%rsp            |  %esp      |  %sp       |  %spl
%rbp            |  %ebp      |  %bp       |  %bpl
%r8             |  %r8d      |  %r8w      |  %r8b
%r9             |  %r9d      |  %r9w      |  %r9b
%r10            |  %r10d     |  %r10w     |  %r10b
%r11            |  %r11d     |  %r11w     |  %r11b
%r12            |  %r12d     |  %r12w     |  %r12b
%r13            |  %r13d     |  %r13w     |  %r13b
%r14            |  %r14d     |  %r14w     |  %r14b
%r15            |  %r15d     |  %r15w     |  %r15b
------------------------------------------------

## during function calls

### Caller-Save registers
 these register might not persist their value during a function call
 so who ever is invoking the call function they have to save these to register
 or copy to calle-save registers

- %rax  [use for funciton return]
- %rsp  [stack pointer] 

- %rdi [first arg]
- %rsi [second arg]
- %rdx [third arg]
- %rcx [fourth arg]
- %r8  [fifth arg]
- %r9  [sixth arg]

- %r10
- %r11

### Callee-Save registers
 these register are persistent accros fucntion calls, so the sub-routine have to 
 preserve it's state if it has to use these register
- %rbx
- %rbp
- %r12
- %r13
- %r14
- %r15


[0,0,0,0,0]
[0,0,0,0,0]
[0,0,0,0,0]
[0,0,0,0,0]
[0,0,0,0,0]
```as
push rdx
push rcx
    mov edx,0x1

    mov ecx,tmp
    add ecx,r12d  
    call print_stdout;    

    mov ecx,tmp
    add ecx,r13d  
    call print_stdout;             
    call print_new_line;
pop rcx
pop rdx
```