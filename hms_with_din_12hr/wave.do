onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb/clk
add wave -noupdate -radix unsigned /tb/am_pm_bar
add wave -noupdate -radix unsigned /tb/hrs
add wave -noupdate -radix unsigned /tb/min
add wave -noupdate -radix unsigned /tb/sec
add wave -noupdate -radix unsigned /tb/din
add wave -noupdate -radix unsigned /tb/addr
add wave -noupdate -radix unsigned /tb/ss
add wave -noupdate -radix unsigned /tb/sel
add wave -noupdate -radix unsigned /tb/inc
add wave -noupdate -radix unsigned /tb/dec
add wave -noupdate -radix unsigned /tb/load
add wave -noupdate -radix unsigned /tb/state_txt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {518 ns} {1018 ns}
