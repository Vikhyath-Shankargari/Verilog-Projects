vlib work

vlog dut.v +acc
vlog wrapper.v
vlog tb.v +acc -sv

vsim work.tb
do wave.do
run -all