SECTION .data     
matrix:    db "0000000100000100111000000",10
buff:      db "0000000000000000000000000",10
tmp:       db "012345",10
dead_sym:  db "⬛"
alive_sym: db "⬜"
newline:   db 10
buff_len:    equ 26    
sym_len:     equ 3   
width:  equ 0x5
height: equ 0x5
                
SECTION .text   
global main  


print_stdout:
    push rbx
    mov ebx,1       
    mov eax,4       
    int 0x80
    pop rbx        
    ret

xytoindex:;given_value_at_edi(row),esi(col)_->_eax_(row_*_width_+_col)
    xor rax,rax
    mov eax,width
    mul edi
    add eax,esi
    ret



exit_main:
    mov ebx,0       
    mov eax,1       
    int 0x80
    ret

print_new_line:
    push rcx 
    push rdx
        mov edx,1
        mov ecx,newline
        call print_stdout;
    pop rdx
    pop rcx
    ret


insert_zero:;(rdi)->None
    push rbx
    push rcx
    mov ebx,buff
    add ebx,edi
    mov ecx,0x30
    mov [ebx],ecx
    pop rcx
    pop rbx
    ret

insert_one:;(rdi) -> None
    push rbx
    push rcx
    mov ebx,buff
    add ebx,edi
    mov ecx,0x31
    mov [ebx],ecx
    pop rcx
    pop rbx
    ret


print_buff:
    push rdx
    push rcx
    mov edx,buff_len    
    mov ecx,buff  
    call print_stdout;
    pop rcx
    pop rdx
    ret 

print_matrix:
    push rdx
    push rcx
    mov edx,buff_len    
    mov ecx,matrix  
    call print_stdout;
    pop rcx
    pop rdx
    ret 


matat:;given edi(row),esi(col) -> value at buff[row][col] as eax 
    ;max index 255 as of now
    call xytoindex;
    mov edi,matrix
    add edi, eax
    mov eax,[edi]
    and eax,0xff ;mask out last 1byte only
    ret 


copy_to_matrix:;(None)->None
    push rax
    push rbx
    push rcx
    push rdx

    mov eax,width*height;
    mov ebx,buff
    mov ecx,matrix
    mov edx,0x0
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

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

print_symbol:;(edi)->None
    cmp edi,0x30
    jz print_dead;
        mov edx,sym_len;
        mov ecx,alive_sym;
        call print_stdout;
        ret
    print_dead:
        mov edx,sym_len;
        mov ecx,dead_sym;
        call print_stdout;
    ret

display_matrix:;(None) -> None
    push r15
    push r14
        xor r15,r15
        .row:
            xor r14,r14
            .col:
                ;edi -> row
                mov edi,r15d
                ;esi -> col
                mov esi,r14d
                call matat;
                mov edi,eax
                call print_symbol;
                inc r14d
                cmp r14d,width
                jnz .col;
            call print_new_line;
            inc r15d;
            cmp r15d,height
            jnz .row;
    pop r14
    pop r15
    ret

alive:;(row:rdi,col:rsi)
    ;dy -> r15
    ;dx -> r14
    push r15
    push r14
    ;r12 -> newy
    ;r13 -> newx
    push r12
    push r13

    ;alive_count -> r8
    push r8

    xor r8,r8;
    mov r15d,-0x1;
    .dx_loop:
        mov r14d,-0x1;
        .dy_loop:
            ;dy == 0 
            cmp r15d,0x0;
            jnz .lcontinue
                ;dx == 0 
                cmp r14d,0x0
                jnz .lcontinue
                    ;if dy==dx==0 continue loop
                    jmp .lskip;
            .lcontinue:
            

            ;newy <- y(row)
            mov r12d,edi;
            add r12d,r15d;newy + dy
            add r12d,height;newy + dy + height
            ;newy  <- (newy + dy + height) % height
            

            push rax
            push rbx
                mov edx,0
                mov ebx,height;
                mov eax,r12d;eax<-newy
                div ebx;(y+dy+heigth)/heigth quotient in eax, reminder in edx
            pop rbx
            pop rax

            mov r12d,edx;

            ;newx <- x(col)
            mov r13d,esi;
            add r13d,r14d;newx + dx
            add r13d,width;newx + dx + width

            push rax
            push rbx

                mov edx,0
                mov ebx,width;
                mov eax,0
                mov eax,r13d
                div ebx;(x+dx+heigth)/heigth quotient in eax, reminder in edx
            
            pop rbx
            pop rax
            ;newx  <- (newx + dx + width) % width
            mov r13d,edx;

            ;r12d <- newy
            ;r13d <- newx
            push rax
            push rdi
            push rsi
                mov edi,r12d;
                mov esi,r13d;
                call matat;-> eax
                cmp eax,0x30;compare matrix[row][col], 0x30 (asscii '0')
                jz .lskip_bef;if it's not asscci-zero
                    inc r8d;

            .lskip_bef:
                pop rsi
                pop rdi
                pop rax
            .lskip:
            inc r14d
            cmp r14d,0x2
            jnz .dy_loop

        inc r15d
        cmp r15d,0x2
        jnz .dx_loop
    
    mov eax,r8d

    pop r8
    pop r13
    pop r12
    pop r14
    pop r15
    ret


next_step:;(None) -> None
    push r15;y 
    push r14;x
    push rbp

    xor r15,r15;<- r15 = 0
    .outer_loop:
        xor r14,r14;<- r14 = 0
        .inner_loop:
        mov edi,r15d;rowl
        mov esi,r14d;col
        call alive;
        mov ebp,eax;
        cmp ebp,0x3;
        jnz .cmp_2;
            mov edi,r15d;rowl
            mov esi,r14d;col
            call xytoindex;given_value_at_edi(row),esi(col)_->_eax_(row_*_width_+_col)
            mov edi,eax;
            call insert_one;(rdi)
            jmp .finally;
        
        .cmp_2:
        cmp ebp,0x2;
        jnz .other_wise;
            mov edi,r15d;rowl
            mov esi,r14d;col
            call matat;given
            cmp eax,0x30;
            
            jnz .do_insert_one

                mov edi,r15d;rowl
                mov esi,r14d;col
                call xytoindex;given_value_at_edi(row),esi(col)_->_eax_(row_*_width_+_col)
                mov edi,eax;
                call insert_zero;(rdi)
                jmp .finally;

            .do_insert_one:
                mov edi,r15d;rowl
                mov esi,r14d;col
                call xytoindex;given_value_at_edi(row),esi(col)_->_eax_(row_*_width_+_col)
                mov edi,eax;
                call insert_one;(rdi)
                jmp .finally;

        .other_wise:
            mov edi,r15d;rowl
            mov esi,r14d;col
            call xytoindex;given_value_at_edi(row),esi(col)_->_eax_(row_*_width_+_col)
            mov edi,eax;
            call insert_zero;(rdi)->None


        .finally:;
        inc r14d;
        cmp r14d,width;
        jnz .inner_loop;

    inc r15d;
    cmp r15d,height;
    jnz .outer_loop;

    pop rbp
    pop r14
    pop r15
    ret 




main:
    ; mov edi,0x2;rowl
    ; mov esi,0x1;col
    ; call alive;
    ; cmp eax,0x3;

    mov rbp,7;
    .true_loop:
    call display_matrix;
    call next_step;(None)
    call copy_to_matrix;
    call print_new_line;
    dec rbp;
    jnz .true_loop;

    .end:
        call exit_main


