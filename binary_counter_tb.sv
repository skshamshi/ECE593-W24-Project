module tb;

bit clk = 0, reset;
logic [7:0]count;

BinaryCounter BC (clk, reset, count);

initial
	begin
	reset=0;
	#2;
	reset=1;
	#1;
	reset=0;
	end
	
initial
	begin
	clk=0;
	repeat (3000)
		begin
		clk=!clk;#5;
		end
	end

endmodule