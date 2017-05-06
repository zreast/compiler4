	.global main
	.text
main:
	mov %rsp,%rbp
	sub $208,%rsp

	xor %rax,%rax
	mov %rax,-24(%rbp)

	xor %rax,%rax
	mov %rax,-8(%rbp)

	xor %rax,%rax
	mov %rax,-16(%rbp)

	mov $10, %rax
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

	mov $1, %rax
	push %rax

	pop %rax
	mov %rax,-8(%rbp)

	mov $20, %rax
	push %rax

	pop %rcx
	xor %rax,%rax
	cmp %rax,%rcx
	je EL0
L0:

	mov $1, %rax
	push %rax

	pop %rbx
	mov -8(%rbp), %rax
	add %rbx, %rax
	push %rax

	pop %rax
	mov %rax,-8(%rbp)

	mov $2, %rax
	push %rax

	pop %rbx
	mov -8(%rbp), %rax
	xor %rdx,%rdx
	idiv %rbx
	push %rdx

	pop %rax
	mov %rax,-16(%rbp)

	mov $0, %rax
	push %rax

	pop %rbx
	mov -16(%rbp),%rax
	cmp %rax,%rbx
	jnz LI0

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -8(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

LI0:

	dec %rcx
	jnz L0
EL0:

	add $208, %rsp
	ret
show:
	.asciz "%d\n"
showx:
	.asciz "0x%x\n"

