module comparator32bit(input [31:0]a,b, output reg eq,sm,gr);
wire[31:0]SUM,X,B1;
wire Cout;
assign X = a^b;
assign B1=~b;
cla32bit cla_inst(a, B1, 1'b1, SUM, Cout);

always@(*)
if(SUM==0)
    begin
        eq=1;
        sm=0;
        gr=0;
    end
else
    begin
        if( Cout==1'b1 && SUM != 0)
            begin
                eq=0;
                sm=0;
                gr=1;
            end

        else if( Cout==1'b0 && SUM != 0)
            begin
                eq=0;
                sm=1;
                gr=0;
            end
        
    end
endmodule