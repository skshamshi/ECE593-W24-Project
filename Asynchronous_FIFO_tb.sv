module tb;     
parameter DWIDTH	= 8;
parameter ADDRWIDTH = 9;
parameter BURST_SIZE = 512;
parameter NUM_BURST = 10;

logic wclk, w_enable, wrst_n;
logic rclk, r_enable, rrst_n;
logic [DWIDTH-1:0]wdata;
logic [DWIDTH-1:0]rdata;
logic full, empty;
logic burst_done;

logic [DWIDTH-1:0] wdata_q[*] [BURST_SIZE] ; 
logic [DWIDTH-1:0] rdata_q[*] [BURST_SIZE] ; 


Asynchronous_FIFO FIFO(wdata, wclk, w_enable, wrst_n, rclk, r_enable, rrst_n, full, empty, rdata);

initial
	begin
		wait(wrst_n==1 && rrst_n==1);
		fork
			drive_stimulus();
			read_data();
		join_any
		repeat(1000) @(posedge rclk);
		$finish;
	end

task drive_stimulus();
	for(int i=0; i<NUM_BURST; i++)
		begin
			for(int j=0; j<BURST_SIZE; j++)
				begin
					wdata_q[i][j] = $urandom_range(0,255);
					drive(wdata_q[i][j]);
				end
		end
endtask

task drive(logic [DWIDTH-1:0] driving_data);
	while(w_enable==0)
		begin
			wdata <= 'z;
			@(posedge wclk);
		end
	wdata <= driving_data;
	@(posedge wclk);				
endtask

task read_data();
	int burst_id, packet_id; 
	burst_done = 0;
	repeat (4) @(negedge rclk);
	forever begin
		@(posedge rclk);
			if(r_enable) begin
			@(negedge rclk);
				rdata_q[burst_id][packet_id] = rdata;
				burst_done = (packet_id == BURST_SIZE-1);
				
				if(burst_done) begin
					check_burst(rdata_q[burst_id], wdata_q[burst_id]);
					packet_id = 0;
					burst_id++;
					
					//repeat(2) @(posedge rclk); //idle cycles
					//burst_done = 0;
				end
					
				packet_id++;
				if (burst_id == NUM_BURST)
					$finish;
				
			end
	end
endtask

task check_burst(logic [DWIDTH-1:0]  actual_burst [BURST_SIZE], logic [DWIDTH-1:0] exp_burst [BURST_SIZE]);
	//foreach (actual_burst[i])
		//if(actual_burst[i] !== exp_burst[i]) 
			//$display("Error: Actual burst=%h, expected burst=%h",actual_burst[i], exp_burst[i]);
endtask


initial
	begin
	wclk = 0;
	forever 
		begin
		#4.2ns wclk = ~wclk;
		end
	end
	
initial
	begin
	rclk = 0;
	forever 
		begin
		#7.5ns rclk = ~rclk;
		end
	end

initial
	begin
	wrst_n = 0;
	@(posedge wclk); wrst_n = 1;
	end
	
initial
	begin
	rrst_n = 0;
	@(posedge rclk); rrst_n = 1;
	end
		
assign w_enable = wrst_n ?  !full : 0; //active-low reset
assign r_enable = rrst_n ?  !empty : 0;
//assign r_enable = rrst_n ?  (!burst_done && !empty) : 0;

endmodule