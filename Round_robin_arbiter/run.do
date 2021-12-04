vlib work

vlog dut.v 
vlog tb.v +acc -sv

vsim work.tb
do wave.do
run -all