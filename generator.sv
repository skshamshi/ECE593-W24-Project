import fifo_package::*;

class generator;
 bit [4:0] no_of_packets;
 packet pkt;
 
 mailbox #(packet)mbx;
 
 function new (mailbox #(packet) mbx_in, bit [4:0] gen_pkts_no=1);
	this.no_of_packets = gen_pkts_no;
	this.mbx		   = mbx_in;
 endfunction
 
 task run;
 bit [4:0] pkt_count;
 packet ref_packet = new;
 $display("[Generator] Run started ta time = %0t", $time);
 
 //generate first packet as Reset
 pkt = new;
 pkt.kind = RESET;
 pkt.reset_cycles = 2;
 $display("[Generator] Sending %0s packet %0d to driver at time=%0t",pkt.kind,pkt_count,$time);
 mbx.put(pkt);
 
 //generate the normal stimulus
 repeat(no_of_packets) begin
	void'(ref_packet.randomize());
	pkt = new;
	pkt.copy(ref_packet);
	pkt.kind = STIMULUS;
	mbx.put(pkt);
	pkt_count ++;
	$display("[Generator] Sent %0s packet %0d to driver at time=%0t",pkt.kind,pkt_count,$time);
 end
 $display("[Generator] Run ended at time=%0t",$time);
 endtask

endclass
