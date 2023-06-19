# // C function to find the largest element in an array, recursively.
# // Returns the value of the largest element in the array.
# // 
# // array:  Array to search
# // length: Number of elements in the array
# int max(int array[], int length) {
#     // 
#     int first_element = array[0];
#     if (length == 1) {
#         // Handle the base-case of the recursion, at the end of the array.
#         return first_element;
#     } else {
#         // Recurse on the rest of the array.
#         // Finds the largest element after first_element in the array.
#         int max_so_far = max(&array[1], length - 1);
#         // Compare this element with the largest element after it in the array.
#         if (first_element > max_so_far) {
#             max_so_far = first_element;
#         }
#         return max_so_far;
#     }
# }

max:
	# array in $a0, length in $a1
	# first_element in $s0, max_so_far in $t0
	
max_prologue:
	push $ra
	push $s0
	
	# &array[0] = array
	lw $s0, ($a0)

	bne $a1, 1, length_ne_1
	
	move $v0, $s0
	j max_epilogue
	
length_ne_1:
	# // Recurse on the rest of the array.
	#         // Finds the largest element after first_element in the array.
	#         int max_so_far = max(&array[1], length - 1);
	#         // Compare this element with the largest element after it in the array.
	#         if (first_element > max_so_far) {
	#             max_so_far = first_element;
	#         }
	#         return max_so_far;
	
	# since $a0 holds &array[0]
	addi $a0, $a0, 4
	# &array[1] = &array[0] + 4
	# $a0 = &array[1]
	
	addi $a1, $a1, -1
	jal max
	
	move $t0, $v0
	
	ble $s0, $t0, first_element_le_max_so_far
	
	move $t0, $s0 # assignment
	
first_element_le_max_so_far:
	move $v0, $t0

max_epilogue:
	pop $s0
	pop $ra
	jr $ra

# some simple test code which calls max
main:
main__prologue:
	push	$ra

main__body:
	la	$a0, array
	li	$a1, 10
	jal	max			# result = max(array, 10)

	move	$a0, $v0
	li	$v0, 1			# syscall 1: print_int
	syscall				# printf("%d", result)

	li	$a0, '\n'
	li	$v0, 11			# syscall 11: print_char
	syscall				# printf("%c", '\n');

	li	$v0, 0

main__epilogue:
	pop	$ra
	jr	$ra			# return 0;


.data
array:
	.word 1, 2, 3, 4, 5, 6, 4, 3, 2, 1