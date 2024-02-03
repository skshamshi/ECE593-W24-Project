module tb;

parameter DWIDTH = 9;
bit	clk=0, rst_n;
logic	enable;
logic [DWIDTH-1:0] count;

Binary_counter BC(count, clk, rst_n, enable);

always #5 clk = ~clk;

initial 
	begin
	rst_n = 0;
	@(posedge clk); rst_n = 1;
	end
	
initial
	begin
		enable = 0;
		@(posedge clk)
		enable = 1;
		repeat(20) @(posedge clk);
	$finish;
	end

endmodule
