module wptr_full (wfull, wptr, afull_n, winc, wclk, wrst_n);

parameter ADDRSIZE = 4;
input	logic afull_n;
input	logic winc, wclk, wrst_n;
output	logic wfull;
output	logic [ADDRSIZE-1:0] wptr;
		logic [ADDRSIZE-1:0] wbin;
		logic wfull2;
		logic [ADDRSIZE-1:0] wgnext, wbnext;
		
always_ff @(posedge wclk or negedge wrst_n)
	if (!wrst_n)
		begin
		wbin <= 0;
		wptr <= 0;
		end
	else
		begin
		wbin <= wbnext;
		wptr <= wgnext;
		end
		
assign wbnext = !wfull ? wbin + winc : wbin;
assign wgnext = (wbnext >> 1) ^ wbnext;

//instantiate gray counter module
GrayCodeCounter GCCW(.clk(wclk), .reset(wrst_n), .inc(winc), .empty(wfull), .ptr(wptr));

always_ff @(posedge wclk or negedge wrst_n or negedge afull_n)
	if		(!wrst_n)	{wfull,wfull2} <= 2'b00;
	else if	(!afull_n)	{wfull,wfull2} <= 2'b11;
	else				{wfull,wfull2} <= {wfull2,~afull_n};
	
endmodule
