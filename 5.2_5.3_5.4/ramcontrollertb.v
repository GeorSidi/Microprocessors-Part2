module ramcontrollertb();

parameter WORD_SIZE = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_SIZE = 1 << ADDR_WIDTH;

reg we;
reg [WORD_SIZE-1:0] datawr;
reg re;
reg [ADDR_WIDTH-1:0] addr;
reg [ADDR_WIDTH-1:0] instraddr;
reg [WORD_SIZE-1:0] mem[RAM_SIZE-1:0];
reg [WORD_SIZE-1:0] word;
reg iscorrect;

wire [WORD_SIZE-1:0] datard;
wire [WORD_SIZE-1:0] instrrd;

MCPU_RAMController ramcontrollertb(we, datawr, re, addr, datard, instraddr, instrrd);

// Testbench code
integer i;
initial begin
  //Data write (we = 1)
  we = 1;
  for(i=0; i<RAM_SIZE; i=i+1) begin
    //#2 datawr = $random;    //generate random word
	//addr = i; 
	//#1 mem[addr] = datawr;
	
    #2 datawr = 44;		//generate my AM
    addr = i;               
    #1 mem[addr] = datawr; 
	i=i+1;
	#2 datawr = 88;		//generate my AM
    addr = i;               
    #1 mem[addr] = datawr;
	
  end
  
  //Data Read must be equal to Command Read
  //(re = 1 and we = 0 because we want no writing) 
  //if equal -> iscorrect = 1 else iscorrect = 0
  we = 0;
  re = 1;
  for(i=0; i<RAM_SIZE; i=i+1) begin
    #2 addr = i;          //address for data read = i
    instraddr = i;        //address for cmd read = i
    #1 word = mem[addr];  //get the word from data read
    if(word == datard && instrrd == mem[i]) begin
      iscorrect = 1;
    end else begin
      iscorrect = 0;
    end
  end
end
endmodule