typedef enum {IDLE,STIMULUS,RESET}Pkt_type;

class packet;
 parameter DWIDTH	= 8;
 rand	bit [DWIDTH-1:0]data;
 rand	bit w_enable;
 Pkt_type kind;
 bit reset_cycles;
 
 function void print();
	$display("[packet]wdata = %0h at time = %0t", wdata, $time);
 endfunction
 
 function void copy(packet tmp);
 if(tmp == null) begin
	$display("[packet] Error Null object passed to copy method ");
 end
 this.wdata = tmp.wdata;
 this.w_enable = tmp.w_enable;
 endfunction
 
 function bit compare (packet tmp);
 bit result;
 
 if(tmp == null) begin
	$display("[packet] Error Null object passed to compare method ");	
 end
 result = (this.wdata == tmp.wdata);
 return result;
 endfunction
endclass