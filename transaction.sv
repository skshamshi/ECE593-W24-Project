
import fifo_package::*;

class packet;
 parameter DWIDTH	= 8;
 parameter ADDRWIDTH = 9;
 rand	bit [DWIDTH-1:0]data; 
 Pkt_type kind;
int reset_cycles;
 bit wrst_n, rst_n;
 
 function void print();
	$display("[packet]wdata = %0h at time = %0t", data, $time);
 endfunction
 
 function void copy(packet tmp);
	if(tmp == null) begin
		$display("[packet] Error: Null object passed to copy method ");
	end
	this.data = tmp.data;
 endfunction
 
 function bit compare (packet tmp);
	bit result;
 
	if(tmp == null) begin
		$display("[packet] Error Null object passed to compare method ");	
	end
	result = (this.data == tmp.data);
	return result;
 endfunction
endclass
