	.global main
	.text
main:
	mov %rsp,%rbp
	sub $208,%rsp

	xor %rax,%rax
	mov %rax,-24(%rbp)

	mov $4, %rax
	push %rax

	mov $10, %rax
	push %rax

	pop %rbx
	pop %rax
	add %rbx, %rax
	push %rax

	pop %rax
	mov %rax,-24(%rbp)

	push %rax
	push %rbx
	push %rcx
	mov $showx, %rdi
	mov -24(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	add $208, %rsp
	ret
show:
	.asciz "%d\n"
showx:
	.asciz "0x%x\n"

