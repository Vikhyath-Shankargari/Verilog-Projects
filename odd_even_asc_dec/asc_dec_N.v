module asc_dec_N(in, out);
parameter N=10;
input [0:(N*4)-1] in;
output [0:(N*4)-1] out;

genvar i;
wire [0:((N-1)*4)-1] w_out;
wire [3:0] w [0:N-2];

generate
	begin
	if(N==2)
		swap_asc_dec inst(out[0:3], out[4:7], in[0:3], in[4:7]);
	else
		begin
			for(i=0; i<=N-2; i=i+1)
				begin
					if(i==0) 		swap_asc_dec inst(w_out[i*4+:4], w[i], in[i*4+:4], in[(i+1)*4+:4]);
					else if(i==8) 	swap_asc_dec inst(w_out[i*4+:4], out[(i+1)*4+:4], w[i-1], in[(i+1)*4+:4]);
					else			swap_asc_dec inst(w_out[i*4+:4], w[i], w[i-1], in[(i+1)*4+:4]);
				end
			asc_dec_N #(N-1) inst(w_out, out[0:((N-1)*4)-1]);
		end
	end
endgenerate

endmodule