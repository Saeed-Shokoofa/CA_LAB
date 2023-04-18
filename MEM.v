module MEM(clk,ALU_res,val_rm,MEM_W_EN,MEM_R_EN,WB_EN,Dest,DATA,ALU_res_out,Dest_out,MEM_R_EN_out,WB_EN_out);
input clk,MEM_W_EN,MEM_R_EN,WB_EN;
input [3:0]Dest;
input [31:0]ALU_res,val_rm
output MEM_R_EN_out,WB_EN_out;
output [3:0]Dest_out;
output [31:0]DATA,ALU_res_out;
memory my_mem(clk(clk),.adr(ALU_res),.data_in(val_rm),.MEM_W_EN(MEM_W_EN),.MEM_R_EN(MEM_R_EN),.DATA(DATA));
assign ALU_res_out=ALU_res;
assign Dest_out=Dest;
assign MEM_R_EN_out=MEM_R_EN;
assign WB_EN_out=WB_EN;

endmodule