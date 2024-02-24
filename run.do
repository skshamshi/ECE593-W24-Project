vlib work
vdel -all
vlib work

vlog FIFO_interface.sv
vlog synchronizer.sv
vlog Binary_counter.sv
vlog Binary_to_Gray_converter.sv 
vlog Gray_to_Binary_converter.sv
vlog Write_Pointer_Full.sv
vlog Read_Pointer_Empty.sv
vlog FIFO_Memory.sv
vlog Asynchronous_FIFO.sv
#vlog Asynchronous_FIFO_tb.sv
vlog package.sv
vlog transaction.sv
vlog generator.sv
vlog driver.sv
vlog iMonitor.sv
vlog oMonitor.sv
vlog scoreboard.sv
vlog environment.sv
vlog test.sv
#vlog programblock.sv
vlog top.sv

vsim work.top
add wave -r *
run -all
