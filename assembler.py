from bitstring import Bits
import sys

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

srcLsit = ["ADD", "SUB", "JRO"]
immList = ["ADDI", "SUBI", "JROI"]

srcDst = ["MOV"]
immDst = ["MOVI"]
labelList = ["JMP", "JEZ", "JNZ", "JGZ", "JLZ"]

symbols = {}

def assemble(line):
    line = line.replace(',', '')
    if(line.startswith("NOP")):
        line = "ADD NIL"
    tokens = line.split()
    instruction = tokens[0];
    if(instruction in srcLsit or instruction in srcDst):
        source = tokens[1]
        if(source not in registers):
            instruction = instruction + "I"
    inst = Bits(uint=instructions[instruction],length = 4).bin

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
        try:
            label = Bits(uint=int(tokens[1]), length=4).bin
        except:
            label = Bits(uint=symbols[tokens[1]], length=4).bin
        pad = Bits(uint=0, length=10).bin
        return inst+label+pad
    pad = Bits(uint=0, length = 14).bin;
    return inst+pad



if __name__ == '__main__':
    infile = sys.argv[1]
    prefix = infile.split("/")[0]+"/"
    infile = open(infile, 'r')
    lines = infile.readlines()

    fName = ""
    f = None
    nLines = 0;
    currentLines = [];
    for line in lines:
        line = line.replace("\n","")
        if(line.startswith(":")):
            for line2 in currentLines:
                f.write(assemble(line2)+"\n")
            while nLines < 16 and f is not None:
                f.write(assemble("JMP 0")+"\n")
                nLines += 1
            fName = prefix+line[1:]+".dat"
            nLines = 0
            symbols = {}
            currentLines = []
            if f is not None:
                f.close()
            f = open(fName,'w')
        elif(line == ""):
            continue
        else:
            if(line.endswith(":")):
                symbols[line[:-1]]=nLines
            else:
                currentLines.append(line)
                nLines += 1

    for line2 in currentLines:
        f.write(assemble(line2)+"\n")
    while nLines < 16:
        f.write("000000000000000000\n")
        nLines += 1


    infile.close()
