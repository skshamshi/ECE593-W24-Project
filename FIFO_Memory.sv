module FIFO_Memory #(parameter ADDRWIDTH = 9, parameter DWIDTH = 8) (top_if.FIFO_Memory_inf mem_if,
					input logic [ADDRWIDTH-1:0]waddr,
					input logic [ADDRWIDTH-1:0]raddr
					);

logic [DWIDTH-1:0] fifo [(2**ADDRWIDTH)-1:0];

always_ff @(posedge mem_if.wclk)
	if(mem_if.w_enable && !mem_if.full)
		fifo[waddr] <= mem_if.wdata;
	else
		fifo[waddr] <= fifo[waddr];
		
always_ff @(posedge mem_if.rclk)
	if(mem_if.r_enable && !mem_if.empty)
		mem_if.rdata <= fifo[raddr];
	else
		mem_if.rdata <= 'z;
		
endmodule
