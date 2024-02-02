module FIFO_Memory(wdata, waddr, wclk, w_enable, full, rclk, raddr, r_enable, empty, rdata);

parameter DWIDTH = 8;
parameter ADDRWIDTH = 9;
input	logic w_enable, r_enable;
input	logic full, empty;
input	logic wclk, rclk;
input	logic [DWIDTH-1:0]wdata;
input	logic [ADDRWIDTH-1:0]waddr, raddr;
output	logic [DWIDTH-1:0]rdata;

		logic [DWIDTH-1:0] fifo [2**ADDRWIDTH-1:0];

always_ff @(posedge wclk)
	if(w_enable && !full)
		fifo[waddr] <= wdata;
	else
		fifo[waddr] <= fifo[waddr];
		
always_ff @(posedge rclk)
	if(r_enable && !empty)
		rdata <= fifo[raddr];
	else
		rdata <= 'z;
		
endmodule