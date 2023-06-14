# char *string = "....";
# char *s = &string[0] = string;
# int   length = 0;
# while (*s != '\0') {
#    length++;  // increment length
#    s++;       // move to next char
# }

main:
	# s in $t0
	# length in $t1
	la $t0, string
	li $t1, 0
	
s_ne_0_cond:
	# *s = load the memory at the address s
	lb $t2, ($t0)
	beq $t2, 0, epilogue
	
	addi $t1, 1
	addi $t0, 1
	j s_ne_0_cond
	
epilogue:

   	.data
string:
   	.asciiz  "...."