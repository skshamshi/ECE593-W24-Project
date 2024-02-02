module Read_Ptr(rclk, rrst_n, r_enable, wgptr_sync, rptr, empty);

parameter ADDRWIDTH = 9;
input	logic rclk, rrst_n, r_enable;
input	logic [ADDRWIDTH-1:0]wgptr_sync;
output	logic [ADDRWIDTH-1:0]rptr;
output	logic [ADDRWIDTH-1:0]rg_ptr;
output	logic empty;
		logic [ADDRWIDTH-1:0]rb_ptr;
		logic [ADDRWIDTH-1:0]wbptr_sync

assign empty = wbptr_sync == rb_ptr;

Binary_counter(.count(rb_ptr), .clk(rclk), .rst_n(rrst_n), .enable(r_enable));

Binary_Gray(.Binary_in(rb_ptr), .Gray_out(rg_ptr));

Gray_Binary(.Gray_in(wgptr_sync), .Binary_out(wbptr_sync));

assign rptr = rb_ptr;

endmodule