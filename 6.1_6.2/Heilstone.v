module Heilstone();
 
reg reset;
reg clock;

MCPU cpu(clock, reset);

parameter  [cpu.OPERAND_SIZE-1:0]  R0  = 0; //4'b0000
parameter  [cpu.OPERAND_SIZE-1:0]  R1  = 1; //4'b0001
parameter  [cpu.OPERAND_SIZE-1:0]  R2  = 2; //4'b0010
parameter  [cpu.OPERAND_SIZE-1:0]  R3  = 3; //4'b0011
parameter MEMORY = 256;

initial begin
  // Register starts when reset = 1 
  //(every 20 psec we will have reset)
  reset = 1;
  #20 reset = 0;
end

// The clock must always go on.
// The clock also has rythm -> equal secs in 0 and 1.
// We will make the rythm of the clock 10ps 
// We do that because we want to have 1 clock switch per reset
always begin
  #10 clock = 0; 
  #10 clock = 1; 
end

integer i;
initial begin
    
    //For each bit of memory that we have, set it to 0.
    for(i=0;i<MEMORY;i=i+1) begin
      cpu.raminst.mem[i] = 0;
    end
    
    //Initialise register R0 to 4488 we can do it from previous 6.1
    cpu.regfileinst.R[0] = 4488;
    //Initialise register R1 to 1. 
    cpu.regfileinst.R[1] = 1;
    //Initialise register R2,R3 to 2.
    cpu.regfileinst.R[2] = 0;
    cpu.regfileinst.R[3] = 0;


    
    //First we will create the: while(n!=1)
	//If R1 which is the Reg loaded with our AM is not 1 
	//Move the 1 in R2 has already done
	cpu.raminst.mem[0] = {cpu.OP_XOR, R3, R1, R0};
	//Check and after we are goin in 2 line of the programm else we break	
	cpu.raminst.mem[1] = {cpu.OP_BNZ, R3, 8'b00000010};   
    //Check if there is odd and we are going 
    cpu.raminst.mem[2] = {cpu.OP_AND, R3, R1, R0};    //here i know if R3=1 then odd 
	cpu.raminst.mem[3] = {cpu.OP_BNZ, R1 , 8'b00000110};   
	//We are doing r= r/2 by LSL >> by ( R1=1 )1 digit  
	cpu.raminst.mem[4] = {cpu.OP_LSL, R0, R0, R1};
	//Here we have done the 2nd if statement so we are backpatch in while
	cpu.raminst.mem[5] = {cpu.OP_BNZ, R1, 8'b00001001};
	//Here we are doing the 1st else r=3r+1=2r+r+1
	cpu.raminst.mem[6] = {cpu.OP_LSR, R2, R0, R1}; //R2 as temp R2= R0 << 1 same as R0 * 2
	cpu.raminst.mem[7] = {cpu.OP_ADD, R0, R2, R0}; //adding the temp
	cpu.raminst.mem[8] = {cpu.OP_ADD, R0, R0, R1}; //add 1
	//Here we have done the 2nd if statement so we are backpatch in while
	cpu.raminst.mem[9] = {cpu.OP_BNZ, R1, 8'b00000000};
    
end
endmodule