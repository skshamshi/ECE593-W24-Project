module Write_Ptr(wclk, wrst_n, w_enable, rgptr_sync, wptr, full);

parameter ADDRWIDTH = 9;
input	logic wclk, wrst_n, w_enable;
input	logic [ADDRWIDTH-1:0]rgptr_sync;
output	logic [ADDRWIDTH-1:0]wptr;
output	logic [ADDRWIDTH-1:0]wg_ptr;
output	logic full;
		logic [ADDRWIDTH-1:0]rbptr_sync;
		logic [ADDRWIDTH-1:0]wb_ptr;
		
assign full = {~wb_ptr[ADDRWIDTH-1],wb_ptr[ADDRWIDTH-2:0]} == rbptr_sync;

Binary_counter BinaryCounter(.count(wb_ptr), .clk(wclk), .rst_n(wrst_n), .enable(w_enable));

Binary_Gray BtoG(.Binary_in(wb_ptr), .Gray_out(wg_ptr));

Gray_Binary GtoB(.Gray_in(rgptr_sync), .Binary_out(rbptr_sync));

assign wptr = wb_ptr;

endmodule