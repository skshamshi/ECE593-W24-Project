import fifo_package::*;

class iMonitor ;
bit [8:0] no_of_pkts_recvd;
packet   pkt;
virtual top_if vif;
mailbox #(packet) mbx; //will be connected to input of scoreboard


function new (input mailbox #(packet) mbx_in,
			  input virtual top_if vif_in);
	this.mbx = mbx_in;
	this.vif = vif_in;
endfunction

task run() ;
	bit [8:0] addr;
	$display("[iMonitor]run started at time=%0t ",$time); 
	while(1) begin
		@(vif.wdata);
		pkt=new;
		pkt.data  = vif.wdata;

		mbx.put(pkt);
		no_of_pkts_recvd++;
		pkt.print();
		$display("Sent packet %0d to scoreboard at time=%0t ",no_of_pkts_recvd,$time); 
	end

$display("[iMonitor] run ended at time=%0t ",$time);//monitor will never end 
endtask

endclass
