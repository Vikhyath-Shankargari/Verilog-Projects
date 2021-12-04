module odd_even_N(in, out);
parameter N=10;
input [0:(N*4)-1] in;
output [0:(N*4)-1] out;

genvar i;
wire [0:((N-1)*4)-1] w_out;

generate
	begin
	if(N==2)
		swap_odd_even inst(out[0+:4], out[4+:4], in[0+:4], in[4+:4]);
	else
		begin
			for(i=0; i<=N-2; i=i+1)
				begin : SORT
					wire [3:0] w;
					if(i==0) 		swap_odd_even inst(w_out[i*4+:4], SORT[i].w, in[i*4+:4], in[(i+1)*4+:4]);
					else if(i==8) 	swap_odd_even inst(w_out[i*4+:4], out[(i+1)*4+:4], SORT[i-1].w, in[(i+1)*4+:4]);
					else			swap_odd_even inst(w_out[i*4+:4], SORT[i].w, SORT[i-1].w, in[(i+1)*4+:4]);
				end
			odd_even_N #(N-1) inst(w_out, out[0+:(N-1)*4]);
		end
	end
endgenerate

endmodule