module freq_divider(input clk,output clkprime);
    reg temp=0;
    always@(posedge clk)begin
        temp=~temp;
    end
    assign clkprime=temp;
endmodule