#!/bin/bash
python2 setup_memory.py

cat data_test.dat > matrix_mem.dat
cat prog_test.dat > prog_mem.dat

echo "Running the BIG test..."
make
./multiplier6by6

make clean