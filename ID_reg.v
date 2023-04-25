module ID_REG(clk,rst,flush,carry,dest,signed_imm,Shift_Operand,imm,val_rm,val_rn,PC,S,B,EXE_CMD,MEM_W,MEM_R,WB_EN,src1_in,src2_in,
carry_out,dest_out,signed_imm_out,Shift_Operand_out,imm_out,val_rm_out,val_rn_out,PC_out,S_out,B_out,
EXE_CMD_out,MEM_W_out,MEM_R_out,WB_EN_out,src1_out,src2_out);

input clk,rst,flush,carry,S,B,MEM_W,MEM_R,WB_EN,imm;
input [3:0]dest,EXE_CMD,src1_in,src2_in;
input [31:0]val_rm,val_rn,PC;
input [11:0]Shift_Operand;
input [23:0]signed_imm;

output reg carry_out,S_out,B_out,MEM_W_out,MEM_R_out,WB_EN_out,imm_out;
output reg [3:0]dest_out,EXE_CMD_out,src1_out,src2_out;
output reg [31:0]val_rm_out,val_rn_out,PC_out;
output reg [11:0]Shift_Operand_out;
output reg [23:0]signed_imm_out;

always@(posedge clk,posedge rst) begin
    if(rst)
        {carry_out,dest_out,signed_imm_out,Shift_Operand_out,imm_out,val_rm_out,val_rn_out,PC_out,S_out,B_out,
        EXE_CMD_out,MEM_W_out,MEM_R_out,WB_EN_out,src1_out,src2_out}<=0;
    else begin
        if(flush)
            {carry_out,dest_out,signed_imm_out,Shift_Operand_out,imm_out,val_rm_out,val_rn_out,PC_out,S_out,B_out,
        EXE_CMD_out,MEM_W_out,MEM_R_out,WB_EN_out,src1_out,src2_out}<=0;
        else begin
            carry_out<=carry;
            dest_out<=dest;
            signed_imm_out<=signed_imm;
            Shift_Operand_out<=Shift_Operand;
            imm_out<=imm;
            val_rm_out<=val_rm;
            val_rn_out<=val_rn;
            PC_out<=PC;
            S_out<=S;
            B_out<=B;
            EXE_CMD_out<=EXE_CMD;
            MEM_W_out<=MEM_W;
            MEM_R_out<=MEM_R;
            WB_EN_out<=WB_EN;
            src1_out<=src1_in;
            src2_out<=src2_in;
        end
    end
end
endmodule