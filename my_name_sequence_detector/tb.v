module tb;
reg clk, rst;
reg [7:0] char;
wire eureka;

my_name_sequence_detector inst(eureka, char, clk, rst);

initial
	begin
	clk = 0;
	rst = 0;
	char = 8'd0;
	#1;
	rst = 1;
	#1;
	rst = 0;
	end
	
always #5 clk = !clk;

initial
	begin
	#10 char = "V";
	#10 char = "I";
	#10 char = "K";
	#10 char = "V";
	#10 char = "Y";
	#10 char = "M";
	#10 char = "V";
	#10 char = "V";
	
	#10 char = "V";
	#10 char = "I";
	#10 char = "K";
	#10 char = "H";
	#10 char = "Y";
	#10 char = "A";
	#10 char = "T";
	#10 char = "H";
	
	#20;
	$finish;
	end

endmodule