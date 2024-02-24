import fifo_package::*;

class driver;
 packet pkt;
 mailbox #(packet) mbx;
 virtual top_if vif;
 bit [4:0] no_of_pkts_received;
 
 function new (input mailbox #(packet)mbx_in, input virtual top_if vif_in);
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
 	vif.wrst_n      <= 1'b0; //active-low reset
	vif.rrst_n		<= 1'b0;
 	repeat(2) @(posedge vif.wclk);
 	vif.wrst_n      <= 1'b1;
 	vif.rrst_n      <= 1'b1;
	
 	$display("[Driver] Driving Reset transaction completed at time=%0t",$time); 
 endtask
 
 task drive_stimulus(packet pkt);
 	write_data(pkt);
 	read_data(pkt);
 endtask
 
 task write_data(packet pkt); //generating 30 burst
	//for(int BURST=0; BURST<30; BURST++);
		@(posedge vif.wclk);
		$display("[Driver] write operation started with wdata=%0d at time=%0t",pkt.data,$time);
		vif.w_enable		<= 1'b1;
		vif.wdata		    <= pkt.data;
		@(posedge vif.wclk);
		vif.w_enable		<= 1'b0;
		$display("[Driver] write operation ended with wdata=%0d at time=%0t",pkt.data,$time);
 endtask
 
 task read_data(packet pkt);
	@(posedge vif.rclk);
 	$display("[Driver] read operation started with  at time=%0t",$time);
 	vif.r_enable		<= 1'b1;
	vif.rdata			<= pkt.data;
 	@(posedge vif.rclk);
 	vif.r_enable		<= 1'b0;
 	$display("[Driver] read operation ended with at time=%0t",$time); 
 endtask

endclass
