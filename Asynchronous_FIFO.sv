module Asynchronous_FIFO #(parameter ADDRWIDTH = 9, parameter DWIDTH = 8) (top_if fifo_if);

logic [ADDRWIDTH-1:0]rgptr_sync, wgptr_sync;
logic [ADDRWIDTH-1:0]wg_ptr, rg_ptr;
logic [ADDRWIDTH-1:0]wptr, rptr;



Write_Ptr Producer(fifo_if.Write_Pointer_inf, rgptr_sync, wptr, wg_ptr);

FIFO_Memory Memory(fifo_if.FIFO_Memory_inf, wptr, rptr);

Read_Ptr Consumer(fifo_if.Read_ptr_inf, wgptr_sync, rptr, rg_ptr);

Synchronizer_2FF Write_read(.clk(fifo_if.rclk), .rst_n(fifo_if.rrst_n), .d_in(wg_ptr), .d_out(wgptr_sync));

Synchronizer_2FF Read_Write(.clk(fifo_if.wclk), .rst_n(fifo_if.wrst_n), .d_in(rg_ptr), .d_out(rgptr_sync));

endmodule
