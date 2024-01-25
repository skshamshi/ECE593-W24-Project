module tb;

logic clk = 0, reset;
logic [7:0] BinaryIn;
logic [7:0] GrayOut;

BinaryToGray BtoG(clk, reset, BinaryIn, GrayOut);

always #5 clk = ~clk;

initial
	begin
	reset = 0;
	#2; reset = 1;
	#1 reset = 0;
	end
	
initial
	begin
		for (integer i=0; i<=255; i=i+1)
			begin
			BinaryIn = i;
			#1;
			
			$display ("BinaryIn = %b, GrayOut = %b", BinaryIn, GrayOut);
			end
	$finish;
	end
endmodule