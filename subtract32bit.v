module subtract32bit(a, b, sum, cout);
input [31:0] a,b;
wire[31:0]b1;
assign b1=~b;
output [31:0]sum;
output cout;
wire[30:0] c;

fullAdder a1 (a[0], b1[0], 1'b1,  sum[0], c[0]);
fullAdder a2 (a[1], b1[1], c[0], sum[1], c[1]);
fullAdder a3 (a[2], b1[2], c[1], sum[2], c[2]);
fullAdder a4 (a[3], b1[3], c[2], sum[3], c[3]);
fullAdder a5 (a[4], b1[4], c[3], sum[4], c[4]);
fullAdder a6 (a[5], b1[5], c[4], sum[5], c[5]);
fullAdder a7 (a[6], b1[6], c[5], sum[6], c[6]);
fullAdder a8 (a[7], b1[7], c[6], sum[7], c[7]);
fullAdder a9 (a[8], b1[8], c[7], sum[8], c[8]);
fullAdder a10(a[9], b1[9], c[8], sum[9], c[9]);
fullAdder a11(a[10],b1[10],c[9], sum[10], c[10]);
fullAdder a12(a[11],b1[11],c[10],sum[11],c[11]);
fullAdder a13(a[12],b1[12],c[11],sum[12],c[12]);
fullAdder a14(a[13],b1[13],c[12],sum[13],c[13]);
fullAdder a15(a[14],b1[14],c[13],sum[14],c[14]);
fullAdder a16(a[15],b1[15],c[14],sum[15],c[15]);
fullAdder a17(a[16],b1[16],c[15],sum[16],c[16]);
fullAdder a18(a[17],b1[17],c[16],sum[17],c[17]);
fullAdder a19(a[18],b1[18],c[17],sum[18],c[18]);
fullAdder a20(a[19],b1[19],c[18],sum[19],c[19]);
fullAdder a21(a[20],b1[20],c[19],sum[20],c[20]);
fullAdder a22(a[21],b1[21],c[20],sum[21],c[21]);
fullAdder a23(a[22],b1[22],c[21],sum[22],c[22]);
fullAdder a24(a[23],b1[23],c[22],sum[23],c[23]);
fullAdder a25(a[24],b1[24],c[23],sum[24],c[24]);
fullAdder a26(a[25],b1[25],c[24],sum[25],c[25]);
fullAdder a27(a[26],b1[26],c[25],sum[26],c[26]);
fullAdder a28(a[27],b1[27],c[26],sum[27],c[27]);
fullAdder a29(a[28],b1[28],c[27],sum[28],c[28]);
fullAdder a30(a[29],b1[29],c[28],sum[29],c[29]);
fullAdder a31(a[30],b1[30],c[29],sum[30],c[30]);
fullAdder a32(a[31],b1[31],c[30],sum[31],cout);



endmodule