	.global	main

	.text
main:
	mov	$message, %rdi
	call puts
	mov	$number, %rdi
	call puts
	ret
message:
	.asciz "Hello,world"
number:
	.quad  65
