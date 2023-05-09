`timescale 1ps/1ps
module ARM_TB();
reg clk=0,rst=0;
reg forward_en=1;
always #10 clk=~clk;

wire SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N;
wire [15:0]SRAM_DQ;
wire [17:0]SRAM_ADDR;

SRAM my_sram(
    clk,
    rst,
    SRAM_DQ,
    SRAM_ADDR,
    SRAM_UB_N,
    SRAM_LB_N,
    SRAM_WE_N,
    SRAM_CE_N,
    SRAM_OE_N
);
ARM my_cpu(clk,rst,forward_en,SRAM_DQ,SRAM_ADDR,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N);
//ARM my_cpu(clk,rst,forward_en);
//ARM my_cpu2(clk,rst,~forward_en);

initial begin
    #5 rst=1'b1;
    #20 rst=1'b0;
end

endmodule