module dut(hrs, mins, secs, clk, rst);
output [4:0] hrs;
output [5:0] mins, secs;
input clk, rst;
reg [4:0] hrs;
reg [5:0] mins, secs;

always @(posedge clk or posedge rst)
begin
	if(rst) secs <= 6'd0;
	else	secs <= (secs==6'd59) ? 6'd0 : (secs+6'd1);
end

always @(posedge clk or posedge rst)
begin
	if(rst) mins <= 6'd0;
	else
		begin
			if(secs==6'd59) mins <= (mins==6'd59) ? 6'd0 : (mins+6'd1);
			else	mins <= mins;
		end
end

always @(posedge clk or posedge rst)
begin
	if(rst) hrs <= 5'd0;
	else
		begin
			if(secs==6'd59 && mins==6'd59) hrs <= (hrs==5'd23) ? 5'd0 : (hrs+5'd1);
			else	hrs <= hrs;
		end
end

endmodule