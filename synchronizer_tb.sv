module tb;
bit clk = 0, rst_n;
logic [7:0]d_in;
logic [7:0]d_out;

Synchronizer_2FF S(clk,rst_n,d_in,d_out);

always #5 clk = ~clk;

initial 
	begin
	rst_n = 0;
	@(posedge clk); rst_n = 1;
	end
	
initial
	begin
	repeat(20) 
		begin
		@(posedge clk);
		d_in = $random;
		end
	repeat(20) @(posedge clk);
	$finish;
	end
	
endmodule