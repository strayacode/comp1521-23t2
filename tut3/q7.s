# // A simple program that adds 42 to each element of an array

# #define N_SIZE 10

# int main(void) {
#     int i;
#     int numbers[N_SIZE] = {0, 1, 2, -3, 4, -5, 6, -7, 8, 9};

#     i = 0;
#     while (i < N_SIZE) {
#         if (numbers[i] < 0) {
#             numbers[i] += 42;
#         }
#         i++;
#     }
# }

N_SIZE = 10

main:
        # i in $t0
        li $t0, 0
        
i_lt_n_size_cond:
        bge $t0, N_SIZE, epilogue
        
        # if check now
numbers_i_lt_0:
        # access numbers[i]:
        # 1. calculate &numbers[i] lw, sw
        # 2. obtain the numbers base address
        # 3. calculate some offset into the array
        # &numbers[i] = numbers + (i * sizeof(each element))
        
        la $t1, numbers
        
        # translate (i * sizeof(each element)) to mips
        mul $t2, $t0, 4
        
        add $t3, $t1, $t2 # &numbers[i]
        
        lw $t4, ($t3) # numbers[i]
        
        bge $t4, 0, i_lt_n_size_step
        
        # numbers[i] += 42;
        # numbers[i] = numbers[i] + 42
        addi $t4, $t4, 42
        
        # need the value (numbers[i] + 42) and address (&numbers[i])
        sw $t4, ($t3)
        
i_lt_n_size_step:
        addi $t0, $t0, 1
        j i_lt_n_size_cond
        
epilogue:
        jr $ra
        
        .data
numbers:
        .word 0, 1, 2, -3, 4, -5, 6, -7, 8, 9
        # numbers[3]
        # numbers + (3 * 4)