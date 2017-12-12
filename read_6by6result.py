"""
pull out the part of memory holding the matrix
and format it as a numpy array to make it easy
to read
"""
import numpy as np


f = open("memory_out.txt")
fullstr = f.read()
f.close()

full_mem = fullstr.split('\n')
res_mem = full_mem[72:108]

matrix = []
for i in range(6):
    matrix.append([int(val) for val in res_mem[i*6:(i+1)*6]])

print np.array(matrix)
