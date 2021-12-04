module hms_with_din(
output reg [4:0] hrs,
output reg [5:0] min, sec,
input [5:0] din,
input [1:0] addr,
input load, ss, sel, inc, dec, clk, rst
);

reg [2:0] state, state_in;
reg [4:0] icnt;
wire icnt_30;
parameter RUN = 0, HB = 1, MB = 2, SB = 3, PL = 4;

assign icnt_30 = (ss || sel || inc || dec) ? 0 : (icnt==30);

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
					sel 		: state_in = HB;
					icnt_30, ss : state_in = RUN;
					default : state_in = state;
				endcase
		HB	:	case(1)
					sel 		: state_in = MB;
					icnt_30, ss : state_in = RUN;
					default : state_in = HB;
				endcase
		MB 	:	case(1)
					sel 		: state_in = SB;
					icnt_30, ss : state_in = RUN;
					default : state_in = MB;
				endcase
		SB	:	case(1)
					sel 		: state_in = HB;
					icnt_30, ss : state_in = RUN;
					default : state_in = SB;
				endcase
	endcase
end

always @(posedge clk or posedge rst)
begin
	if(rst)	icnt <= 0;
	else
		begin
		case(state_in)
		RUN 	: icnt <= 0;
		default : begin
				  if(ss || sel || inc || dec || load) icnt <= 1;
				  else icnt <= icnt+1;
				  end
		endcase
		end
end

always @(posedge clk or posedge rst)
begin
	if(rst)	sec <= 0;
	else
		begin
		case(state_in)
			RUN	: sec <= (sec==59) ? 0 : (sec+1);
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
			RUN	: if(sec==59)	min <= (min==59) ? 0 : (min+1);
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
			RUN	: if(sec==59 && min==59)	hrs <= (hrs==23) ? 0 : (hrs+1);
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