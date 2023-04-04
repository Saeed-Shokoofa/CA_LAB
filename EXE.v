module EXE(WB_EN,MEM_R,MEM_W,EXE_CMD,B,S,PC,val_rn,val_rm,imm,Shift_Operand,signed_imm,dest,status,
WB_EN_out,MEM_R_out,MEM_W_out,ALU_res,val_rm_out,dest_out);
input WB_EN,MEM_R,MEM_W,B,S,imm;
input[3:0]EXE_CMD,dest,status;
input [31:0]PC,val_rn,val_rm;
input [11:0]Shift_Operand;
input [23:0]signed_imm;
output WB_EN_out,MEM_R_out,MEM_W_out;
output [31:0]ALU_res,val_rm_out;
output [3:0] dest_out;

endmodule