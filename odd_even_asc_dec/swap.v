//ascending
module swap_asc(output [3:0] y1, y0, input [3:0] i1, i0);

assign y1 = (i1<i0) ? i1 : i0;
assign y0 = (!(i1<i0)) ? i1 : i0;

endmodule


//descending
module swap_dec(output [3:0] y1, y0, input [3:0] i1, i0);

assign y1 = (!(i1<i0)) ? i1 : i0;
assign y0 = (i1<i0) ? i1 : i0;

endmodule


//odd_even
module swap_odd_even(output [3:0] y1, y0, input [3:0] i1, i0);

assign y1 = ((i1[0]==0) && (i0[0]==1)) ? i0 : i1;
assign y0 = (!((i1[0]==0) && (i0[0]==1))) ? i0 : i1;

endmodule


//asc - dec swap depending on odd or even
module swap_asc_dec(output [3:0] y1, y0, input [3:0] i1, i0);

wire [3:0] asc_y1, asc_y0, dec_y1, dec_y0;
wire [3:0] dec_mux_y1, dec_mux_y0;
wire odd, even;

swap_asc swap_asc_inst(asc_y1, asc_y0, i1, i0);
swap_dec swap_dec_inst(dec_y1, dec_y0, i1, i0);

assign odd = ((i1[0]==1) && (i0[0]==1)); 
assign even = ((i1[0]==0) && (i0[0]==0));

assign y1 =  odd ? asc_y1 : dec_mux_y1;
assign dec_mux_y1 = even ? dec_y1 : i1;

assign y0 = odd ? asc_y0 : dec_mux_y0;
assign dec_mux_y0 = even ? dec_y0 : i0;

endmodule
