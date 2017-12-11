#!/bin/bash

make

echo "Running all module tests:"

cat mem_test_data.dat > matrix_mem.dat
echo "Running data memory tests..."
./data_mem
echo "Running arithmetic tests..."
./arithmetic
echo "Running dot tests..."
./dot
echo "Running matmul tests..."
./matrixmultiplication
echo "Running load block tests..."
./load_block
echo "Running add block tests..."
./add_block
echo "Running registers tests..."
./registers
echo "Running multiplier tests..."
./multiplier
echo "Running multiplexer tests..."
./multiplexer
echo "running fsm tests..."
./fsm
echo "running program memory tests..."
./prog_mem
echo "running controller tests..."
./controller
echo "Running multiplier_network tests..."
./multiplier_network