module BinaryToGray(clk, reset, BinaryIn, GrayOut);

input  logic	clk, reset;
input  logic	[7:0] BinaryIn;
output logic	[7:0] GrayOut;

assign GrayOut[7] = BinaryIn[7];

generate
genvar i;
	for(i=0; i<=6; i=i+1)
		begin
		assign GrayOutt[i] = BinaryIn[i+1] ^ BinaryIn[i];
		end
endgenerate

endmodule