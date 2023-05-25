module MEM(clk,rst,ALU_res,val_rm,MEM_W_EN,MEM_R_EN,WB_EN,Dest,DATA,ALU_res_out,Dest_out,MEM_R_EN_out,WB_EN_out,ready,SRAM_DQ,SRAM_adr,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N);
input clk,rst,MEM_W_EN,MEM_R_EN,WB_EN;
input [3:0]Dest;
input [31:0]ALU_res,val_rm;
output MEM_R_EN_out,WB_EN_out,ready,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N;
output [17:0]SRAM_adr;
output [3:0]Dest_out;
output [31:0]DATA,ALU_res_out;

wire[31:0]sram_wdata,SRAM_CU_adr;
wire [63:0]sram_rdata;
inout[15:0] SRAM_DQ;

wire mux_out,write,sram_ready,sr_read;

//memory my_mem(.clk(clk),.adr(ALU_res),.data_in(val_rm),.MEM_W_EN(MEM_W_EN),.MEM_R_EN(MEM_R_EN),.DATA(DATA));

SRAM_CU SR_CU(.clk(clk),.rst(rst),.wr_en(write),.rd_en(sr_read),.adr(SRAM_CU_adr),.wr_data(sram_wdata),.rd_data(sram_rdata),.ready(sram_ready),
.SRAM_DQ(SRAM_DQ),.SRAM_adr(SRAM_adr),.SRAM_UB_N(SRAM_UB_N),.SRAM_LB_N(SRAM_LB_N),.SRAM_WE_N(SRAM_WE_N),.SRAM_CE_N(SRAM_CE_N),.SRAM_OE_N(SRAM_OE_N));

mux2to1 #(1)MMMEM(.sel(~ready),.in1(WB_EN),.in2(1'b0),.out(mux_out));

cache_CU CCU(.clk(clk),.rst(rst),.adr(ALU_res),.wdata(val_rm),.MEM_R_EN(MEM_R_EN),.MEM_W_EN(MEM_W_EN),.rdata(DATA),
.ready(ready),.sram_adr(SRAM_CU_adr),.sram_wdata(sram_wdata),.write(write),.sram_rdata(sram_rdata),.sram_ready(sram_ready),.read(sr_read));


assign ALU_res_out=ALU_res;
assign Dest_out=Dest;
assign MEM_R_EN_out=MEM_R_EN;
assign WB_EN_out=mux_out;

endmodule