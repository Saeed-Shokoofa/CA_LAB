module ID(clk,rst,z,c,n,v,instruction,PC,
WB_EN,MEM_R,MEM_W,EXE_CMD,B,S,PC_out,val_rn,val_rm,dest,signed_imm,sth,imm);
input [31:0]instruction,PC;
input clk,rst,z,c,n,v;
output WB_EN,MEM_R,MEM_W,B,S;
output [3:0]EXE_CMD,dest;
output [31:0]PC_out,val_rn,val_rm;
output signed_imm,sth,imm;
wire check_res;
wire[8:0] mux_in,mux_out;

CU CNT(.opcode(instruction[24:21]),.mode(instruction[27:26]),.s(instruction[20]),
.WB_EN(mux_in[0]),.MEM_R(mux_in[1]),.MEM_W(mux_in[2]),.B(mux_in[7]),.S_OUT(mux_in[8]),.EXE_CMD(mux_in[6:3]));
condition_check CC(.cond(instruction[31:28]),.z(z),.c(c),.n(n),.v(v),.out(check_res));


assign WB_EN=mux_out[0];
assign MEM_R=mux_out[1];
assign MEM_W=mux_out[2];
assign EXE_CMD=mux_out[6:3];
assign B=mux_out[7];
assign S=mux_out[8];

endmodule
