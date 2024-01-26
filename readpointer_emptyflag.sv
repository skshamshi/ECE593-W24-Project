module rptr_empty(rempty, rptr, aempty_n, rinc, rclk, rrst_n);

parameter ADDRSIZE = 4;
input	logic aempty_n;
input	logic rinc, rclk, rrst_n;
output	logic rempty;
output [ADDRSIZE-1:0]	logic rptr;
		logic rempty, rempty2;
		logic [ADDRSIZE-1:0] rbin;
		logic [ADDRSIZE-1:0] rgnext, rbnext;
		
always_ff @(posedge rclk or negedge rrst_n)
	if (!rrst_n)
		begin
		rbin <= 0;
		rptr <= 0;
		end
	else
		begin
		rbin <= rbnext;
		rptr <= rgnext;
		end

// To-do:  we can instantiate grayn counter module		
assign rbnext = !rempty ? rbin + rinc : rbin;
assign rgnext = (rbnext >> 1) ^ rbnext;

always_ff @(posedge rclk or negedge aempty_n)
	if (!aempty_n) {rempty, rempty2} <= 2'b11;
	else		   {rempty, repmty2} <= {rempty2, ~aempty_n};
	
endmodule