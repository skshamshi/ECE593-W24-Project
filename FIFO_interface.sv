interface top_if(input logic wclk, rclk, wrst_n, rrst_n);
    parameter DWIDTH = 8;
	
  	logic w_enable;
	logic r_enable;
	logic full, empty;   
	logic [DWIDTH-1:0] wdata, rdata;

			
modport FIFO_Memory_inf(
						input  w_enable, r_enable,
						input  full, empty,
						input  wclk, rclk,
						input  wdata,
						output rdata
						);

modport Write_Pointer_inf(
						input  wclk,
						input  wrst_n,
						input  w_enable,
						output full
						);

modport Read_ptr_inf(
						input  rclk,
						input  rrst_n,
						input  r_enable,
						output empty
						);


endinterface