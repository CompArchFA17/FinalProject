#!/bin/bash

make

echo "Running all module tests:"

echo "Running arithmetic tests..."
./arithmetic
echo "Running dot tests..."
./dot
echo "Running matmul tests..."
./matmul