module ARM_TB();
reg clk=0,rst=0;
always #10 clk=~clk;

initial begin
    #5 rst=1'b1;
    #20 rst=1'b0;
end

endmodule