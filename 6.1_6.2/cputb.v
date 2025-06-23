module MCPUtb();


reg reset, clk;


MCPU cpuinst (clk, reset);


initial begin
  reset=1;
  #10  reset=0;
end

always begin
  #5 clk=0; 
  #5 clk=1; 
end


/********OUR ASSEMBLER*****/

integer file, i;
reg[cpuinst.WORD_SIZE-1:0] memi;
parameter  [cpuinst.OPERAND_SIZE-1:0]  R0  = 0; //4'b0000
parameter  [cpuinst.OPERAND_SIZE-1:0]  R1  = 1; //4'b0001
parameter  [cpuinst.OPERAND_SIZE-1:0]  R2  = 2; //4'b0010

initial
begin

    for(i=0;i<256;i=i+1)
    begin
      cpuinst.raminst.mem[i]=0;
    end
    cpuinst.regfileinst.R[0]=0;
    cpuinst.regfileinst.R[1]=0;
    cpuinst.regfileinst.R[2]=0;     
   
	
    
    //Initialise registers R0,R1 to 4488
    
	cpuinst.regfileinst.R[0]=4488;
    cpuinst.regfileinst.R[1]=4488;
    
    //Initialise R2 to 2 for the shift.
    cpuinst.regfileinst.R[2]=2;   
    
    //Instraction
    //Logical shift left BY 2 R0 with R2 (that is 2)
    cpuinst.raminst.mem[0] = {cpuinst.OP_LSL, R0, R0, R2};
    //Logical shift right BY 2 R1 with R2 (that is 2)
    cpuinst.raminst.mem[1] = {cpuinst.OP_LSR, R1, R1, R2};
    

end

endmodule