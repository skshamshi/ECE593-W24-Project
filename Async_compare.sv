module AsynchronousCompare(aempty_n, afull_n, wptr, rptr, wrst_n);

parameter ADDRSIZE = 4;
parameter N = ADDRSIZE-1;
input	logic [N:0] wptr, rptr;
input	logic wrst_n;
output	logic aempty_n, afull_n;
		logic direction;
		logic high = 1'b1;
		logic dirset_n;
		logic dirclr_n;

assign dirset_n = ~((wptr[N]^rptr[N-1]) && ~(wptr[N-1]^rptr[N]));
assign dirclr_n = ~(((wptr[N-1]^rptr[N]) && ~(wptr[N]^rptr[N-1])) | ~wrst_n);

always_ff @(posedge high or negedge dirset_n or negedge dirclr_n)
	if 		(!dirclr_n) direction <= 1'b0;
	else if (!dirset_n) direction <= 1'b1;
	else 				direction <= high;
	
assign aempty_n	= ~((wptr == rptr) && !direction);
assign afull_n	= ~((wptr == rptr) && direction);

endmodule