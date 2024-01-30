vlib work
vdel -all
vlib work

#vlog binary_counter.sv
#vlog binary_gray_converter.sv
#vlog gray_counter.sv
vlog Asynchronous_FIFO.sv +acc
vlog fifomemory.sv
vlog Async_compare.sv
vlog readpointer_emptyflag.sv
vlog writepointer_fullflag.sv
vlog Asynchronous_FIFO_tb.sv

vsim work.tb
#add wave -r *
run -all