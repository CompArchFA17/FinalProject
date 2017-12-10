all: arithmetic dot matrixmultiplication data_mem load_block add_block multiplier registers

arithmetic: arithmetic.v arithmetic.t.v
	iverilog -Wall -o arithmetic arithmetic.t.v

dot: dot.v dot.t.v arithmetic
	iverilog -Wall -o dot dot.t.v

matrixmultiplication: matrixmultiplication.v matrixmultiplication.t.v dot
	iverilog -Wall -o matmul matrixmultiplication.t.v

data_mem: data_memory.v data_memory.t.v
	iverilog -Wall -o data_mem data_memory.t.v

load_block: load_block.v load_block.t.v data_mem
	iverilog -Wall -o load_block load_block.t.v

add_block: add3by3.v add3by3.t.v
	iverilog -Wall -o add_block add3by3.t.v

registers: registers.v registers.t.v
	iverilog -Wall -o registers registers.t.v

multiplier: multiplier.v multiplier.t.v registers matrixmultiplication
	iverilog -Wall -o multiplier multiplier.t.v

fsm: fsm.v fsm.t.v
	iverilog -Wall -o fsm fsm.t.v
