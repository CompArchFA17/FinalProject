all: arithmetic dot matrixmultiplication data_mem load_block add_block multiplier registers multiplexer fsm prog_mem controller matrix_manager multiplier_network

clean: 
	rm arithmetic dot matrixmultiplication data_mem load_block add_block multiplier registers multiplexer fsm prog_mem controller matrix_manager multiplier_network

arithmetic: arithmetic.v arithmetic.t.v
	iverilog -Wall -o arithmetic arithmetic.t.v

dot: dot.v dot.t.v arithmetic
	iverilog -Wall -o dot dot.t.v

matrixmultiplication: matrixmultiplication.v matrixmultiplication.t.v dot
	iverilog -Wall -o matrixmultiplication matrixmultiplication.t.v

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

multiplexer: multiplexer.v multiplexer.t.v
	iverilog -Wall -o multiplexer multiplexer.t.v

prog_mem: prog_memory.v prog_memory.t.v
	iverilog -Wall -o prog_mem prog_memory.t.v

controller: controller.v controller.t.v prog_mem fsm
	iverilog -Wall -o controller controller.t.v

multiplier_network: multiplier_network.v multiplier_network.t.v multiplexer multiplier add_block
	iverilog -Wall -o multiplier_network multiplier_network.t.v

matrix_manager: matrix_manager.v matrix_manager.t.v data_mem registers load_block
	iverilog -Wall -o matrix_manager matrix_manager.t.v
