#!/bin/bash

make

echo "----------Running all module tests:----------"

echo "	Running arithmetic tests..."
./arithmetic

echo "	Running dot tests..."
./dot

echo "	Running matrixmultiplication tests..."
./matrixmultiplication

cat mem_test_data.dat > matrix_mem.dat
echo "	Running data_mem tests..."
./data_mem

echo "	Running load_block tests..."
./load_block

echo "	Running add_block tests..."
./add_block

echo "	Running multiplier tests..."
./multiplier

echo "	Running registers tests..."
./registers

echo "	Running multiplexer tests..."
./multiplexer

echo "	Running fsm tests..."
./fsm

cat prog_mem_unit_test.dat > prog_mem.dat
echo "	Running prog_mem tests..."
./prog_mem

echo "	Running controller tests..."
./controller

cat matrix_manager_test.dat > matrix_mem.dat
echo "	Running matrix_manager tests..."
./matrix_manager

echo "	Running multiplier_network tests..."
./multiplier_network

make clean
