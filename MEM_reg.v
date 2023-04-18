
module MEM_REG(clk,rst,WB_EN,MEM_R,ALU_res,data_mem,dest,
WB_EN_out,MEM_R_out,ALU_res_out,data_mem_out,dest_out);

input clk,rst,MEM_R,WB_EN;
input [3:0]dest;
input [31:0]ALU_res,data_mem;

output reg MEM_R_out,WB_EN_out;
output reg [3:0]dest_out;
output reg [31:0]ALU_res_out,data_mem_out;

always@(posedge clk,posedge rst) begin
    if(rst)
        {WB_EN_out,MEM_R_out,ALU_res_out,data_mem_out,dest_out}<=0;
    else begin
        MEM_R_out<=MEM_R;
        WB_EN_out<=WB_EN;
        ALU_res_out<=ALU_res;
        data_mem_out<=data_mem;
        dest_out<=dest;
    end
end
endmodule



