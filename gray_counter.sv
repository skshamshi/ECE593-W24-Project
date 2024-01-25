module GrayCodeCounter(clk, reset, inc, full, empty, ptr);

input	logic clk, reset;
input	logic inc, full, empty;
output	logic [7:0] ptr;
		logic [7:0] GrayCount;
		logic [7:0] bin;
		logic [7:0] bnext, gnext;
		
BinaryCounter Bcount(.clk(clk), .reset(reset), .full(full), .empty(empty), .count(bin));

BinaryToGray BtoG(.clk(clk), .reset(reset), .BinaryIn(bnext), .GrayOut(gnext));

always_ff @(posedge clk or posedge reset)
	if (reset) GrayCount <= 0;
	else GrayCount <= gnext;
	
assign ptr = GrayCount;
	
endmodule