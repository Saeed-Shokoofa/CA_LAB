module st_reg(input clk,rst,S,input [3:0]status,output reg[3:0] status_out);
always@(negedge clk,posedge rst)begin
    if(rst)
        status_out=0;
    else if(S) begin
        status_out=status;
    end
end
endmodule