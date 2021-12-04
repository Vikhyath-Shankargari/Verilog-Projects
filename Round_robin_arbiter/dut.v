module dut(
output reg [1:0] printer,
input rb,
input re,
input ry,
input clk,
input rst
);

parameter B1E2Y3 = 0, BU = 1, EU = 2, YU = 3, E1Y2B3 = 4, Y1B2E3 = 5;
reg [2:0] state;

always @(posedge clk or posedge rst)
begin
	if(rst)	state <= B1E2Y3;
	else
		begin
			case(state)
			B1E2Y3 	:	case(1)
						rb : state <= BU;
						re : state <= EU;
						ry : state <= YU;
						default : state <= B1E2Y3;
						endcase
			BU		:	case(1)
						rb : state <= BU;
						re : state <= BU;
						ry : state <= YU;
						default : state <= E1Y2B3;
						endcase
			EU		:	case(1)
						re : state <= EU;
						ry : state <= YU;
						rb : state <= BU;
						default : state <= Y1B2E3;
						endcase
			YU		:	case(1)
						ry : state <= YU;
						rb : state <= BU;
						re : state <= EU;
						default : state <= B1E2Y3;
						endcase
			E1Y2B3	:	case(1)
						re : state <= EU;
						ry : state <= YU;
						rb : state <= BU;
						default : state <= E1Y2B3;
						endcase
			Y1B2E3	: 	case(1)
						ry : state <= YU;
						rb : state <= BU;
						re : state <= EU;
						default : state <= Y1B2E3;
						endcase
			endcase
		end
end

always @*
begin
	case(state)
	BU : printer = 1;
	EU : printer = 2;
	YU : printer = 3;
	B1E2Y3, E1Y2B3, Y1B2E3 : printer = 0;
	default : printer = 0;
	endcase
end

endmodule