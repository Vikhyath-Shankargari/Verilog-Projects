module my_name_sequence_detector(
output eureka,
input [7:0] char,
input clk,
input rst
);

enum {NO, SV, SI, SK, SH0, SY, SA, ST, SH1} state;

always @(posedge clk or posedge rst)
	begin
	if(rst) state<=NO;
	else
		case(state)
		NO	: state <= (char=="V") ? SV : NO;
		SV 	: case(char)
				  "I" : state <= SI;
				  "V" : state <= SV;
				  default : state <= NO;
			  endcase
		SI	: case(char)
				  "K" : state <= SK;
				  "V" : state <= SV;
				  default : state <= NO;
			  endcase
		SK	: case(char)
				  "H" : state <= SH0;
				  "V" : state <= SV;
				  default : state <= NO;
			  endcase
		SH0	: case(char)
				  "Y" : state <= SY;
				  "V" : state <= SV;
				  default : state <= NO;
			  endcase
		SY	: case(char)
				  "A" : state <= SA;
				  "V" : state <= SV;
				  default : state <= NO;
			  endcase
		SA	: case(char)
				  "T" : state <= ST;
				  "V" : state <= SV;
				  default : state <= NO;
			  endcase
		ST	: case(char)
				  "H" : state <= SH1;
				  "V" : state <= SV;
				  default : state <= NO;
			  endcase
		SH1	: state <= (char=="V") ? SV : NO;
		endcase
	end
	
assign eureka = (state==SH1);

endmodule