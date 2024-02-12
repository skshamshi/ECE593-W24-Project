class test;
 bit [4:0] no_of_pkts;
 virtual memory_if.tb     vif;
 virtual memory_if.tb_mon_in vif_mon_in;
 virtual memory_if.tb_mon_out vif_mon_out;
 
 environment env;
  
 function new (input virtual memory_if.tb vif_in,
               input virtual memory_if.tb_mon_in vif_mon_in,
               input virtual memory_if.tb_mon_out vif_mon_out);
 	this.vif= vif_in;
 	this.vif_mon_in=vif_mon_in;
 	this.vif_mon_out=vif_mon_out;
 endfunction
 
 function void build();
 	env = new(vif,vif_mon_in,vif_mon_out,no_of_pkts);
 	env.build();
 endfunction
  
 task run ();
 	$display("[Testcase] run started at time=%0t",$time);
 	no_of_pkts= 30;
 	build();
 	env.run();
 	$display("[Testcase] run ended at time=%0t",$time);
 endtask
endclass