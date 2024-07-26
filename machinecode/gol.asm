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
    ; given value at ebx(row),ecx(col) -> ecx (row * width + col)
    push rax
    xor rax,rax
    mov eax,width
    mul ebx
    add eax,ecx
    xor rcx,rcx
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

alive:
    ; dx -> rax
    ; dy -> rbx
    ; x -> rdi
    ; y -> rsi
    push rax
    push rbx
    push rcx
    push rdx
    push r8

    mov r8,0x0
    mov eax,-0x1;
    .dx_loop:
        mov ebx,-0x1;
        .dy_loop:
            cmp eax,0x0;
            push rax
            push rbx
            ; call display_matrix;
            call print_matrix;
            pop rbx
            pop rax
            jnz .lcontinue
                cmp ebx,0x0
                jnz .lcontinue
                    call print_matrix;
                    jmp .lskip; 
            .lcontinue:
            push rdi; save current x
            push rsi; save current y
            
            add edi,eax; x + dx
            add edi,width; x + dx + width

            push rax
            push rbx

                mov edx,0
                mov ebx,width;
                mov eax,0
                mov eax,edi
                div ebx; (x+dx+width)/width quotient in eax, reminder in edx
            
            pop rbx
            pop rax
            ; edx <- newx
            push rdx;save edx

            add esi,ebx; y + dy
            add esi,height; y + dy + height

            push rax
            push rbx

                mov edx,0
                mov ebx,height;
                mov eax,0
                mov eax,edi
                div ebx; (x+dx+width)/width quotient in eax, reminder in edx
            
            pop rbx
            pop rax
            
            mov ecx,edx; copy newy to ecx
            pop rdx; restore saved newx to edx
            push rbx
            mov ebx,ecx;ebx<-newy 
            mov ecx,edx;ecx<-newx
            call matat;
            ; ebx(row),ecx(col) 
            pop rbx
            cmp ecx,0x30; compare matrix[row][col], 0x30 (asscii '0')
            jz .lskip; if it's not asscci-zero
                inc r8; 
            .lskip:
            inc ebx
            pop rsi
            pop rdi
            cmp ebx,0x2
            jnz .dy_loop

        inc eax
        cmp eax,0x2
        jnz .dx_loop
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
    mov edi,0x3
    mov esi,0x1
    call alive;
    cmp r8,0x3;
    jnz .end;
        call display_matrix;
    .end:
        call exit_main


