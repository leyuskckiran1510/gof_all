SECTION .data     
matrix:    db "0000000100000100111000000",10
buff:      db "0100000000000000000000000",10
alive_sym: db "⬜"
dead_sym:  db  "⬛"
newline:   db 10
buff_len:    equ 26    
sym_len:     equ 3    
width:  equ 0x5
height: equ 0x5
                
SECTION .text   
global main  


print_stdout:
    push rbx
    push rax 
    mov ebx,1       
    mov eax,4       
    int 0x80
    pop rax
    pop rbx        
    ret

xytoindex:
    ; given value at ecx(row),edx(col) -> ecx (row * width + col)
    push rax
    mov eax,width
    mul ebx
    add eax,ecx
    mov ecx,eax
    pop rax
    ret



exit_main:
    mov ebx,0       
    mov eax,1       
    int 0x80
    ret

print_new_line:
    push rdx
    push rcx 
    mov edx,1
    mov ecx,newline
    call print_stdout;
    pop rcx
    pop rdx
    ret


insert_zero:
    push rbx
    push rcx
    mov ebx,buff
    add ebx,eax
    mov ecx,0x30
    mov [ebx],ecx
    pop rcx
    pop rbx
    ret

insert_one:
    push rbx
    push rcx
    mov ebx,buff
    add ebx,eax
    mov ecx,0x31
    mov [ebx],ecx
    pop rcx
    pop rbx
    ret


print_buff:
    push rax
    push rcx
    mov edx,buff_len    
    mov ecx,buff  
    call print_stdout;
    pop rcx
    pop rax
    ret 

print_matrix:
    push rax
    push rcx
    mov edx,buff_len    
    mov ecx,matrix  
    call print_stdout;
    pop rcx
    pop rax
    ret 


matat:
    ; given ebx(row),ecx(col) -> value at buff[row][col] as ecx 
    ; max index 255 as of now
    call xytoindex;
    mov ebx,matrix
    add ebx, ecx
    mov ecx,[ebx]
    and ecx,0xff ; mask out last 1byte only
    ret 


copy_to_matrix:
    push rax
    mov eax,width*height;
    mov edx,0x0
    mov ebx,buff
    mov ecx,matrix
    .iloop:
        add ebx,edx 
        add ecx,edx
        inc edx
        push rax
        mov eax,[ebx]
        mov [ecx],eax
        pop rax
        dec eax
        jnz .iloop;
    pop rax
    ret

print_symbol:
    cmp ecx,0x30
    jz print_dead;
        mov ecx,alive_sym;
        mov edx,sym_len;
        call print_stdout;
        ret
    print_dead:
        mov ecx,dead_sym;
        mov edx,sym_len;
        call print_stdout;

    ret

display_matrix:
    ; save registers
    push rax
    push rbx
    push rcx
    push rdx

    mov eax,0x0
    .row:
        mov ebx,0x0
        .col:
            push rbx
            ;ecx -> col
            mov ecx,ebx
            ;ebx -> row
            mov ebx,eax
            call matat;
            pop rbx
            call print_symbol;
            inc ebx
            cmp ebx,width
            jnz .col;
        call print_new_line;
        inc eax;
        cmp eax,height
        jnz .row;

    ; restore registers
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret



main:
    ; call print_buff;
    ; call print_new_line;
    ; call print_matrix;
    ; call copy_to_matrix;
    ; call print_matrix;
    call display_matrix;
    .end:
        call exit_main


