module Read_Ptr #(parameter ADDRWIDTH = 9, parameter DWIDTH = 8) (top_if.Read_ptr_inf rd_if, 
				input	logic [ADDRWIDTH-1:0]wgptr_sync,
				output	logic [ADDRWIDTH-1:0]rptr,
				output	logic [ADDRWIDTH-1:0]rg_ptr
				);

	logic [ADDRWIDTH-1:0]rb_ptr;
	logic [ADDRWIDTH-1:0]wbptr_sync;

assign rd_if.empty = rd_if.rrst_n ? (wbptr_sync == rb_ptr) : 0;

Binary_counter BCount(.count(rb_ptr), .clk(rd_if.rclk), .rst_n(rd_if.rrst_n), .enable(rd_if.r_enable));

Binary_Gray BtoG(.Binary_in(rb_ptr), .Gray_out(rg_ptr));

Gray_Binary GtoB(.Gray_in(wgptr_sync), .Binary_out(wbptr_sync));

assign rptr = rb_ptr;

endmodule
