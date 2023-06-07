main:
	# x in $t0, y in $t1
	la $a0, number_str
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	# $v0 contains the scanned value
	move $t0, $v0
	
	mul $t1, $t0, $t0
	
	# syscall to print_int
	li $v0, 1
	move $a0, $t1
	syscall
	
	# syscall to print_char
	li $v0, 11
	li $a0, '\n'
	syscall
	
	li $v0, 0
	jr $ra
	
	.data
number_str:
	.asciiz "Enter a number: "
	