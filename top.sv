//typedef enum {STIMULUS,RESET}Pkt_type;
import fifo_package::*;
//`include "package.sv"

module top;

parameter ADDRWIDTH = 9;
parameter DWIDTH = 8;
//parameter BURST_SIZE = 512;
//parameter NUM_BURST = 10;

logic wclk, rclk;
logic wrst_n, rrst_n;
logic burst_done;

assign mem_if.wclk = wclk;
assign mem_if.rclk = rclk;
/* assign mem_if.wrst_n = wrst_n;
assign mem_if.rrst_n = rrst_n; */

test test_obj;

initial
	begin
		wclk = 0;
		forever begin
			#4.2ns wclk = ~wclk;
		end
	end
	
initial
	begin
		rclk = 0;
		forever begin
			#7.5ns rclk = ~rclk;
		end
	end

/*initial
	begin
		wrst_n = 0;
		@(posedge wclk); wrst_n = 1;
	end
	
initial
	begin
		rrst_n = 0;
		@(posedge rclk); rrst_n = 1;
	end
*/

top_if mem_if();

Asynchronous_FIFO FIFO(mem_if);
 
initial begin

test_obj=new(mem_if);
test_obj.run();
$display("[top] simulation finished at time=%0t",$time);
$finish;
end

endmodule
