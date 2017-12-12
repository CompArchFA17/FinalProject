# Cache Replacement Policies
by David Papp and Robbie Siegel


# Introduction

In this project, we explored multiple cache replacement policies to evaluate their effectiveness for specific purposes. Caching is the process by which data is stored in a cache so that the data can be served faster in the future. It is an integral part of modern computation and CPU specs often include the size of each level of cache. Cache replacement policies decide which entries are stored in the cache. We also designed our own custom cache replacement policy and attempted to implement it using the cache simulation suite from the Cache Replacement Competition with limited success.  


# Cache Policies

We decided to study three common caching policies and their underlying algorithms. We focused not just on how they work, but the types of applications each one is suitable for and also the limitations of each one. The three replacement policies we explored were as follows: 

- Least recently used (LRU)
- Adaptive Cache Replacement (ARC)
- LIRS/MQ


## Least Recently Used (LRU)

This caching policy is based on temporal locality — what you have touched recently, you are more likely to touch again. It is one of the most widely used replacement policies and is the preferred page replacement policy. We chose to study it due to its popularity and use in ARC.

LRU is best suited for smaller caches. As the cache size expands, the additional data becomes less useful since it was accessed longer ago. This is in contrast with a random eviction policy, where the size of the cache increase should be proportional to the hit rate. However, since LRU requires greater overhead, at sufficiently large cache sizes, it loses its advantage.

The main limitation of an LRU is its high processing overhead. Unlike in a FIFO, which can be implemented with a single queue, we need additional data structures to update time stamps. In our implementation, we needed a queue as well as two maps to allow for O(1) retrieval and updates.

We found a challenging problem on Leetcode that required us to write our own implementations for an LRU. We completed this to ensure that we have an algorithmic understanding of the policy. We hoped we could later modify this to implement our own caching policy. Unfortunately, we later found this code to have almost no crossover to the CRC2 simulation suite. Our code can be found on our GitHub: https://github.com/davpapp/FinalProject/blob/master/LRUCache.cpp.


## Adaptive Cache Replacement (ARC)

This cache replacement policy is an improvement upon LRU. It is a hybrid design that consists of four parts:

  - T1: LRU
  - T2: LFU (least frequently used)
  - B1: Ghost LRU: history of recently evicted LRU entries
  - B2: Ghost LFU: history of recently evicted LFU entries
  

The policy dynamically changes the sizes of the LRU and the LFU based on which one is returning more hits. This is achieved by using the ghost lists act as scorecards by tracking the history of items evicted from each cache. Items enter T1 and T2 just as they would enter an LRU and LFU, respectively. Evicted items are put into the respective ghost list. Hits in these ghost lists will change the size of T1 and T2.
A hit in B1 will increase the size of T1 and decrease the size of T2. The last item in T2 will be evicted into B2. Conversely, a hit in B2 will increase the size of T2 and decrease the size of T1. The last item in T1 will be evicted into B1.

![Visualisation of ARC](https://image.slidesharecdn.com/class17-inked-140401130043-phpapp02/95/flash-modern-file-systems-27-638.jpg?cb=1396357346)


ARC policies are extremely versatile and efficient. They generally outperform LRU alone and are a great general purpose policy, similar to LRU.

Since this algorithm is patented to IBM, there exist many slight variations with worse performance. We used this policy as inspiration to develop our own caching policy in theory. The dynamic sizes of the two components of the cache is extremely promising compared to having two caches of the same size. 


## Low Inter-reference Recency Set (LIRS)

Similar to ARC, LIRS is an improvement upon LRU in several ways. This caching policy centers around a data block’s reuse-distance, or inter-reference recency (IRR). Inter-reference recency measures the number of other unique blocks accessed between the two most recent references to a given block. So, a block that is accessed for the first time will have an infinite IRR. Once this block is referenced a second time, it will be given a real number IRR that is the number of unique blocks in between its first and second reference. 

![IRR and Recency of Accessed Blocks ](https://d2mxuefqeaa7sj.cloudfront.net/s_221BACEBB6F70560258E251C084525A6B643DADBF3756E049BE14C16AD544E88_1513046670562_IRR_Examples.PNG)


The above image details the IRR and recency values of 5 example blocks being accessed over ten units of time. Each ‘X’ represents a block being accessed. So for example, Block 1 has an IRR of 1 because it was most recently accessed at times 3 and 6, which have two unique blocks referenced between them. Block 5 has an infinite IRR because it is only accessed once. 

LIRS also classifies each block in the cache by its recency, which is a measure of how many unique blocks have been accessed since its last access. In the table above, Block 1 has a recency of 4 because there are four blocks accessed since its last reference. 

Each block in the cache is classified as either Low IRR (LIR) or High IRR (HIR). There is a designated number of space in the cache for each type of block. Note that all LIR blocks are in the cache, but not all HIR blocks are in the cache. HIR blocks that are in the cache are referred to as resident HIR blocks. 

This policy assumes that LIR blocks are more likely to be accessed in the near future, so it prioritizes keeping these in the cache. In the case that there are no resident HIR blocks, it will remove the block from the bottom of the LIR stack. This block will always have the highest recency value of any in the cache. 

The LIRS policy does have some overhead because it requires having two stacks. The first of these is designated S and contains all LIR and HIR blocks. The second is designated Q and contains the resident HIR blocks. When an HIR block in S is referenced again, it will become an LIR block.

When referencing a new block, there are four possibilities:

  1. It is an LIR block
  2. It is a resident HIR block in S
  3. It is a resident HIR block not in S
  4. It is a non-resident HIR block in S
  5. It is a non-resident HIR block not in S

Note that cases a, b, and c will result in hits, while cases d, e, and f will result in misses. Each case will begin by placing the newly accessed block at the top of stack S and adding it to the cache. They begin to differ after this action.

In case a, we must remove all HIR blocks from the bottom of S until an LIR block is at the bottom.

In case b, the referenced block will become an LIR block because it was already in S. It is removed from Q. 

In case c, the referenced block will not become an LIR because it was not originally in S. The LIR at the bottom of S is moved to the top of Q. 

In case d, the referenced block will become an LIR block because it was already in S. The LIR at the bottom of S is moved to the top of Q. 

In case e, the referenced block will not become an LIR because it was not originally in S. Therefore, we move it to the top of Q. 

These steps allow the implementation of an LIRS policy. 

# Our Own Cache Replacement Policy

We will design a variation of an ARC policy. ARC uses the hybrid of an LRU and an LFU. We will keep the LRU segment, but we will replace the LFU with our own segment that we will call 2-random LFU.

The 2-random LFU policy will work as follows. We will keep track of the frequencies of each item in cache and increment the frequency each time we encounter that item. To evict an item, we will choose two random values and evict the one with a lower frequency. This approach is based on a paper we read: https://danluu.com/2choices-eviction/. 

This paper proposed the idea of a 2-random policy where two random values were chosen and the one that was less recently used was evicted. We were curious to learn how evicting the less frequently used item instead of the less recently used item would affect performance. 
Below is a figure from this paper. Note that both LRU and 2-random are consistently better than random replacement. LRU outperforms 2-random for cache sizes under 256k, but 2-random takes the edge for sizes above 256k.

![Cache miss ratios for cache sizes between 64K and 16M](https://danluu.com/images/2choices-eviction/sweep-sizes-mean-ratios.png)


Our intention with the 2-random policy in place of an LFU was to balance the performance for different cache sizes. A typical ARC approach uses both an LRU and an LFU, which are are both ideal for smaller cache sizes. In contrast, random replacement improves in performance as our cache gets bigger. By swapping the LFU with a 2-random policy, were essentially hoping to diversify the strengths of our cache replacement policy. 

It is extremely hard to qualitatively predict cache performance for our hybrid design. We thus turned to an existing cache simulation software to produce quantitative results.


# Implementation 

We turned to resources from the 2nd Cache Replacement Competition (CRC2). This competition provides a suite for implementing custom cache policies and evaluating their performances. The full description for the competition can be found at http://crc2.ece.tamu.edu/, and the repository can be found at [https://github.com/ChampSim.](https://github.com/ChampSim/ChampSim) 

This simulation suite ran a trace file of 10 million commands against different caching policies. Using command line arguments, the simulation could be run with a variety of parameters including specific branch prediction algorithms, cache sizes, and number of cores. All of this was outside the scope of our project.

To get a measurement for baseline performance, we ran trials without a cache policy and another one with LRU. The metric of performance was instructions per cycle (IPC). All of our tests were run on a single core with the cache replacement policy being the only different parameter. The results are shown below:

|              | Instructions per Clock (IPC) | Instsructions | Cycles   |
| ------------ | ---------------------------- | ------------- | -------- |
| No Cache     | 0.681835                     | 10000001      | 14666312 |
| LRU          | 0.807452                     | 10000001      | 12384644 |
| 2-random LRU | 0.786255                     | 10000001      | 12718527 |
| Random       | 0.771452                     | 10000001      | 12962575 |


With no cache policy in place, the IPC was 0.681835, or about a 15.56% decrease in performance compared to an LRU.
As our MVP, we first implemented a random policy. The IPC for this was 0.771452, or about a 4.46% decrease in performance compared to an LRU.
Next, we implemented the 2-random LRU we read about earlier. This was considerably easier than implementing our custom policy. It also helped that an LRU was already implemented and thus we did not need to write our own. The IPC for this was 0.771452, or about a 2.63% decrease in performance compared to an LRU.
It was especially surprising to see how effective a simple random cache was. Of course, 4.46% likely has a huge impact on actual performance. This also assumes that the traces we tested with were representative of real CPU usage. 

Unfortunately, we were unable to implement our proposed solution. Considering the complexity of our custom design, this shouldn’t be too surprising. We began to write an LFU, but struggled to understand the code architecture well enough that we could write an efficient LRU algorithm. The code base was sparsely documented. We wrote an LRU that compiled successfully but consistently seg-faulted during simulation so we were unable to obtain results. Due to time limitations, we accepted our fate and decided that knowledge we gained from designing our custom policy was more relevant to computer architecture than the software implementation aspect. If we had more time, we would have worked more on getting this part working. 

Our code  for the simulation can be found on a GitHub repo (separate from our Final Project repo): https://github.com/davpapp/ChampSim.

