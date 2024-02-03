vlib work
vdel -all
vlib work

vlog synchronizer.sv
#vlog synchronizer_tb.sv 
vlog Binary_counter.sv +acc
#vlog Binary_counter_tb.sv
vlog Binary_to_Gray_converter.sv 
#vlog Binary_to_Gray_converter_tb.sv
vlog Gray_to_Binary_converter.sv
#vlog Gray_to_Binary_converter_tb.sv
vlog Write_Pointer_Full.sv
vlog Read_Pointer_Empty.sv
vlog FIFO_Memory.sv
vlog Asynchronous_FIFO.sv +acc
vlog Asynchronous_FIFO_tb.sv

vsim work.tb
add wave -r *
run -all