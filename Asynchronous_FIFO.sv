module AsynchronousFIFO(wdata,winc,wfull,wclk,wrst_n,rdata,rinc,rempty,rclk,rrst_n,full,empty);

parameter DSIZE = 8;
parameter ASIZE = 4;

input	logic [DSIZE-1 : 0]wdata;
input	logic winc, rinc;
input	logic wclk, rclk;
input	logic wrst_n, rrst_n;
output	logic wfull, rempty;
output	logic [DSIZE-1 : 0]rdata;
		logic [ASIZE-1 : 0]wptr, rptr;
		logic [ASIZE-1 : 0]waddr, raddr;

FIFOMemory Memory(.wdata(wdata),
				  .wclken(winc),
				  .waddr(wptr),
				  .wclk(wclk),
				  .raddr(rptr),
				  .rdata(rdata));
				  
WritePtr_Full wptr_full(.winc(winc),
						.wfull(wfull),
						.wclk(wclk),
						.wrst_n(wrst_n),
						.afull_n(afull_n),
						.wptr(wptr));
						
ReadPtr_Empty rptr_empty(.rptr(rptr),
						 .aempty_n(aempty_n),
						 .rrst_n(rrst_n),
						 .rinc(rinc),
						 .rempty(rempty),
						 .rclk(rclk));
						 
AsynchronousCompare Compare(.wptr(wptr),
							.wrst_n(wrst_n),
							.afull_n(afull_n),
							.aempty_n(aempty_n),
							.rptr(rptr));


endmodule
