module tb;

parameter DWIDTH = 9;
logic [DWIDTH-1:0]Gray_in;
logic [DWIDTH-1:0]Binary_out;

Gray_Binary GtoB(Gray_in, Binary_out);

initial
	begin
	for (int i=0; i<2**DWIDTH; i=i+1)
		begin
		Gray_in = i;
		#2;
		
		$display("Gray_in=%b, Binary_out=%b",Gray_in, Binary_out);
		end
	end
	
endmodule