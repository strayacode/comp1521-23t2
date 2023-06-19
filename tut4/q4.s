# /**
#  * C function to multiply a matrix by a scalar.
#  * 
#  * nrows:  Number of rows in the matrix
#  * ncols:  Number of columns in the matrix
#  * M:      Matrix M
#  * factor: Scalar factor to multiply by
#  */
# void change (int nrows, int ncols, int M[nrows][ncols], int factor)
# {
#     for (int row = 0; row < nrows; row++) {
#         for (int col = 0; col < ncols; col++) {
#             M[row][col] = factor * M[row][col];
#         }
#     }
# }

change:
	# nrows in $a0, ncols in $a1, M in $a2, factor in $a3
	# row in $t0, col in $t1
	
row_lt_nrows_init:
	li $t0, 0
	
row_lt_nrows_cond:
	bge $t0, $a0, change_epilogue
	
col_lt_ncols_init:
	li $t1, 0
	
col_lt_ncols_cond:
	bge $t1, $a1, row_lt_nrows_step
	
	# M[row][col] = factor * M[row][col];
	# &M[row][col] = M + (row * (ncols * 4)) + (col * 4)
	# &M[row][col] = M + ((row * ncols) + col) * 4
	la $t2, M
	
	mul $t3, $t0, $a1 # row * ncols
	add $t3, $t3, $t1 # (row * ncols) + col
	mul $t3, $t3, 4 # ((row * ncols) + col) * 4
	add $t3, $t3, $t2 # &M[row][col]
	
	lw $t4, ($t3) # M[row][col]
	mul $t5, $t4, $a3 # factor * M[row][col]
	
	sw $t5, ($t3)
	
col_lt_ncols_step:
	addi $t1, $t1, 1
	j col_lt_ncols_cond
	
row_lt_nrows_step:
	addi $t0, $t0, 1
	j row_lt_nrows_cond
	
change_epilogue:
	jr $ra

main:
	li   $a0, 3
   	li   $a1, 4
   	la   $a2, M
   	li   $a3, 2
   	jal  change
	   
	jr $ra
	
	.data
M:  .word 1, 2, 3, 4
    .word 3, 4, 5, 6
    .word 5, 6, 7, 8