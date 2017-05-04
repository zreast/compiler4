	.global main

	.text
main:
	mov $messge, %rdi
	call puts
	ret
message:
	.asciz "Hello, world\n"
