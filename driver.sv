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

task drive(packet pkt);
case(pkt.kind)
	RESET		: drive_reset(pkt);
	STIMULUS	: drive_stimulus(pkt);
	default		: $display("[Error] Unknown packet received in driver");
endcase
endtask

task drive_reset(packet pkt);
	$display("[Driver] Driving Reset transaction into DUT at time=%0t",$time); 
	vif.reset      <= 1'b0; //active-low reset
	repeat(pkt.reset_cycles) @(vif.cb);
	vif.reset      <= 1'b1;
	$display("[Driver] Driving Reset transaction completed at time=%0t",$time); 
endtask

task drive_stimulus(packet pkt);
	write_data(pkt);
	read_data(pkt);
endtask

task write(packet pkt);
	@(vif.cb);
	$display("[Driver] write operation started with waddr=%0d wdata=%0d at time=%0t",pkt.addr,pkt.wdata,$time);
	vif.cb.w_enable		<= 1'b1;
	vif.cb.addr			<= pkt.addr;
	vif.cb.wdata		<= pkt.wdata;
	@(vif.cb);
	vif.cb.w_enable		<= 1'b0;
	$display("[Driver] write operation ended with addr=%0d wdata=%0d at time=%0t",pkt.addr,pkt.wdata,$time);
endtask

task read(packet pkt);
	$display("[Driver] read operation started with raddr=%0d at time=%0t",pkt.addr,$time);
	vif.cb.r_enable		<= 1'b1;
	vif.cb.addr			<= pkt.addr;
	@(vif.cb);
	vif.cb.rd			<= 1'b0;
	$display("[Driver] read operation ended with raddr=%0d at time=%0t",pkt.addr,$time); 
endtask

endclass