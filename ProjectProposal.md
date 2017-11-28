# GPU Matrix Operations
### Ariana Olson, Rocco DiVerdi, Serena Chen

We want to study GPU architectures, and build a simple one to do matrix operations. We want to understand the strategy for multiplying matrices in the GPU, and how the GPU is programmed to perform these operations. We will also build a small toy matrix multiplier module in verilog, which can be scaled in scope depending on how much time the previous parts of the project take.

## References:

[Understanding the Efficiency of GPU Algorithms for Matrix-Matrix Multiplication](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.1.6823&rep=rep1&type=pdf)

[Matrix computations on the GPU](https://developer.nvidia.com/sites/default/files/akamai/cuda/files/Misc/mygpu.pdf) 

[Matrix Multiplication with CUDA — A basic introduction to the CUDA programming model](https://www.shodor.org/media/content/petascale/materials/UPModules/matrixMultiplication/moduleDocument.pdf)

[some random project from somewhere making a GPU](https://courses.cs.washington.edu/courses/cse467/15wi/docs/prj1.pdf)

## MVP: 

Present to class about how GPUs perform matrix multiplication and other operations. And how it compares to MIPS CPU.

Planned: Build a toy processor that performs operations and prints results to the terminal.

Stretch: Visualize real time matrix transformations for a small set of “pixels”

Super Stretch: be hired by Nvidia

Even more super stretch: start a GPU company and make Nvidia obsolete 

## Work Plan:

Thanksgiving break: sleep

11/27-12/3: Learn about matrix multiplication on GPUs, run some example programs on actual GPUs. Set up documentation framework. Start writing up explanations of what we have learned.

12/4-12/10: Start implementing verilog modules. Create documentation on performance, how to run tests/examples, block diagrams, etc.

12/10-12/14: Debugging, polishing, documenting. (try not to be dead)
