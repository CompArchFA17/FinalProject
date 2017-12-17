# GPU Knowledge Log
### Alex Hoppe

## Memory Hierarchies

**Big Idea:** GPUs have orders of magnitude more performance than memory bandwidth
+ Radeon HD 5870 can do 1600 MUL-ADD/clk which requires ~20 TB/s of memory bandwidth [src](http://www.cs.cmu.edu/afs/cs/academic/class/15869-f11/www/lectures/08_mem_hierarchy.pdf)
+ PCIe bus limited to only 63 GB/s (x16) [src](https://en.wikipedia.org/wiki/PCI_Express)
+ GPUs have much more compute than memory read
	- Shaders have very high arithmetic intensity: loads of floating-point ops -> one texture lookup
	- GPU operations are mostly independent so they map well to SIMD and multi-stream processing
	- GPU memory requests are much more buffered, queued, interleaved for max reuse


## Phong Shader Operation
+ Vertex shaders act on every (visible?) vertex in the 3D model
	- example is calculating light reflection:

``` Cpp
qsampler mySamp;
Texture2D<float3>	myTex;
float3 ks;
float shinyExp;
float3 lightDir;
float3 viewDir;

float4 phongShader(float3 norm, float2 uv)
{
  float result;
  float3 kd;
	kd = myTex.Sample(mySamp, uv);
 	float spec = dot(viewDir, 2 * dot(-­lightDir, norm) * norm + lightDir);
 	result = kd * clamp(dot(lightDir, norm), 0.0, 1.0);
 	result += ks * exp(spec, shinyExp);    
  return float4(result, 1.0);            
```
```
[src](http://www.cs.cmu.edu/afs/cs/academic/class/15869-f11/www/lectures/08_mem_hierarchy.pdf)

This vector shader takes in vertex normals per vertex, then calculates the intensity of the direct reflection into the eye (specular) and also the diffuse reflection and scales them by the (color-value?) coefficients from the texture mapping.

A *Phong Shader* is an algorithm that calculates surface reflectance by using vertex normals as an approximation of a 3D surface instead of plane normals.

#### Clamp Operation
+ Clamping to [0, 1] forces the values to the nearest value if outside range.
+ Without clamping, light going away from the view could be represented

## Shader Core
+ Individual fetch unit maybe?
+ Several ALUs working on same fetch unit
+ Execution contexts (register space afaict)
+	L1 Cache
+ Texture Cache, (read-only, loaded at compile-time)

![shader_core](shader_core_ex.png)
One theoretical example of a shader core.

## Graphics Processing
[CMU lecture about *GRAPHICS* start to front](https://www.cs.cmu.edu/afs/cs/academic/class/15462-f11/www/lec_slides/lec19.pdf)

### Interleaving
Hide latency by interleaving different independent processes while they wait on memory fetches. Works like a pipeline CPU, sort of. Maximize throughput as opposed to wasting money, time and area on reducing latency.
![Hiding Latency with Interleaving](hiding_latency.png)


#### Execution Contexts
Execution contexts are basically swap spaces sized to park the entire register/execute state so it can interleave different operations

**EG:**
	16 different execution contexts means 16 different processes can be interleaved, swapping back and forth while long operations like memory reads (texture fetches) are happening. This hides latency much better than a processor with 4 contexts, say. There is an area drawback to adding more contexts: Its adds a lot of area that's taken up by *expensive & fast*-type storage.

![Multiple Execution Contexts](exec_contexts.png)
