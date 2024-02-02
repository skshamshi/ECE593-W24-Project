module tb;

parameter DWIDTH = 9;
logic [DWIDTH-1:0]Binary_in;
logic [DWIDTH-1:0]Gray_out;

Binary_Gray BtoG(Binary_in, Gray_out);

initial
	begin
	for (int i=0; i<2**DWIDTH; i=i+1)
		begin
		Binary_in = i;
		#2;
		
		$display("Binary_in=%b, Gray_out=%b",Binary_in, Gray_out);
		end
	end
endmodule