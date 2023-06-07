# // Simple factorial calculator - without error checking

# #include <stdio.h>

# int main(void) {
#     int n;
#     printf("n  = ");
#     scanf("%d", &n);

#     int fac = 1;
#     for (int i = 1; i <= n; i++) {
#         fac *= i;
#     }

#     printf("n! = %d\n", fac);
#     return 0;
# }

main:
	# n in $t0
	# fac in $t1
	# i in $t2
	la $a0, n_eq_str
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 1
	
i_le_n_init:
	li $t2, 1
	
i_le_n_cond:
	bgt $t2, $t0, epilogue
	
i_le_n_body:
	# fac = fac * i
	mul $t1, $t1, $t2
	
i_le_n_step:
	# i++
	# i = i + 1
	addi $t2, 1
	j i_le_n_cond
	
epilogue:
	la $a0, n_ne_str
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $v0, 0
	jr $ra
	
	.data
n_eq_str:
	.asciiz "n  = "
n_ne_str:
	.asciiz "n! = "