module EXE_reg(clk,rst,freeze,dest,val_rm,ALU_res,MEM_W,MEM_R,WB_EN,
dest_out,val_rm_out,ALU_res_out,MEM_W_out,MEM_R_out,WB_EN_out);

input clk,rst,MEM_W,MEM_R,WB_EN,freeze;
input [3:0]dest;
input [31:0]val_rm,ALU_res;

output reg MEM_W_out,MEM_R_out,WB_EN_out;
output reg [3:0]dest_out;
output reg [31:0]val_rm_out,ALU_res_out;

always@(posedge clk,posedge rst)begin
    if(rst)
        {dest_out,val_rm_out,ALU_res_out,MEM_W_out,MEM_R_out,WB_EN_out}<=0;
    else if(~freeze)begin 
        dest_out<=dest;
        val_rm_out<=val_rm;
        ALU_res_out<=ALU_res;
        MEM_W_out<=MEM_W;
        MEM_R_out<=MEM_R;
        WB_EN_out<=WB_EN;
    end
end

endmodule