module dut(input [3:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, output [3:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9);

wire [3:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9;

odd_even_N #(10) odd_even_sort_inst({i0, i1, i2, i3, i4, i5, i6, i7, i8, i9}, {y0, y1, y2, y3, y4, y5, y6, y7, y8, y9});
//asc_dec_N #(10)  asc_dec_sort_inst({w0, w1, w2, w3, w4, w5, w6, w7, w8, w9}, {y0, y1, y2, y3, y4, y5, y6, y7, y8, y9});

endmodule