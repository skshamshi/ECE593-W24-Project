class driver;
packet pkt;
mailbox #(packet) mbx;
virtual memory_if.tb vif;
bit [4:0] no_of_pkts_received;

function new (input mailbox #(packet)mbx_in, input virtual memory_if.tb vif_in);
this.mbx = mbx_in;
this.vif = vif_in;
endfunction

task run;
$display("[Driver] run started at time=%0t",$time);

while(1) begin //driver runs forever
mbx.get(pkt);
no_of_pkts_received++;
$display("[Driver] Received  %0s packet %0d from generator at time=%0t",pkt.kind,no_of_pkts_received,$time); 
drive(pkt);
$display("[Driver] Done with %0s packet %0d from generator at time=%0t",pkt.kind,no_of_pkts_received,$time);
end
endtask

endclass