module registerfiletb();

parameter WORD_SIZE = 16; // A. from 8 to 16
parameter OPERAND_SIZE = 4;
parameter REGS_NUMBER_WIDTH = 4; // A. from 2 we changed it to 4 cause 4^4 = 16
parameter REGISTERS_NUMBER = 1 << REGS_NUMBER_WIDTH;

reg [OPERAND_SIZE-1:0] op1,op2,op3;
reg [WORD_SIZE-1:0] datatoload;
reg [1:0] regsetcmd;
reg regsetwb;

wire [WORD_SIZE-1:0] regop;
wire [WORD_SIZE-1:0] alu1; // operand 1 of alu
wire [WORD_SIZE-1:0] alu2; // operand 2 of alu

MCPU_Registerfile registerfiletb(op1, op2, op3, regop, alu1, alu2, datatoload, regsetwb, regsetcmd);

integer i;
initial begin
  
  regsetwb = 0;             // we set this signal to 0 -> unit needs NOT to act befor we set our inputs
  for(i=0; i<REGISTERS_NUMBER; i=i+1) begin 
    #2
    op1=i;                    // set operand 1 = i
    op2=i;                    // set operand 2 = i
    op3=i;                    // set operand 3 = i
    datatoload = 8'b00001111; // we load 8bit data 00001111
    regsetcmd = 00;           // our reset command is 00 -> no reset
    regsetwb = 1;             // now we set the signal to 1 -> unit needs to act now
  end
end
endmodule