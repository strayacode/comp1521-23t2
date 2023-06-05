# // Print every third number from 24 to 42.
# #include <stdio.h>

# int main(void) {
#     // This 'for' loop is effectively equivalent to a while loop.
#     // i.e. it is a while loop with a counter built in.
#     for (int x = 24; x < 42; x += 3) {
#         printf("%d\n", x);
#     }
# }

main:
	# x in $t0
	# 1. initialisation step
	# 2. condition check
	# 3. body of the for loop
	# 4. increment x += 3
	# 5. jump back to the condition check
	
x_lt_42_init:
	li $t0, 24

x_lt_42_cond:
	bge $t0, 42, epilogue
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	addi $t0, 3
	j x_lt_42_cond
	
epilogue:
	jr $ra
	