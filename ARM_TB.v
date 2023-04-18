module ARM_TB();
reg clk=0,rst=0;
always #10 clk=~clk;

ARM my_cpu(clk,rst);

initial begin
    #5 rst=1'b1;
    #20 rst=1'b0;
end

endmodule