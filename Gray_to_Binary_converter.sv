module Gray_Binary(Gray_in, Binary_out);

parameter DWIDTH = 9;
input	logic [DWIDTH-1:0]Gray_in;
output	logic [DWIDTH-1:0]Binary_out;

assign Binary_out[DWIDTH-1] = Gray_in[DWIDTH-1];

generate
genvar i;
	for(i=0; i<DWIDTH-1; i=i+1)
		begin
		assign Binary_out[i] = Binary_out[i+1] ^ Gray_in[i];
		end
endgenerate

endmodule