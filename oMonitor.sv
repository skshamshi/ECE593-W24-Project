import fifo_package::*;

class oMonitor ;
bit [15:0] no_of_pkts_recvd;
packet   pkt;
virtual top_if vif;
mailbox #(packet) mbx; //will be connected to input of scoreboard


function new (input mailbox #(packet) mbx_in,
    input virtual top_if vif_in);
	this.mbx = mbx_in;
	this.vif = vif_in;
endfunction

task run() ;
	bit [15:0] addr;
	$display("[oMonitor] run started at time=%0t ",$time); 
	while(1) begin
		@(vif.rdata);
		pkt=new;
		//pkt.addr  = vif.cb_mon_out.addr;
		pkt.data  = vif.rdata;//read data
		
		mbx.put(pkt);
		no_of_pkts_recvd++;
		pkt.print();
		$display("[oMonitor] Sent packet %0d to scoreboard at time=%0t ",no_of_pkts_recvd,$time); 
	end

$display("[oMonitor] run ended at time=%0t ",$time);//monitor will never end 
endtask

endclass
