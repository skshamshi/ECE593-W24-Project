module Asynchronous_FIFO(wdata, wclk, w_enable, wrst_n, rclk, r_enable, rrst_n, full, empty, rdata);

parameter DWIDTH	= 8;
parameter ADDRWIDTH = 9;

input	logic wclk, w_enable;
input	logic rclk, r_enable;
input	logic [DWIDTH-1:0]wdata;
input	logic wrst_n, rrst_n;
output	logic [DWIDTH-1:0]rdata;
output	logic full, empty;
		logic [ADDRWIDTH-1:0]waddr, raddr;
		logic [ADDRWIDTH-1:0]rgptr_sync, wgptr_sync;
		logic [ADDRWIDTH-1:0]wg_ptr, rg_ptr;
		logic [ADDRWIDTH-1:0]wptr, rptr;
		

Write_Ptr Producer(.wclk(wclk), .wrst_n(wrst_n), .w_enable(w_enable), .rgptr_sync(rgptr_sync), .wg_ptr(wg_ptr), .wptr(wptr), .full(full));

FIFO_Memory Memory(.wdata(wdata), .waddr(wptr), .wclk(wclk), .w_enable(w_enable), .full(full), .rclk(rclk), .raddr(rptr), .r_enable(r_enable), .empty(empty), .rdata(rdata));

Read_Ptr Consumer(.rclk(rclk), .rrst_n(rrst_n), .r_enable(r_enable), .wgptr_sync(wgptr_sync), .rg_ptr(rg_ptr), .rptr(rptr), .empty(empty));

Synchronizer_2FF Write_read(.clk(rclk), .rst_n(rrst_n), .d_in(wg_ptr), .d_out(wgptr_sync));

Synchronizer_2FF Read_Write(.clk(wclk), .rst_n(wrst_n), .d_in(rg_ptr), .d_out(rgptr_sync));

endmodule