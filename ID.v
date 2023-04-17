module ID(clk,rst,z,c,n,v,instruction,PC,WB_WB_EN,WB_Value,WB_Dest,
WB_EN,MEM_R,MEM_W,EXE_CMD,B,S,PC_out,val_rn,val_rm,dest,signed_imm,imm,Shift_Operand,src2forhaz);
input [31:0]instruction,PC,WB_Value;
input clk,rst,z,c,n,v,WB_WB_EN;
input [3:0]WB_Dest;
output WB_EN,MEM_R,MEM_W,B,S;
output [3:0]EXE_CMD,dest,src2forhaz;
output [31:0]PC_out,val_rn,val_rm;
output imm;
output [23:0] signed_imm;
output [11:0] Shift_Operand;
wire check_res;
wire [8:0] mux_in,mux_out;
wire [3:0] Mux2_Out;

mux2to1 #(4)MM1(.sel(mux_out[1]),.in1(instruction[3:0]),.in2(instruction[15:12]),.out(Mux2_Out));
mux2to1 #(9)MM2(.sel((~check_res|1'b0)),.in1(mux_in),.in2(9'b0),.out(mux_out));
CU CNT(.opcode(instruction[24:21]),.mode(instruction[27:26]),.s(instruction[20]),
.WB_EN(mux_in[0]),.MEM_R(mux_in[1]),.MEM_W(mux_in[2]),.B(mux_in[7]),.S_OUT(mux_in[8]),.EXE_CMD(mux_in[6:3]));
condition_check CC(.cond(instruction[31:28]),.z(z),.c(c),.n(n),.v(v),.out(check_res));
RegisterFile RF(.clk(clk),.rst(rst),.src1(instruction[19:16]),.src2(Mux2_Out),.Dest_wb(WB_Dest),
.Result_WB(WB_Value),.writeBackEn(WB_WB_EN),.reg1(val_rn),.reg2(val_rm));


assign WB_EN=mux_out[0];
assign MEM_R=mux_out[1];
assign MEM_W=mux_out[2];
assign EXE_CMD=mux_out[6:3];
assign B=mux_out[7];
assign S=mux_out[8];
assign dest=instruction[15:12];
assign imm=instruction[25];
assign Shift_Operand=instruction[11:0];
assign signed_imm=instruction[23:0];
assign PC_out=PC;

endmodule
