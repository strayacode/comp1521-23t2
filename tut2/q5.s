# // Squares a number, unless its square is too big for a 32-bit integer.
# // If it is too big, prints an error message instead.

# #include <stdio.h>

# #define SQUARE_MAX 46340

# int main(void) {
#     int x, y;

#     printf("Enter a number: ");
#     scanf("%d", &x);

#     if (x > SQUARE_MAX) {
#         printf("square too big for 32 bits\n");
#     } else {
#         y = x * x;
#         printf("%d\n", y);
#     }

#     return 0;
# }

SQUARE_MAX = 46340

	.text
main:
	# x in $t0, y in $t1
	# 2 things involved:
	# 1. load any required arguments
	# 2. specify what syscall
	la $a0, number_str
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	ble $t0, SQUARE_MAX, x_le_square_max
	
	la $a0, too_big_str
	li $v0, 4
	syscall
	
	j epilogue
	
x_le_square_max:
	mul $t1, $t0, $t0
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
epilogue:
	li $v0, 0
	jr $ra
	
	.data
number_str:
	.asciiz "Enter a number: "
	
too_big_str:
	.asciiz "square too big for 32 bits\n"
