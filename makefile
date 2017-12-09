all: arithmetic dot matrixmultiplication data_mem

arithmetic: arithmetic.v arithmetic.t.v
	iverilog -Wall -o arithmetic arithmetic.t.v

dot: dot.v dot.t.v arithmetic
	iverilog -Wall -o dot dot.t.v

matrixmultiplication: matrixmultiplication.v matrixmultiplication.t.v dot
	iverilog -Wall -o matmul matrixmultiplication.t.v

data_mem: data_memory.v data_memory.t.v
	iverilog -Wall -o data_mem data_memory.t.v