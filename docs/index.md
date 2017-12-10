# Matrix Multiplication

## Abstract

For our Computer Architecture final project, we designed computer hardware to multiply two matricies (final constrints here). Matrix multiplication is a complex and time intensive opperation for normal computer architectures becuase there are a large number of individual computations; however, it is used frequently for machine learning and ???. Because each value in the result matrix can be computed independently from any other result, matrix multiplication is an excellent candidate for parallelization. We wanted to explore the potential efficiency gain from using a purpose built matrix multiplier, and see how a computer architecture which splits a work load among a large number of computing units would actually work.

## Project Motivation and Background

After studying single cycle MIPS CPUs, we were interested in other computing architectures with different strengths and weakenesses. We first looked at GPUs, which were originally designed specifically for graphics, but have recently been generalized to be fully functional CPUs. Graphics opperations are essentially a subset of matrix opperations (where the :With this added functionallity, GPUs have become increasingly usefull for machine learning algorithms and general parallel computing. Mostly, computations on matricies are complex and time intensive on normal CPUs, but the extreme parallelization of computations in a GPU makes it much more efficient at these opperations. We wanted to explore this increase in efficiency by making some purpose built hardware for matrix multiplication.

## Results

## Similarities to Graphics

As we mentioned before, graphics operations are essentially a subset of matrix opperations. 

## Appendix
