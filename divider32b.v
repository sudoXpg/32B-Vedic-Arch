module divider32b(input[31:0]dividend,input[15:0]divisor,output[15:0]quo,rem);
wire [14:0] part_divisor;
