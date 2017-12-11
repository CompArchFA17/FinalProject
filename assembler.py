from bitstring import Bits

NIL_ADDR  = 0
ACC_ADDR  = 1
#ports
LEFT_ADDR = 2
RIGHT_ADDR= 3
UP_ADDR   = 4
DOWN_ADDR = 5
#pseudo ports
LAST_ADDR = 6
ANY_ADDR  = 7

addresses = {"NIL": NIL_ADDR,
             "ACC": ACC_ADDR,
             "LEFT": LEFT_ADDR,
             "RIGHT": RIGHT_ADDR,
             "UP":    UP_ADDR,
             "DOWN":  DOWN_ADDR,
             "LAST":  LAST_ADDR,
             "ANY":   ANY_ADDR}

registers = ["NIL", "ACC", "LEFT", "RIGHT", "UP", "DOWN", "LAST", "ANY"];

ADDR_SIZE = 3
INST_SIZE = 18
PC_SIZE = 4

instructions = {"ADD"  :0,
                "SUB"  :1,
                "JRO"  :2,
                "MOV"  :3,
                "MOVI" :4,
                "ADDI" :5,
                "SUBI" :6,
                "JROI" :7,
                "SWP"  :8,
                "SAV"  :9,
                "NEG"  :10,
                "JMP"  :11,
                "JEZ" :12,
                "JNZ"  :13,
                "JGZ"  :14,
                "JLZ"  :15}

srcLsit = ["ADD", "SUB", "JRO", "MOV"]
immList = ["ADDI", "SUBI", "JROI", "MOVI"]

srcDst = ["MOV"]
immDst = ["MOVI"]
labelList = ["JMP", "JEZ", "JNZ", "JGZ", "JLZ"]


def assemble(line):
    line = line.replace(',', '')
    if(line == "NOP"):
        line = "ADD 0"
    tokens = line.split()
    instruction = tokens[0];
    inst = Bits(uint=instructions[instruction],length = 4).bin
    if(instruction in srcLsit):
        source = tokens[1]
        if(source not in registers):
            instruction = instruction + "I"

    if instruction in srcLsit:
        dst = Bits(uint=0, length=3).bin
        src = Bits(uint=addresses[tokens[1]],length = 3).bin
        pad = Bits(uint = 0,length = 8).bin
        return inst+dst+src+pad
    if instruction in immList:
        imm = Bits(int=int(tokens[1]), length=11).bin
        dst = Bits(uint=0, length=3).bin
        return inst+dst+imm
    if instruction in srcDst:
        src = Bits(uint=addresses[tokens[1]], length=3).bin
        dst = Bits(uint=addresses[tokens[2]], length=3).bin
        pad = Bits(uint = 0,length = 8).bin
        return inst+dst+src+pad
    if instruction in immDst:
        imm = Bits(int=int(tokens[1]), length=11).bin
        dst = Bits(uint=addresses[tokens[2]], length=3).bin
        return inst+dst+imm
    if instruction in labelList:
        label = Bits(uint=int(tokens[1]), length=4).bin
        pad = Bits(uint=0, length=10).bin
        return inst+label+pad

print(assemble("ADD 1"))
print(assemble("ADD ACC"))
print(assemble("MOV LEFT RIGHT"))
print(assemble("MOV 4 LEFT"))
print(assemble("JMP 0"))
