# Microprocessors-Part2

## Lab 5

### 5.1 Conformity with MCPU
Introduction to designing hardware components of a microprocessor called MicroCPU (MCPU) in ModelSim

*minor changes d1s4488.v, d1s4488tb.v and 1s4488tb2.v

### 5.2 Conformity with the ALU of MCPU
Using the file alutb.v as a basis, a new testbench was created to simulate and test the functionality of the ALU (Arithmetic Logic Unit) of the MCPU

*changes in alutb.v

### 5.3 Conformity with the Memory of MCPU
A testbench was written for the memory module to confirm the correct functionality of  internal procedures with:
- random inputs
- specific input with the number 4488

*changes cputb.v and ramcontrollertb.v

### 5.4 Conformity with the Register File
Changed the MCPU to supports 16 registers and write 
44 in memory address 100 and 88 in memory address  101

*changes registerfiletb.v

## Lab 6

### 6.1 New Instructions to the MCPU
Added the new instructions
- Logical Shift Left: LSL Rd R Rn
- Logical Shift Right: LSR Rd R Rn
and tested

*changes cpu.v and cpurtb.v

### 6.2 Heilstone

A program for the MicroCPU that calculates the Heilstone:
    
    n= 15; *initian number
    while(n!=1) 
    { 
    If (n is odd) 
        n=3n+1; 
    else 
        n=n/2; 
    }
    
*changes Heilstone.v and cpurtb2.v

