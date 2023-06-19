# // This program prints out a danish flag, by
# // looping through the rows and columns of the flag.
# // Each element inside the flag is a single character.
# // (i.e., 1 byte).
# //
# // (Dette program udskriver et dansk flag, ved at
# // sløjfe gennem rækker og kolonner i flaget.)
# //

# #include <stdio.h>

# #define FLAG_ROWS 6
# #define FLAG_COLS 12

# char flag[FLAG_ROWS][FLAG_COLS] = {
#     {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'},
#     {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'},
#     {'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'},
#     {'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'},
#     {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'},
#     {'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'}
# };

# int main(void) {
#     for (int row = 0; row < FLAG_ROWS; row++) {
#         for (int col = 0; col < FLAG_COLS; col++) {
#             printf("%c", flag[row][col]);
#         }
#         printf("\n");
#     }
# }

FLAG_ROWS = 6
FLAG_COLS = 12

main:
	# row in $t0, col in $t1
	
row_lt_flag_rows_init:
	li $t0, 0
	
row_lt_flag_rows_cond:
	bge $t0, FLAG_ROWS, epilogue
	
col_lt_flag_cols_init:
	li $t1, 0
	
col_lt_flag_cols_cond:
	bge $t1, FLAG_COLS, row_lt_flag_rows_step
	
	# printf("%c", flag[row][col]);
	# &flag[row][col] = flag + (row * sizeof(each row)) + (col * sizeof(each element))
	# sizeof(each row) = number of colums * sizeof(each element)
	# &flag[row][col] = flag + ((row * FLAG_COLS) + col) * sizeof(each element)
	la $t2, flag
	mul $t3, $t0, FLAG_COLS # (row * FLAG_COLS)
	add $t3, $t3, $t1 # (row * FLAG_COLS) + col
	add $t4, $t2, $t3 # &flag[row][col]
	
	lb $t5, ($t4) # flag[row][col]
	
	li $v0, 11
	move $a0, $t5
	syscall
	
col_lt_flag_cols_step:
	addi $t1, $t1, 1
	j col_lt_flag_cols_cond
	
row_lt_flag_rows_step:
	li $v0, 11
	li $a0, '\n'
	syscall
	
	addi $t0, $t0, 1
	j row_lt_flag_rows_cond
	
epilogue:
	jr $ra	

	.data
flag:
    .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#',
    .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#',
    .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
    .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.',
    .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#',
    .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'