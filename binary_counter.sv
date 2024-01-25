module BinaryCounter(clk, reset, full, empty, count);

input	logic clk, reset;
input	logic full, empty;
output	logic [7:0]count;
		logic [7:0]TempCount;
		logic [7:0]Din;
		logic Inc_value;

always_ff @(posedge clk or posedge reset)
	if (reset) TempCount <= 0;
	else TempCount <= Din;

assign Inc_value = inc & (!full | !empty);	
assign Din = (TempCount == 8'd238)? 0 : TempCount + Inc_value ;
assign count = TempCount;

endmodule