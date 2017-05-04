	.global main
	.text
main:
	mov %rsp,%rbp
	sub $208,%rsp

	xor %rax,%rax
	mov %rax,-8(%rbp)

	xor %rax,%rax
	mov %rax,-16(%rbp)

	xor %rax,%rax
	mov %rax,-152(%rbp)

	xor %rax,%rax
	mov %rax,-208(%rbp)

	mov $10, %rax
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
	mov -16(%rbp), %rax
	xor %rdx,%rdx
	idiv %rbx
	push %rdx

	pop %rax
	mov %rax,-16(%rbp)

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

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -16(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	mov $0, %rax
	push %rax

	pop %rbx
	mov -16(%rbp),%rax
	cmp %rax,%rbx
	jnz LI0

	mov -8(%rbp), %rbx
	mov -152(%rbp), %rax
	add %rbx, %rax
	push %rax

	pop %rax
	mov %rax,-152(%rbp)

LI0:

	dec %rcx
	jnz L0
EL0:

	mov $99999, %rax
	push %rax

	pop %rax
	mov %rax,-208(%rbp)

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -208(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -152(%rbp), %rax
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

