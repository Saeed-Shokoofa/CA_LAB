module ARM_TB();
reg clk=0,rst=0;
reg forward_en=1;
always #10 clk=~clk;

ARM my_cpu(clk,rst,forward_en);
ARM my_cpu2(clk,rst,~forward_en);

initial begin
    #5 rst=1'b1;
    #20 rst=1'b0;
end

endmodule