"""
Setup the memory to do a matrix multiplication with our verilog simulation

- formats matricies correctly and stores them in memory
- Sets up program memory to multiply the matricies together with our hardware
"""

import numpy as np

WORD_LEN = 5

# currently we only support 6x6 matricies
matrixA = 	[[1, 2, 3, 3, 2, 1],
		 [2, 3, 3, 2, 1, 1],
		 [1, 3, 1, 1, 2, 1],
		 [2, 1, 2, 0, 0, 1],
		 [3, 1, 0, 3, 2, 2],
		 [1, 2, 3, 2, 3, 2]]

matrixB = 	[[1, 2, 3, 3, 2, 1],
		 [2, 3, 3, 2, 1, 1],
		 [1, 3, 1, 1, 2, 1],
		 [2, 1, 2, 0, 0, 1],
		 [3, 1, 0, 3, 2, 2],
		 [1, 2, 3, 2, 3, 2]]

# format matrices to store in data memory
Astr = ''
for row in matrixA:
    for val in row:
        bin_val = bin(val)[2:]
        extended_val = '0'*(WORD_LEN-len(bin_val)) + bin_val
        Astr += extended_val + '\n'

Bstr = ''
for row in matrixB:
    for val in row:
        bin_val = bin(val)[2:]
        extended_val = '0'*(WORD_LEN-len(bin_val)) + bin_val
        Bstr += extended_val + '\n'

# get expected output and print calculation
expected = np.dot(matrixA, matrixB)

print "a:\n", np.array(matrixA)
print "\nb:\n", np.array(matrixB)
print "\nexpected result:\n", expected
print "(max: {})".format(np.amax(expected))


# write data memory
used_mem = Astr + Bstr
unused_mem = ('0'*WORD_LEN+'\n')*(1024-used_mem.count('\n'))
mem = used_mem + unused_mem[:-1]
f = open("test.dat", 'w')
f.write(mem)
f.close()

# write program memory
#	this would need to be more complicated to support larger matrices

load_8_chunks = "00000\n00001\n00010\n00011\n00100\n00101\n00110\n00111\n"
store_4_chunks = "01000\n01001\n01010\n01011\n"
multiply6by6 = load_8_chunks + store_4_chunks

full_program = multiply6by6

prog_mem = full_program + "00000\n"*(64-full_program.count('\n'))
f2 = open("prog_test.dat", 'w')
f2.write(prog_mem)
f2.close()






