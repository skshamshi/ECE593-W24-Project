module Write_Ptr #(parameter ADDRWIDTH = 9, parameter DWIDTH = 8) (top_if.Write_Pointer_inf wr_if, 
					input	logic [ADDRWIDTH-1:0]rgptr_sync,
					output	logic [ADDRWIDTH-1:0]wptr,
					output	logic [ADDRWIDTH-1:0]wg_ptr	
					);

logic [ADDRWIDTH-1:0]rbptr_sync;
logic [ADDRWIDTH-1:0]wb_ptr;
	
assign wr_if.full = wr_if.wrst_n ? ({~wb_ptr[ADDRWIDTH-1],wb_ptr[ADDRWIDTH-2:0]} == rbptr_sync) : 0;

Binary_counter BinaryCounter(.count(wb_ptr), .clk(wr_if.wclk), .rst_n(wr_if.wrst_n), .enable(wr_if.w_enable));

Binary_Gray BtoG(.Binary_in(wb_ptr), .Gray_out(wg_ptr));

Gray_Binary GtoB(.Gray_in(rgptr_sync), .Binary_out(rbptr_sync));

assign wptr = wb_ptr;

endmodule
