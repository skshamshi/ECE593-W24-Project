module Binary_counter(count, clk, rst_n, enable);

parameter DWIDTH = 9;
input	logic clk, rst_n;
input	logic enable;
output	logic [DWIDTH-1:0]count;
		logic [DWIDTH-1:0]temp_count;

always_ff @(posedge clk)
	if(!rst_n)
		temp_count <= 0;
	else 
		if(enable)
			temp_count <= temp_count+1;
		else 
			temp_count <= temp_count;
		
assign count = temp_count;

endmodule