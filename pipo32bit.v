module pipo32bit(input clk,clear,input[31:0] pi, output reg[31:0]po);

always @(posedge clk)
    begin
        if (clear)
        po<= 32'b0000;
    
        else
        po <= pi;
    end
endmodule