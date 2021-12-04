module tb;
wire [4:0] hrs;
wire [5:0] min, sec;
reg [5:0] din=0, din_NBA=0;
reg [1:0] addr=0, addr_NBA=0;
reg clk=0, rst=0, ss=0, sel=0, inc=0, dec=0, load=0;
reg ss_NBA=0, sel_NBA=0, inc_NBA=0, dec_NBA=0, load_NBA=0;

always #5 clk = !clk;

initial
	begin
	rst = 1;
	#2;
	rst = 0;
	end

wrapper wrapper_inst(
.hrs(hrs),
.min(min),
.sec(sec),
.din(din_NBA),
.addr(addr_NBA),
.load(load_NBA),
.ss(ss_NBA),
.sel(sel_NBA),
.inc(inc_NBA),
.dec(dec_NBA),
.clk(clk),
.rst(rst)
);

always @* din_NBA <= din;
always @* addr_NBA <= addr;
always @* load_NBA <= load;
always @* ss_NBA <= ss;
always @* sel_NBA <= sel;
always @* inc_NBA <= inc;
always @* dec_NBA <= dec;

enum {RUN, HB, MB, SB, PL} state_txt;

always @*
begin
	case(tb.wrapper_inst.hms_inst.state)
		3'b000 : state_txt = RUN;
		3'b001 : state_txt = HB;
		3'b010 : state_txt = MB;
		3'b011 : state_txt = SB;
		3'b100 : state_txt = PL;
	endcase
end

initial
	begin
	wait(sec == 45);
	sspulse;
	
	repeat(28) @(posedge clk);
	incpulse;
	
	repeat(35) @(posedge clk);
	
	sspulse;
	
	repeat(28) @(posedge clk);
	decpulse;
	
	repeat(35) @(posedge clk);
	$finish;
	end
	
task sspulse;
begin
	ss = 1;
	@(posedge clk);
	ss = 0;
	@(posedge clk);
end
endtask

task selpulse;
begin
	sel = 1;
	@(posedge clk);
	sel = 0;
	@(posedge clk);
end
endtask

task incpulse;
begin
	inc = 1;
	@(posedge clk);
	inc = 0;
	@(posedge clk);
end
endtask

task decpulse;
begin
	dec = 1;
	@(posedge clk);
	dec = 0;
	@(posedge clk);
end
endtask

task put;
input [5:0] data;
input [4:0] address;
begin
	load = 1;
	din = data;
	addr = address;
	@(posedge clk);
	load = 0;
	din = 0;
	addr = 0;
	@(posedge clk);
end
endtask

endmodule