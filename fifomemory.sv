module FIFOMemory(wdata,wclken,waddr,wclk,rdata,raddr);

parameter DATASIZE = ;
parameter ADDRSIZE = ;

input logic [DATASIZE-1 : 0]wdata;
input logic wclken;
input logic [ADDRSIZE-1 : 0]waddr, raddr;
input logic wclk;
output logic [DATASIZE-1]rdata;

logic [DATASIZE-1 : 0]MEM[0 : DEPTH-1];

assign rdata = MEM[raddr];

always_ff @(posedge wclk)
	begin
	if (wclken) 
		MEM[waddr] <= wdata;
	end

endmodule