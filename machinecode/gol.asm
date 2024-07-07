SECTION .data     
msg:    db "00000001000001001110",10 
len:    equ $-msg       
width:  equ 0x5
height: equ 0x5
                
SECTION .text   
global main  


print_stdout:
    mov ebx,1       
    mov eax,4       
    int 0x80        
    ret

exit_main:
    mov ebx,0       
    mov eax,1       
    int 0x80
    ret


print_matrix:
    mov bh,0x0; y
    mov bl,0x0; X
    mov ax,0x1;
    row_begin:
        cmp bh,height
        jz row_end
            call print_stdout;
            inc bh
            cmp bl,width
            jz row_begin
                call print_stdout;
                mov AX, width    ; wdith * y + x
                mul bh
                add AX, bx
                ; add AX , [ msg + 0 ]  
                mov edx, 1
                mov ecx,msg 
                call print_stdout
                inc bl

    row_end:
        ret






main:
    mov al, 0x41           
    mov [msg + width], al   
    mov edx,len    
    mov ecx,msg  
    call print_stdout;
    call print_matrix;
    call exit_main


