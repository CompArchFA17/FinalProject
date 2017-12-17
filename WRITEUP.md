# GPU Architecture

## Background

#### Abstract


#### Motivation


## Research

#### CPUs and Parallelization

In a simple single-threaded processor design, we mostly optimize by minimizing latency. The development of pipelined CPUs and superscalar processor designs made significant headway into this area, using sophisticated branch prediction, out-of-order execution paradigms, large caches and other single-threaded optimizations. These optimizations perform quite well for most tasks, and modern CPUs are incredibly fast as a result, but they are also fairly expensive (in area and bulk of control logic). Unfortunately, even with all of these optimizations, certain very computationally intensive tasks are still unacceptably slow on a single-threaded processor. Graphics processing has long fallen handily into this category.

This problem gave rise to the development of parallelization in processor design. Conceptually, tasks that involve a large amount of computationally independent operations can be broken up and executed on multiple processors. Of course, using multiple expensively latency-optimized processors quickly turns into a very costly endeavor, but as it turns out, we can achieve fairly remarkable results with many much cheaper (slower and smaller) processors. If every operation takes two or three times as long, but we run hundreds of operations in parallel, we trade a marginal increase in latency for enormous gains in throughput.

Effectively, we have a choice between latency-optimized cores and throughput-optimized cores, each of which shines in a different category of tasks. Things like complex conditional logic and branching is best handled in a latency-optimized context, while things like large matrix operations should ideally be throughput-optimized. Eventually, architecture designers started developing hybrid multi-core processors that contained both types of cores and could allocate tasks to each type. These eventually split into two independent dedicated processors: the latency-optimized CPU for most normal operations, and the throughput-optimized GPU for, primarily, graphics.

#### Big Ideas in Computer Graphics



#### The Shader Core

*For many of these visuals and a lot of conceptual understanding, particular credit to Kayvon Fatahalian and his excellent talk, [From Shader Code to a Teraflop: How Shader Cores Work](http://s08.idav.ucdavis.edu/fatahalian-gpu-architecture.pdf)*

![example CPU architecture](siggraph_cpu_design.PNG)

This is a simplified and abstracted model of a CPU. It includes a fetch/decode module for fetching program instructions from memory, an Arithmetic Logic Unit (ALU) to perform mathematical operations, lots of components (like the branch predictor and large data cache) to help optimize single-threaded performance, and an execution context. This is effectively a set of registers in which the current program state can be stored, including any relevant control signals, mathematical operands and calculation results.

![slimmed CPU architecture](siggraph_slimmed_design.PNG)

We can afford to lose many of these components when working in the paradigm of parallelism. Basically all of the components intended to optimize latency can be dropped; single-threaded speed is much less important than total cost, as any costs will be multiplied over many cores. We are left with a basic CPU that can fetch instructions, execute mathematical operations, and store state.

#### SIMD Processing

Particularly in the context of graphics processing, we’ll often be executing the same instruction over multiple pieces of data. The instruction fetch is a memory operation, and memory operations are very time-expensive; however, we can amortize the cost of the instruction fetch over a batch of mathematical operations. If we can fetch the instruction once, and execute it multiple times, on multiple pieces of data, on multiple ALUs in parallel, we can reduce the cost of the memory operation per piece of data processed.

![SIMD architecture](siggraph_multi_alu.PNG)

This concept is called Single Instruction, Multiple Data, or SIMD. Instead of scalar operations on scalar registers, a vector processor (with multiple ALUs, as above) can handle vector operations on vectors of registers. The simplest way to accomplish this is to have explicit vector instructions, one of which will be fetched at a time to do multiple operations. Another option is to implicitly vectorize scalar instructions in hardware. Both of these paradigms have seen use in commercial architectures, but implicit vectorization has been shown to offer a lot more flexibility, in exchange for some tricker design tradeoffs.

However, even in the simplest case of SIMD vector instructions, we can already see some of the multiplicatively compounding benefits of these several levels of parallelization.

![128 fragments on 16 streams](siggraph_16_8_parallel.PNG)
