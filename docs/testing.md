# How to Run Tests
## Getting Started
Before being able to run tests, you must compile the verilog files.
To do this, at the command line enter the command `make` This will
compile any of the necessary verilog files to create the test executables. If a file has already been compiled and no changes have been made to it or its dependencies, the file will not be recompiled.

## Run Single Test
Enter the command
```bash
./<binary>
```

To run a single file once it has been compiled. If all unit tests pass, nothing will be printed to the terminal. A notice that one or more tests failed will be printed to the terminal otherwise.

## Run All Tests
The script `run_tests.sh` will compile and run all of the tests at once

If you are running the script for the first time, you will need to type
```bash
chmod 755 run_tests.sh
```
In order to gain permission to run the script.

Once you have gained permission run:
```bash
./run_tests.sh
```

If all tests pass, the only output to the terminal from the script will be any commands run from the makefile and any notifications about .vcd files being opened for output. Otherwise, notice that one or more tests failed will be printed to the terminal.

## Add a Test to Run
If a new testbench binary is created, it must be added to the script in order to be run. To do this, add the following lines to `run_tests.sh`:
```bash
echo "Running <binary> tests..."
./<binary>
```
## Run the integration test
The script `6by6multiply.sh` will compile and run the integration test, which tests the entire multiplier. The test works by writing the data contained at the memory addressing corresponding to the multiplied matrix to a data file. The python script `6by6multiply.sh` reads this data file and formats the data into a matrix,which is printed to the terminal. This matrix can be compared to the expected multiplication result, which is printed to the terminal by `setup_memory.py`.

If you are running the script for the first time, you will need to type
```bash
chmod 755 6by6multiply.sh
```
In order to gain permission to run the script.

Once you have gained permission run:
```bash
./6by6multiplys.sh
```
When run, you will see the input matrices (set in `setup_memory.py`) printed to the terminal along with the expected multiplication result. At the end, the actual output of the multiplier will be printed to the terminal.

# How to Edit the Makefile
## Adding build targets
To add a build target for a new testbench, add the following lines to the makefile:
```
<target_name>: <dependency> <dependency> ... <dependency>
    iverilog -Wall -o <binary_name> <file_to_compile>
```

As a style choice, the binary name should match the target name. Dependencies can either be other build targets or verilog files. An example build target might look like:

```
dot: dot.v dot.t.v arithmetic
	iverilog -Wall -o dot dot.t.v
```

In addition, the new build target must be added to the all build target at the top of the makefile, otherwise it will not be built automatically.

```
all: arithmetic dot matrixmultiplication
```

        
