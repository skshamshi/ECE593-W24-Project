module tb;     
parameter DWIDTH	= 8;
parameter ADDRWIDTH = 9;

logic wclk, w_enable, wrst_n;
logic rclk, r_enable, rrst_n;
logic [DWIDTH-1:0]wdata;
logic [DWIDTH-1:0]rdata;
logic full, empty;
int temp;


logic [DWIDTH-1:0] wdata_q[$]; 
logic [DWIDTH-1:0] written_data, expected_data; 

Asynchronous_FIFO FIFO(wdata, wclk, w_enable, wrst_n, rclk, r_enable, rrst_n, full, empty, rdata);

//always #5 wclk = ~wclk;
//always #10 rclk = ~rclk;

initial
	begin
		wclk = 0;
		forever begin
			#5ns wclk = ~wclk;
		end
	end
	
initial
	begin
		rclk = 0;
		forever begin
			#10ns rclk = ~rclk;
		end
	end

initial
	begin
	//$display("[TB, wrst_n] Write reset initial block started");
	wrst_n = 0;
	//@(posedge wclk); wrst_n = 0;
	@(posedge wclk); wrst_n = 1;
	//$display("[TB, wrst_n] Write reset initial block ended");
	end
	
initial
	begin
	//$display("[TB, rrst_n] Read reset initial block started");
	rrst_n = 0;
	//@(posedge rclk); rrst_n = 0;
	@(posedge rclk); rrst_n = 1;
	//$display("[TB, rrst_n] Read reset initial block ended");
	end
	
always @(posedge wclk)
	begin
	if(w_enable)
		begin
		wdata <= temp;
		
		wdata_q.push_back(wdata);
		end
	else wdata = 'z;
	end
	
assign w_enable = wrst_n ?  !full : 0; //active-low reset
assign r_enable = rrst_n ?  !empty : 0;
assign temp = w_enable ? temp+1 : temp;

initial	
	begin
	repeat (2000) @(posedge wclk);
	$finish;
	end
	
always @(posedge rclk)
	begin
	if(r_enable)
		begin
		written_data = rdata;
		expected_data = wdata_q.pop_front();
		if(written_data !== expected_data)
			$display(" Error: written_data=%d, rdata=%d",written_data, expected_data);
		end
	end

endmodule