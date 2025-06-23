module MCPU_Alutb();

parameter CMD_SIZE=2;
//word size 5.A -> 2 , 5.2A -> 8
//parameter WORD_SIZE=2;
parameter WORD_SIZE=8;

reg [CMD_SIZE-1:0] opcode;
reg [WORD_SIZE-1:0] r1;
reg [WORD_SIZE-1:0] r2;
wire [WORD_SIZE*2-1:0] out;
wire OVERFLOW;

MCPU_Alu #(.CMD_SIZE(CMD_SIZE), .WORD_SIZE(WORD_SIZE)) aluinst (opcode, r1, r2, out, OVERFLOW);

reg [CMD_SIZE-1:0] my_opcode;
reg [WORD_SIZE-1:0] my_r1;
reg [WORD_SIZE-1:0] my_r2;
reg iscorrect;

always begin #2
  //in my opcode we have the logical expreation about what we will do 
  //we check about it
  //my opcode = op code = 00 -> AND ,01 -> OR,10 ->XOR,11 -> ADD  
  if( my_opcode[0] == 0 && my_opcode[1] == 0 && out[WORD_SIZE-1:0] == (my_r1 & my_r2)) begin 
    iscorrect=1;
  end else if( my_opcode[0] == 1 && my_opcode[1] == 0 && out[WORD_SIZE-1:0] == (my_r1 | my_r2)) begin
     iscorrect=1;
   end else if( my_opcode[0] == 0 && my_opcode[1] == 1 && out[WORD_SIZE-1:0] == (my_r1 ^ my_r2)) begin
     iscorrect=1;
   end else if( my_opcode[0] == 1 && my_opcode[1] == 1 && {OVERFLOW,out[WORD_SIZE-1:0]} == (my_r1 + my_r2)) begin 
   iscorrect=1;  
   end else begin
   iscorrect=0;
  end
    
  my_opcode=opcode;
  my_r1=r1;
  my_r2=r2;
   
end

// Testbench code goes here
//5.2 A 
//always #2 r1[0] = $random;
//always #2 r2[0] = $random;
//always #2 r1[1] = $random;
//always #2 r2[1] = $random;

//5.2 B
always begin 
  #2 r1 = 4;
  #2 r1 = 4;
  #2 r1 = 8;
  #2 r1 = 8;
end
always begin
  #2 r2 = 4;
  #2 r2 = 4;
  #2 r2 = 8;
  #2 r2 = 8;
end

always #2 opcode[0] = $random;
always #2 opcode[1] = $random;

initial begin
  $display("@%0dns default is selected, opcode %b",$time,opcode);
end


endmodule