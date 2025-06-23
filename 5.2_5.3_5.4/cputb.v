module cputb();

// Registers 
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
    
    // Initialise registers to 0.
    cpu.regfileinst.R[0]=0;
    cpu.regfileinst.R[1]=0;
    cpu.regfileinst.R[2]=0;
    cpu.regfileinst.R[3]=0;     
    
    // INSTRUCTIONS TO MEMORY
    //Load 4488 to registers R0,R1
    //0: R0 = 44 and R1 = 88
    cpu.raminst.mem[0] = {cpu.OP_SHORT_TO_REG, R0, 8'b00101100};
    cpu.raminst.mem[1] = {cpu.OP_SHORT_TO_REG, R1, 8'b01011000};
    
    //Store the contents of registers R0,R1 to memory
    cpu.raminst.mem[2] = {cpu.OP_STORE_TO_MEM, R0, 8'b00101100};
    cpu.raminst.mem[3] = {cpu.OP_STORE_TO_MEM, R1, 8'b01011000};
	
    //Load the contents we just stored from memory to the rest of the registers.
    cpu.raminst.mem[4] = {cpu.OP_LOAD_FROM_MEM, R2, 8'b00101100};
    cpu.raminst.mem[5] = {cpu.OP_LOAD_FROM_MEM, R3, 8'b01011000};
    
    //Now perform ADD and XOR with our data.
    //We will use R0 and R1 registers to store the results, 
    //since we have no use of their previous values.
    //R0 = R2 ADD R3 and R0 = R2 XOR R3
    cpu.raminst.mem[6] = {cpu.OP_ADD, R0, R2, R3};
    cpu.raminst.mem[7] = {cpu.OP_XOR, R1, R2, R3};
	
end
endmodule