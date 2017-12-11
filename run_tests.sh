#!/bin/bash

make

echo "Running all module tests:"

cat mem_test_data.dat > matrix_mem.dat
echo "	Running data memory tests..."
./data_mem
echo "	Running arithmetic tests..."
./arithmetic
echo "	Running dot tests..."
./dot
echo "	Running matmul tests..."
./matmul
echo "	Running register tests..."
./registers
echo "	Running load block tests..."
./load_block
echo "	Running fsm tests..."
./fsm
echo "	Running program memory tests..."
./prog_mem
echo "	Running controller tests..."
./controller

make clean
