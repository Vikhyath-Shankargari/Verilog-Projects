vlib work

vlog dut.v
vlog tb.v +acc

vsim work.tb
do wave.do
run -all