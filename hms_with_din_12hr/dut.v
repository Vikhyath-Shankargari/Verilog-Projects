module hms_with_din_12hr(
output reg am_pm_bar,
output reg [3:0] hrs,
output reg [5:0] min, sec,
input [5:0] din,
input [2:0] addr,
input load, ss, sel, inc, dec, clk, rst
);

reg [2:0] state, state_in;
parameter RUN = 0, AM_PM_B=1, HB = 2, MB = 3, SB = 4, PL = 5;
wire am_pm_bar_next;

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
					sel : state_in = AM_PM_B;
					default : state_in = state;
				endcase
		AM_PM_B	:	case(1)
						sel : state_in = HB;
						ss	: state_in = RUN;
					default : state_in = AM_PM_B;
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
			RUN	: sec <= (sec==59) ? 0 : (sec+1);
			PL : if(load && addr==1) sec <= din;
				 else sec <= sec;
			AM_PM_B, HB, MB : sec <= sec;
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
			AM_PM_B, HB, SB : min <= min;
			MB : case(1)
					 inc : min <= (min==59) ? 0 : min+1;
					 dec : min <= (min==0) ? 59 : min-1;
				 endcase
		endcase
		end
end

always @(posedge clk or posedge rst)
begin
	if(rst)	hrs <=12;
	else
		begin
		case(state_in)
			RUN	: if(sec==59 && min==59)	hrs <= (hrs==12) ? 1 : (hrs+1);
				  else hrs <= hrs;
			PL : if(load && addr==3) 
					 begin
					 if(din==0)	hrs <= 12;
					 else		hrs <= (din>12) ? (din-12) : din;
					 end
				 else hrs <= hrs;
			AM_PM_B, MB, SB : hrs <= hrs;
			HB : case(1)
					 inc : hrs <= (hrs==12) ? 1 : hrs+1;
					 dec : hrs <= (hrs==1) ? 12 : hrs-1;
				 endcase
		endcase
		end
end

assign am_pm_bar_next = am_pm_bar ? 0 : 1;

always @(posedge clk or posedge rst)
begin
	if(rst) am_pm_bar <= 1;
	else
		begin
		case(state_in)
			RUN : if(sec==59 && min==59 && hrs==11)	am_pm_bar <= (am_pm_bar) ? 0 : 1;
				  else am_pm_bar <= am_pm_bar;
			PL	: if(load && addr==3)	am_pm_bar <= (din>12) ? 0 : 1;
				  else am_pm_bar <= am_pm_bar;
			HB, MB, SB : am_pm_bar <= am_pm_bar;
			AM_PM_B : case(1)
						inc : am_pm_bar <= am_pm_bar_next;
						dec : am_pm_bar <= am_pm_bar_next;
					  endcase
		endcase
		end
end

endmodule