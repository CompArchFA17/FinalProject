# GPU Architecture

## Background

#### Abstract


#### Motivation


## Research

#### CPUs and Parallelization

In a simple single-threaded processor design, we mostly optimize by minimizing latency. The development of pipelined CPUs and superscalar processor designs made significant headway into this area, using sophisticated branch prediction, out-of-order execution paradigms, large caches and other single-threaded optimizations. These optimizations perform quite well for most tasks, and modern CPUs are incredibly fast as a result, but they are also fairly expensive (in area and bulk of control logic). Unfortunately, even with all of these optimizations, certain very computationally intensive tasks are still unacceptably slow on a single-threaded processor. Graphics processing has long fallen handily into this category.

This problem gave rise to the development of parallelization in processor design. Conceptually, tasks that involve a large amount of computationally independent operations can be broken up and executed on multiple processors. Of course, using multiple expensively latency-optimized processors quickly turns into a very costly endeavor, but as it turns out, we can achieve fairly remarkable results with many much cheaper (slower and smaller) processors. If every operation takes two or three times as long, but we run hundreds of operations in parallel, we trade a marginal increase in latency for enormous gains in throughput.

Effectively, we have a choice between latency-optimized cores and throughput-optimized cores, each of which shines in a different category of tasks. Things like complex conditional logic and branching is best handled in a latency-optimized context, while things like large matrix operations should ideally be throughput-optimized. Eventually, architecture designers started developing hybrid multi-core processors that contained both types of cores and could allocate tasks to each type. These eventually split into two independent dedicated processors: the latency-optimized CPU for most normal operations, and the throughput-optimized GPU for, primarily, graphics.
