module WB(WB_EN,MEM_R,ALU_res,data_mem,dest,WB_EN_out,WB_val,WB_Dest_out);
input WB_EN,MEM_R;
input [3:0]dest;
input [31:0]ALU_res,data_mem;

output WB_EN_out;
output [3:0]WB_Dest_out;
output [31:0]WB_val;

mux2to1 #(32)MM1(.sel(MEM_R),.in1(ALU_res),.in2(data_mem),.out(WB_val));

assign WB_Dest_out=dest;
assign WB_EN_out=WB_EN;

endmodule
