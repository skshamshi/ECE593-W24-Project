module tb;

parameter DSIZE = 8;
parameter ASIZE = 4;

logic	[DSIZE-1 : 0]wdata;
logic	winc, rinc;
logic	wfull, rempty;
logic	wrst_n, rrst_n;
logic	[DSIZE-1 : 0]rdata;
bit		wclk = 0, rclk = 0;

logic	[DSIZE-1:0] write_queue[$];
logic	[DSIZE-1:0] wdata_verify;

AsynchronousFIFO DUT(wdata,winc,wfull,wclk,wrst_n,rdata,rinc,rempty,rclk,rrst_n);

always #5 wclk = !wclk;
always #10 rclk = !rclk;

initial 
	begin
	wrst_n = 0;
	#2 wrst_n = 1;
	#1 wrst_n = 0;
	end
	
initial
	begin
	rrst_n = 0;
	#2 rrst_n = 1;
	#1 rrst_n = 0;
	end
	
initial
	begin
		wdata = '0;
		winc = 0;
		repeat(2) @(posedge wclk);
		wrst_n = 1;
		
		for (int i=0; i<2; i=i+1)
			begin
			for(int j=0; j<32; j=j+1)
				begin
				@(posedge wclk iff !wfull);
				winc = (j%2 == 0)? 1:0;
				
				if (winc)
					begin
					wdata = $random;
					write_queue.push_front(wdata);
					end
				end
				#1us;
			end
	end
	
initial
	begin
	rinc = 0;
	rrst_n = 0;
	repeat(4) @(posedge rclk);
	rrst_n=1;
	
	for(int i=0; i<2; i=i+1)
		begin
		for(int j=0; j<32; j=j+1)
			begin
			@(posedge rclk iff !rempty);
			rinc = (j%2 == 0)? 1:0;
			if(rinc)
				begin
				wdata_verify = write_queue.pop_back();
				$display("Reading data: wdata = %h, rdata = %h",wdata_verify,rdata);
				end
			end
			#1us;
		end
		$finish;
	end
	
endmodule