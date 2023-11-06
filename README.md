In this project, I have written an ARM9-based verilog code.

It can run all basic instructions without any problem. The bubble sort benchmark was run on it and worked correctly.

You can write your machine code and run it on this CPU just by changing the written instructions in the instruction memory.

It was synthesized and worked on FPGA with Quartus.

Processor specifications

1- data line width: 32 bits

2- The number of pipeline stages: 5 stages

3- number of commands: 13 commands

4- Branch delay rate: 2 stages

5- 16 general-purpose registers (register 15 is used for PC and register 14 is also used as Register Link)

6- Addressing is separated by bytes and the address space of instructions and data.

(Addresses 0 to 1023 are assigned to the ROM Program, and address 1024 onwards belongs to RAM.)

7- All jumps are defined as local and after jumping, the value of the command counter register will be as shown below.
PC=PC+ (signed_immed_24<<2) +4

8- It has the ability to detect and prevent data loss (Hazard Detection Unit) and forward them.

![image](https://github.com/Saeed-Shokoofa/CA_LAB/assets/110286119/c77ab272-7e7c-403e-a3f0-a6bebf5ff9e8)
