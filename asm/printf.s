 .global main

        .text
main:
        mov     $14, %rax               # ecx will countdown to 0
        push    %rax                    # caller-save register
        mov     $format, %rdi           # set 1st parameter (format)
        mov     %rax, %rsi              # set 2nd parameter (current_number)
        call    printf                  # printf(format, current_number)
        pop     %rax                    # restore caller-save register
        ret
format:
        .asciz  "Hello %x\n"
