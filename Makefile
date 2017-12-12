test: build
	./anyRead/test
	./anyWrite/test
	./jumpTest/test
	./regTest/test
	./stackmemory

build: anyRead/test.v anyRead/test.asm
	python assembler.py anyRead/test.asm
	python assembler.py anyWrite/test.asm
	python assembler.py jumpTest/test.asm
	python assembler.py regTest/test.asm
	iverilog -o anyRead/test anyRead/test.v
	iverilog -o anyWrite/test anyWrite/test.v
	iverilog -o jumpTest/test jumpTest/test.v
	iverilog -o regTest/test regTest/test.v
	iverilog -o stackmemory stackmemory.t.v
