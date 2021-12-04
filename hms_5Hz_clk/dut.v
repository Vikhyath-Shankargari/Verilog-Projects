module hms_with_din(
output reg [4:0] hrs,
output reg [5:0] min, sec,
input [5:0] din,
input [1:0] addr,
input load, ss, sel, inc, dec, clk, rst
);

reg [2:0] state, state_in;
reg [2:0] icnt;
wire icnt_5;
parameter RUN = 0, HB = 1, MB = 2, SB = 3, PL = 4;

always @(posedge clk or posedge rst)
begin
	if(rst) icnt <= 1;
	else
		begin
		case(state_in)
			RUN : icnt <= (icnt==5) ? 1 : (icnt+1);
			default : icnt <= 0;
		endcase
		end
end

assign icnt_5 = (icnt==5);

always @(posedge clk or posedge rst)
begin
	if(rst)	state <= RUN;
	else	state <= state_in;
end

always @(*)
begin
	case(state)
	RUN :	state_in = ss ? PL : RUN;
	PL 	:	case(1)
				ss : state_in = RUN;
				sel : state_in = HB;
				default : state_in = state;
			endcase
	HB	:	case(1)
				sel : state_in = MB;
				ss	: state_in = RUN;
				default : state_in = HB;
			endcase
	MB 	:	case(1)
				sel : state_in = SB;
				ss	: state_in = RUN;
				default : state_in = MB;
			endcase
	SB	:	case(1)
				sel : state_in = HB;
				ss	: state_in = RUN;
				default : state_in = SB;
			endcase
	endcase
end

always @(posedge clk or posedge rst)
begin
	if(rst)	sec <= 0;
	else
		begin
		case(state_in)
			RUN	: begin
					if(icnt_5) sec <= (sec==59) ? 0 : (sec+1);
					else sec <= sec;
				  end
			PL : if(load && addr==1) sec <= din;
				 else sec <= sec;
			HB, MB : sec <= sec;
			SB : case(1)
					 inc : sec <= (sec==59) ? 0 : sec+1;
					 dec : sec <= (sec==0) ? 59 : sec-1;
				 endcase
		endcase
		end
end

always @(posedge clk or posedge rst)
begin
	if(rst)	min <= 0;
	else
		begin
		case(state_in)
			RUN	: if(sec==59 && icnt_5)	min <= (min==59) ? 0 : (min+1);
				  else min <= min;
			PL : if(load && addr==2) min <= din;
				 else min <= min;
			HB, SB : min <= min;
			MB : case(1)
					 inc : min <= (min==59) ? 0 : min+1;
					 dec : min <= (min==0) ? 59 : min-1;
				 endcase
		endcase
		end
end

always @(posedge clk or posedge rst)
begin
	if(rst)	hrs <= 0;
	else
		begin
		case(state_in)
			RUN	: if(sec==59 && min==59 && icnt_5)	hrs <= (hrs==23) ? 0 : (hrs+1);
				  else hrs <= hrs;
			PL : if(load && addr==3) hrs <= din;
				 else hrs <= hrs;
			MB, SB : hrs <= hrs;
			HB : case(1)
					 inc : hrs <= (hrs==23) ? 0 : hrs+1;
					 dec : hrs <= (hrs==0) ? 23 : hrs-1;
				 endcase
		endcase
		end
end

endmodule