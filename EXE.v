module EXE(clk,rst,WB_EN,MEM_R,MEM_W,EXE_CMD,B,S,PC,val_rn,val_rm,imm,Shift_Operand,signed_imm,dest,carry,MEM_val_rn,MEM_val_rm,WB_val_rn,WB_val_rm,sel1,sel2,
WB_EN_out,MEM_R_out,MEM_W_out,ALU_res,val_rm_out,dest_out,branch_adr,status_out,branch_taken);
input clk,rst,WB_EN,MEM_R,MEM_W,B,S,imm,carry;
input [1:0]sel1,sel2;
input[3:0]EXE_CMD,dest;
input [31:0]PC,val_rn,val_rm,MEM_val_rn,MEM_val_rm,WB_val_rn,WB_val_rm;
input [11:0]Shift_Operand;
input [23:0]signed_imm;
output WB_EN_out,MEM_R_out,MEM_W_out,branch_taken;
output [31:0]ALU_res,val_rm_out,branch_adr;
output [3:0] dest_out,status_out;

wire [31:0] val2;
wire [3:0] new_status;

wire [31:0]mux1_out,mux2_out;

adder AD(.a(PC),.b({{6{signed_imm[23]}},signed_imm[23:0],2'b0}),.out(branch_adr));
val2gen VG(.Rm(mux2_out),.Shift_Operand(Shift_Operand),.imm(imm),.en(MEM_R|MEM_W),.out(val2));
st_reg ST(.clk(clk),.rst(rst),.S(S),.status(new_status),.status_out(status_out));
ALU ALU1(.src1(mux1_out),.src2(val2),.cmd(EXE_CMD),.carry(carry),.out(ALU_res),.status_out(new_status));
mux4to1 #(32)MM1(.i0(val_rn),.i1(MEM_val_rn),.i2(WB_val_rn),.i3(),.sel(sel1),.out(mux1_out));
mux4to1 #(32)MM2(.i0(val_rm),.i1(MEM_val_rm),.i2(WB_val_rm),.i3(),.sel(sel2),.out(mux2_out));

assign branch_taken=B;
assign dest_out=dest;
assign val_rm_out=val_rm;
assign WB_EN_out=WB_EN;
assign MEM_R_out=MEM_R;
assign MEM_W_out=MEM_W;

endmodule