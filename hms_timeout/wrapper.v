module wrapper(
output [4:0] hrs,
output [5:0] min, sec,
input [5:0] din,
input [1:0] addr,
input load, ss, sel, inc, dec, clk, rst
);

reg ssn, seln, incn, decn;

hms_with_din hms_inst(
.hrs(hrs),
.min(min),
.sec(sec),
.din(din),
.addr(addr),
.load(load),
.ss(ssn),
.sel(seln),
.inc(incn),
.dec(decn),
.clk(clk),
.rst(rst)
);

always @*
begin
	casex({ss, sel, inc, dec})
	4'b0001 : {ssn, seln, incn, decn} = 4'b0001;
	4'b0010 : {ssn, seln, incn, decn} = 4'b0010;
	4'b01xx : {ssn, seln, incn, decn} = 4'b0100;
	4'b1xxx : {ssn, seln, incn, decn} = 4'b1000;
	default : {ssn, seln, incn, decn} = 4'b0000;
	endcase
end

endmodule