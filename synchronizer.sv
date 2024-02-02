module Synchronizer_2FF(clk,rst_n,d_in,d_out);

parameter DWIDTH = 9;
input	logic clk, rst_n;
input	logic [DWIDTH-1:0]d_in;
output	logic [DWIDTH-1:0]d_out;
		logic [DWIDTH-1:0]temp_out;
		
always_ff @(posedge clk)
	if(!rst_n)
		begin
		temp_out <= 0;
		d_out	 <= 0;
		end
	else
		begin
		temp_out <= d_in;
		d_out	 <= temp_out;
		end
		
endmodule