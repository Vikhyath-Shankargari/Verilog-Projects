module tb;
reg [3:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9;
wire [3:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9;

dut inst(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, y0, y1, y2, y3, y4, y5, y6, y7, y8, y9);

initial
	begin
	repeat(20)
		begin
		{i0, i1, i2, i3, i4, i5, i6, i7, i8, i9}={$random,$random};
		#1;
		$display("input  : \t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t",i0, i1, i2, i3, i4, i5, i6, i7, i8, i9);
		$display("output : \t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t\n",y0, y1, y2, y3, y4, y5, y6, y7, y8, y9);
		end
		
		i0=4'd2;	i1=4'd1;	i2=4'd6;	i3=4'd7;	i4=4'd4;	i5=4'd4;	i6=4'd9;	i7=4'd8;	i8=4'd2;	i9=4'd3;
		#1;
		$display("input  : \t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t",i0, i1, i2, i3, i4, i5, i6, i7, i8, i9);
		$display("output : \t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t%2d\t\n",y0, y1, y2, y3, y4, y5, y6, y7, y8, y9);
	end
	
endmodule