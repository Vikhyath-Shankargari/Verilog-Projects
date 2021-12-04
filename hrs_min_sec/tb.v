module tb;
reg clk, rst;
wire [4:0] hrs;
wire [5:0] mins, secs;

dut inst(hrs, mins, secs, clk, rst);

initial	clk = 0;
always #5 clk = !clk;

initial
	begin
	rst = 1;
	#2;
	rst = 0;
	#1000000;
	$finish;
	end

endmodule