.global main

        .text
main:                                   # This is called by C library's startup code
	# loop 1:20
	#   $i=$i+1
	#   show $i
	# end
	movl $1,%eax
	movl $20,%ebx
	
	push %rbx
	push %rax
	
	mov $show, %edi # format
	movl $21, %eax
	mov %eax, %esi # variable
	xor %eax, %eax
	call printf
	pop %rax

	dec %ebx

	ret

show:	
	.asciz "%d\n"
