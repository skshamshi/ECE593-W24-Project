import fifo_package::*;
typedef environment env_t;
class test;
 bit [4:0] no_of_pkts;
 virtual top_if vif;
 
 env_t env;
  
 function new (input virtual top_if vif_in);
 	this.vif= vif_in;
 endfunction
 
 function void build();
 	env = new(vif,no_of_pkts);
 	env.build();
 endfunction
  
 task run ();
 	$display("[Testcase] run started at time=%0t",$time);
 	no_of_pkts = 30;
 	build();
 	env.run();
 	$display("[Testcase] run ended at time=%0t",$time);
 endtask
endclass
