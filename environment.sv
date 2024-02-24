import fifo_package::*;

class environment;
 bit [15:0] no_of_pkts;
 mailbox #(packet) gen_drv_mbox;
 mailbox #(packet) mon_in_scb_mbox;
 mailbox #(packet) mon_out_scb_mbox;
 virtual top_if vif;

 
 generator  gen;
 driver     drvr;
 iMonitor   mon_in;
 oMonitor   mon_out;
 scoreboard scb;
 //coverage   cov;
 
 function new(input virtual top_if vif_in,
 			  input bit [15:0] no_of_pkts);
 	this.vif= vif_in;
 	this.no_of_pkts=no_of_pkts;
 endfunction
 
 function void build();
 	$display("[Environment] build started at time=%0t",$time); 
 	gen_drv_mbox      = new(1);
 	mon_in_scb_mbox   = new;
 	mon_out_scb_mbox  = new;
 	gen               = new(gen_drv_mbox,no_of_pkts);
 	drvr              = new(gen_drv_mbox,vif);
 	mon_in            = new(mon_in_scb_mbox,vif);
 	mon_out           = new(mon_out_scb_mbox,vif);
 	scb               = new(mon_in_scb_mbox,mon_out_scb_mbox);
 	//cov				  = new(mon_in_scb_mbox);
 	$display("[Environment] build ended at time=%0t",$time); 
 endfunction
 
 task run ;
 	$display("[Environment] run started at time=%0t",$time); 
 	
 	fork
 		gen.run();
 		drvr.run();
 		mon_in.run();
 		mon_out.run();
 		scb.run();
 		//cov.run();
 	join_any
 	wait(scb.total_pkts_received == no_of_pkts);
 	repeat(10) @(posedge vif.wclk);
 	$display("[Environment] run ended at time=%0t",$time); 
 endtask

endclass
