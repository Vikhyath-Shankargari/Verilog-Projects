vlib work

vlog my_name_sequence_detector.v -sv +acc
vlog tb.v +acc

vsim work.tb
do wave.do
run -all