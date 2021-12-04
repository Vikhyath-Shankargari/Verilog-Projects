onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned -radixshowbase 1 /tb/clk
add wave -noupdate -radix unsigned -radixshowbase 1 /tb/rst
add wave -noupdate -radix ascii -radixshowbase 0 /tb/char
add wave -noupdate -radix unsigned -radixshowbase 1 /tb/eureka
add wave -noupdate -radix unsigned -radixshowbase 1 /tb/inst/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {69 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {134 ns}
