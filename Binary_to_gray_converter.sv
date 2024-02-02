module Binary_Gray(Binary_in, Gray_out);

parameter DWIDTH = 9;
input	logic [DWIDTH-1:0]Binary_in;
output	logic [DWIDTH-1:0]Gray_out;

assign Gray_out[DWIDTH-1] = Binary_in[DWIDTH-1];

generate
genvar i;
	for(i=0; i<DWIDTH-1; i=i+1)
		begin
		assign Gray_out[i] = Binary_in[i+1] ^ Binary_in[i];
		end
endgenerate

endmodule