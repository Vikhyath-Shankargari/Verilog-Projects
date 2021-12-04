module tb;
reg clk = 0; always #5 clk = !clk;
reg rst = 1; initial #2 rst = 0;

wire [1:0] printer;

reg rb=0, rb_NBA = 0;	
reg re=0, re_NBA = 0;	
reg ry=0, ry_NBA = 0;	

enum {BU, EU, YU, B1E2Y3, E1Y2B3, Y1B2E3} state;

always @*
begin
	case(tb.inst.state)
	0 : state = B1E2Y3;
	1 : state = BU;
	2 : state = EU;
	3 : state = YU;
	4 : state = E1Y2B3;
	5 : state = Y1B2E3;
	endcase
end

dut inst(
.printer(printer),
.rb(rb_NBA),
.re(re_NBA),
.ry(ry_NBA),
.clk(clk),
.rst(rst)
);

always @*
	{rb_NBA, re_NBA, ry_NBA} = {rb, re, ry};

integer i;
reg [2:0] mem[1:18];

initial
begin
	$readmemb("inputs.txt", mem);
	
	for(i=1; i<=18; i=i+1)
		begin
		{rb, re, ry} = mem[i];
		@(posedge clk);
		end
	
	$finish;
end

endmodule