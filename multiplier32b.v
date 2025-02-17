// halfadder here

module halfadder(input a,b , output sum,carry);

assign sum = a^b;
assign carry = a&b;

endmodule


// fulladder here

module fulladder(input a,b,cin, output sum,carry);

assign sum = a^b^cin;
assign carry = (a&b) | (a^b)&cin;

endmodule

// 2bit VedicMultiplier here

module vedic2B(input [1:0]a,b ,output [3:0]out);
wire [3:0]w;
wire tmp;

assign w[0] = a[0] & b[0];
assign w[1] = a[1] & b[0];
assign w[2] = a[0] & b[1];
assign w[3] = a[1] & b[1];

assign out[0]=w[0];
halfadder h1 (w[1], w[2], out[1], tmp);
halfadder h2 (tmp, w[3], out[2], out[3]);

endmodule

// 4-bit RCA here

module RCA4B(input[3:0] a,b,input cin, output cout,output [3:0]sum);
wire [2:0]c;

fulladder f1 (a[0], b[0], cin,  sum[0], c[0]);
fulladder f2 (a[1], b[1], c[0], sum[1], c[1]);
fulladder f3 (a[2], b[2], c[1], sum[2], c[2]);
fulladder f4 (a[3], b[3], c[2], sum[3], cout);

endmodule



// 4-bit CSA here

module CSA4B(input[3:0] a,b,c ,output [5:0]s);
wire [9:0]w;

fulladder fa1 (a[0], b[0], c[0], s[0], w[0]);
fulladder fa2 (a[1], b[1], c[1], w[1], w[2]);
fulladder fa3 (a[2], b[2], c[2], w[3], w[4]);
fulladder fa4 (a[3], b[3], c[3], w[5], w[6]);

fulladder fa5 (w[0], w[1], 1'b0, s[1], w[7]);
fulladder fa6 (w[2], w[3], w[7], s[2], w[8]);
fulladder fa7 (w[4], w[5], w[8], s[3], w[9]);
fulladder fa8 (1'b0, w[6], w[9], s[4], s[5]);

endmodule



// 4bit VedicMultiplier here

module vedic4B(input [3:0]a,b, output [7:0]out);
wire[3:0]w1,w2,w3,w4,w5;
wire Cout;

vedic2B V1 (a[1:0],b[1:0],w1);
vedic2B V2 (a[3:2],b[1:0],w2);
vedic2B V3 (a[1:0],b[3:2],w3);
vedic2B V4 (a[3:2],b[3:2],w4);

assign out[1:0]=w1[1:0];
CSA4B C1 (w2,w3,{2'b0,w1[3:2]},{w5,out[3:2]});

RCA4B R1 (w4,w5 ,1'b0,Cout,out[7:4]);

endmodule


// 8bit RCA here

module RCA8B(input[7:0]a, b,input cin, output[7:0] sum,output cout);
wire[6:0] c;

fulladder f1 (a[0],b[0],cin,sum[0],c[0]);
fulladder f2 (a[1],b[1],c[0],sum[1],c[1]);
fulladder f3 (a[2],b[2],c[1],sum[2],c[2]);
fulladder f4 (a[3],b[3],c[2],sum[3],c[3]);
fulladder f5 (a[4],b[4],c[3],sum[4],c[4]);
fulladder f6 (a[5],b[5],c[4],sum[5],c[5]);
fulladder f7 (a[6],b[6],c[5],sum[6],c[6]);
fulladder f8 (a[7],b[7],c[6],sum[7],cout);

endmodule





// 12bit RCA here

module RCA12B(input [11:0] a, b, input cin, output [11:0]sum, output cout);
wire[10:0] c;

fulladder f1  (a[0],b[0],cin,sum[0],c[0]);
fulladder f2  (a[1],b[1],c[0],sum[1],c[1]);
fulladder f3  (a[2],b[2],c[1],sum[2],c[2]);
fulladder f4  (a[3],b[3],c[2],sum[3],c[3]);
fulladder f5  (a[4],b[4],c[3],sum[4],c[4]);
fulladder f6  (a[5],b[5],c[4],sum[5],c[5]);
fulladder f7  (a[6],b[6],c[5],sum[6],c[6]);
fulladder f8  (a[7],b[7],c[6],sum[7],c[7]);
fulladder f9  (a[8],b[8],c[7],sum[8],c[8]);
fulladder f10 (a[9],b[9],c[8],sum[9],c[9]);
fulladder f11 (a[10],b[10],c[9],sum[10],c[10]);
fulladder f12 (a[11],b[11],c[10],sum[11],cout);


endmodule


// 8bit vedic VedicMultiplier here


module vedic8B(input [7:0]a,b , output [15:0]out);
wire[7:0]q0,q1,q2,q3;
wire[8:0]q4;
wire[11:0]q5;
wire tmp,tmp1,tmp2;
wire [12:0]w,w1;

vedic4B V1 (a[3:0],b[3:0],q0);
vedic4B V2 (a[7:4],b[3:0],q1);
vedic4B V3 (a[3:0],b[7:4],q2);
vedic4B V4 (a[7:4],b[7:4],q3);


RCA8B A1 ({4'b0,q0[7:4]},q1,1'b0,q4[7:0], tmp);
assign q4[8]=tmp;

RCA12B A2 ({4'b0,q2[7:0]},{q3[7:0],4'b0}, 1'b0, w1[11:0], tmp2);
assign w1[12]=tmp2;
assign q5[11:0]=w1[11:0];

RCA12B A3 ({3'b0,q4[8:0]},q5[11:0], 1'b0, w[11:0], tmp1);
assign w[12]=tmp1;

assign out[3:0]=q0[3:0];
assign out[15:4]=w[12:0];

endmodule


// 16-bit CSA here
module CSA16B(input [15:0]a,b,i, output[17:0] sum);
wire [15:0]s,c,c1;

fulladder h1 (a[0],b[0],i[0],s[0],c[0]);
fulladder h2 (a[1],b[1],i[1],s[1],c[1]);
fulladder h3 (a[2],b[2],i[2],s[2],c[2]);
fulladder h4 (a[3],b[3],i[3],s[3],c[3]);
fulladder h5 (a[4],b[4],i[4],s[4],c[4]);
fulladder h6 (a[5],b[5],i[5],s[5],c[5]);
fulladder h7 (a[6],b[6],i[6],s[6],c[6]);
fulladder h8 (a[7],b[7],i[7],s[7],c[7]);
fulladder h9 (a[8],b[8],i[8],s[8],c[8]);
fulladder h10(a[9],b[9],i[9],s[9],c[9]);
fulladder h11(a[10],b[10],i[10],s[10],c[10]);
fulladder h12(a[11],b[11],i[11],s[11],c[11]);
fulladder h13(a[12],b[12],i[12],s[12],c[12]);
fulladder h14(a[13],b[13],i[13],s[13],c[13]);
fulladder h15(a[14],b[14],i[14],s[14],c[14]);
fulladder h16(a[15],b[15],i[15],s[15],c[15]);

fulladder f1  (c[0],s[1],1'b0,sum[1],c1[0]);
fulladder f2  (c[1],s[2],c1[0],sum[2],c1[1]);
fulladder f3  (c[2],s[3],c1[1],sum[3],c1[2]);
fulladder f4  (c[3],s[4],c1[2],sum[4],c1[3]);
fulladder f5  (c[4],s[5],c1[3],sum[5],c1[4]);
fulladder f6  (c[5],s[6],c1[4],sum[6],c1[5]);
fulladder f7  (c[6],s[7],c1[5],sum[7],c1[6]);
fulladder f8  (c[7],s[8],c1[6],sum[8],c1[7]);
fulladder f9  (c[8],s[9],c1[7],sum[9],c1[8]);
fulladder f10 (c[9],s[10],c1[8],sum[10],c1[9]);
fulladder f11 (c[10],s[11],c1[9],sum[11],c1[10]);
fulladder f12 (c[11],s[12],c1[10],sum[12],c1[11]);
fulladder f13 (c[12],s[13],c1[11],sum[13],c1[12]);
fulladder f14 (c[13],s[14],c1[12],sum[14],c1[13]);
fulladder f15 (c[14],s[15],c1[13],sum[15],c1[14]);
fulladder f16 (c[15],1'b0,c1[14],sum[16],sum[17]); 

assign sum[0]=s[0]; 
assign c1[15]=1'b0;

endmodule





// 16-bit VedicMultiplier here

module vedic16B(input[15:0]a,b, output[31:0]out);
wire [15:0]w1,w2,w3,w4;
wire[17:0]q1;

vedic8B V1 (a[7:0],b[7:0],w1);
vedic8B V2 (a[15:8],b[7:0],w2);
vedic8B V3 (a[7:0],b[15:8],w3);
vedic8B V4 (a[15:8],b[15:8],w4);

assign out[7:0]=w1[7:0];
CSA16B A1 ({8'b0,w1[15:8]},w2,w3,q1);
assign out[15:8]=q1[7:0];
CSA16B A2 ({6'b0,q1[17:8]},16'b0,w4,out[31:16]);

endmodule



// 32-bit CSA here

module CSA32B(input [31:0] a,b, output [31:0]sum, output cout);
wire [31:0]s,c;
wire [30:0]c1;
wire tmp;

halfadder h1  (a[0], b[0], s[0], c[0]);
halfadder h2  (a[1], b[1], s[1], c[1]);
halfadder h3  (a[2], b[2], s[2], c[2]);
halfadder h4  (a[3], b[3], s[3], c[3]);
halfadder h5  (a[4], b[4], s[4], c[4]);
halfadder h6  (a[5], b[5], s[5], c[5]);
halfadder h7  (a[6], b[6], s[6], c[6]);
halfadder h8  (a[7], b[7], s[7], c[7]);
halfadder h9  (a[8], b[8], s[8], c[8]);
halfadder h10 (a[9], b[9], s[9], c[9]);
halfadder h11 (a[10],b[10],s[10],c[10]);
halfadder h12 (a[11],b[11],s[11],c[11]);
halfadder h13 (a[12],b[12],s[12],c[12]);
halfadder h14 (a[13],b[13],s[13],c[13]);
halfadder h15 (a[14],b[14],s[14],c[14]);
halfadder h16 (a[15],b[15],s[15],c[15]);
halfadder h17 (a[16],b[16],s[16],c[16]);
halfadder h18 (a[17],b[17],s[17],c[17]);
halfadder h19 (a[18],b[18],s[18],c[18]);
halfadder h20 (a[19],b[19],s[19],c[19]);
halfadder h21 (a[20],b[20],s[20],c[20]);
halfadder h22 (a[21],b[21],s[21],c[21]);
halfadder h23 (a[22],b[22],s[22],c[22]);
halfadder h24 (a[23],b[23],s[23],c[23]);
halfadder h25 (a[24],b[24],s[24],c[24]);
halfadder h26 (a[25],b[25],s[25],c[25]);
halfadder h27 (a[26],b[26],s[26],c[26]);
halfadder h28 (a[27],b[27],s[27],c[27]);
halfadder h29 (a[28],b[28],s[28],c[28]);
halfadder h30 (a[29],b[29],s[29],c[29]);
halfadder h31 (a[30],b[30],s[30],c[30]);
halfadder h32 (a[31],b[31],s[31],c[31]);


fulladder f1  (1'b0,  s[1], c[0],  sum[1], c1[0]);
fulladder f2  (c1[0], s[2], c[1]  ,sum[2], c1[1]);
fulladder f3  (c1[1], s[3], c[2]  ,sum[3], c1[2]);
fulladder f4  (c1[2], s[4], c[3]  ,sum[4], c1[3]);
fulladder f5  (c1[3], s[5], c[4]  ,sum[5], c1[4]);
fulladder f6  (c1[4], s[6], c[5]  ,sum[6], c1[5]);
fulladder f7  (c1[5], s[7], c[6]  ,sum[7], c1[6]);
fulladder f8  (c1[6], s[8], c[7]  ,sum[8], c1[7]);
fulladder f9  (c1[7], s[9], c[8]  ,sum[9], c1[8]);
fulladder f10 (c1[8], s[10], c[9], sum[10], c1[9]);
fulladder f11 (c1[9], s[11],c[10], sum[11],c1[10]);
fulladder f12 (c1[10],s[12],c[11], sum[12],c1[11]);
fulladder f13 (c1[11],s[13],c[12], sum[13],c1[12]);
fulladder f14 (c1[12],s[14],c[13], sum[14],c1[13]);
fulladder f15 (c1[13],s[15],c[14], sum[15],c1[14]);
fulladder f16 (c1[14],s[16],c[15], sum[16],c1[15]);
fulladder f17 (c1[15],s[17],c[16], sum[17],c1[16]);
fulladder f18 (c1[16],s[18],c[17], sum[18],c1[17]);
fulladder f19 (c1[17],s[19],c[18], sum[19],c1[18]);
fulladder f20 (c1[18],s[20],c[19], sum[20],c1[19]);
fulladder f21 (c1[19],s[21],c[20], sum[21],c1[20]);
fulladder f22 (c1[20],s[22],c[21], sum[22],c1[21]);
fulladder f23 (c1[21],s[23],c[22], sum[23],c1[22]);
fulladder f24 (c1[22],s[24],c[23], sum[24],c1[23]);
fulladder f25 (c1[23],s[25],c[24], sum[25],c1[24]);
fulladder f26 (c1[24],s[26],c[25], sum[26],c1[25]);
fulladder f27 (c1[25],s[27],c[26], sum[27],c1[26]);
fulladder f28 (c1[26],s[28],c[27], sum[28],c1[27]);
fulladder f29 (c1[27],s[29],c[28], sum[29],c1[28]);
fulladder f30 (c1[28],s[30],c[29], sum[30],c1[29]);
fulladder f31 (c1[29],s[31],c[30], sum[31],c1[30]);
fulladder f32 (c1[30],1'b0,c[31], cout,tmp);


assign sum[0]=s[0];

endmodule


// 32-bit CLA here

module CLA32b(in1, in2, carry_in, sum, carry_out);
parameter DATA_WID = 32;

input [DATA_WID - 1:0] in1;
input [DATA_WID - 1:0] in2;
input carry_in;
output [DATA_WID - 1:0] sum;
output carry_out;

//assign {carry_out, sum} = in1 + in2 + carry_in;

wire [DATA_WID - 1:0] gen;
wire [DATA_WID - 1:0] pro;
wire [DATA_WID:0] carry_tmp;

genvar j, i;
generate
 //assume carry_tmp in is zero
 assign carry_tmp[0] = carry_in;
 
 //carry generator
 for(j = 0; j < DATA_WID; j = j + 1) begin: carry_generator
 assign gen[j] = in1[j] & in2[j];
 assign pro[j] = in1[j] | in2[j];
 assign carry_tmp[j+1] = gen[j] | pro[j] & carry_tmp[j];
 end
 
 //carry out 
 assign carry_out = carry_tmp[DATA_WID];
 
 //calculate sum 
 //assign sum[0] = in1[0] ^ in2 ^ carry_in;
 for(i = 0; i < DATA_WID; i = i+1) begin: sum_without_carry
 assign sum[i] = in1[i] ^ in2[i] ^ carry_tmp[i];
 end 
endgenerate 
endmodule


// 32-bit RCA here

module RCA32B(input [31:0]a, b, input cin,output[31:0] sum, output cout);
wire[30:0] c;

fulladder a1 (a[0], b[0], cin,  sum[0], c[0]);
fulladder a2 (a[1], b[1], c[0], sum[1], c[1]);
fulladder a3 (a[2], b[2], c[1], sum[2], c[2]);
fulladder a4 (a[3], b[3], c[2], sum[3], c[3]);
fulladder a5 (a[4], b[4], c[3], sum[4], c[4]);
fulladder a6 (a[5], b[5], c[4], sum[5], c[5]);
fulladder a7 (a[6], b[6], c[5], sum[6], c[6]);
fulladder a8 (a[7], b[7], c[6], sum[7], c[7]);
fulladder a9 (a[8], b[8], c[7], sum[8], c[8]);
fulladder a10(a[9], b[9], c[8], sum[9], c[9]);
fulladder a11(a[10],b[10],c[9], sum[10], c[10]);
fulladder a12(a[11],b[11],c[10],sum[11],c[11]);
fulladder a13(a[12],b[12],c[11],sum[12],c[12]);
fulladder a14(a[13],b[13],c[12],sum[13],c[13]);
fulladder a15(a[14],b[14],c[13],sum[14],c[14]);
fulladder a16(a[15],b[15],c[14],sum[15],c[15]);
fulladder a17(a[16],b[16],c[15],sum[16],c[16]);
fulladder a18(a[17],b[17],c[16],sum[17],c[17]);
fulladder a19(a[18],b[18],c[17],sum[18],c[18]);
fulladder a20(a[19],b[19],c[18],sum[19],c[19]);
fulladder a21(a[20],b[20],c[19],sum[20],c[20]);
fulladder a22(a[21],b[21],c[20],sum[21],c[21]);
fulladder a23(a[22],b[22],c[21],sum[22],c[22]);
fulladder a24(a[23],b[23],c[22],sum[23],c[23]);
fulladder a25(a[24],b[24],c[23],sum[24],c[24]);
fulladder a26(a[25],b[25],c[24],sum[25],c[25]);
fulladder a27(a[26],b[26],c[25],sum[26],c[26]);
fulladder a28(a[27],b[27],c[26],sum[27],c[27]);
fulladder a29(a[28],b[28],c[27],sum[28],c[28]);
fulladder a30(a[29],b[29],c[28],sum[29],c[29]);
fulladder a31(a[30],b[30],c[29],sum[30],c[30]);
fulladder a32(a[31],b[31],c[30],sum[31],cout);

endmodule



// 32-bit VedicMultiplier here

module vedic32B(input [31:0]a,b, output cout, output [63:0]out);
wire [31:0]w1,w2,w3,w4,s1,s2,s3;
wire c0,c1,c2,tmp;

vedic16B V1 (a[15:0],  b[15:0],  w1);
vedic16B V2 (a[15:0],  b[31:16], w2);
vedic16B V3 (a[31:16], b[15:0],  w3);
vedic16B V4 (a[31:16], b[31:16], w4);


CSA32B C1 (w2,w3, s1, c0);
CSA32B C2 ({16'b0,w1[31:16]}, s1,s2, c1);

assign tmp=c0|c1;
CSA32B C3 ({15'b0,tmp,s2[31:16]},w4 , s3, c2);

assign out[15:0]=w1[15:0];
assign out[31:16]=s2[15:0];
assign out[63:32]=s3;
assign cout=c2;

endmodule