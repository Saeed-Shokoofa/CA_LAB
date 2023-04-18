module ARM(clk,rst);

input clk,rst;
wire if_br_taken,exe_br_taken,id_z,id_c,id_n,id_v,id_WB_EN,id_MEM_R,id_MEM_W,id_B,id_S,id_imm,id_cry_out,id_imm_out,id_B_out,id_S_out,id_MEM_W_out,id_MEM_R_out,id_WB_EN_out;
wire exe_WB_EN,exe_MEM_R,exe_MEM_W,exe_MEM_W_out,exe_MEM_R_out,exe_WB_EN_out;
wire [3:0]id_EXE_CMD,id_dest,id_dest_out,id_EXE_CMD_out,exe_dest,exe_dest_out,mem_dest,MEM_dest_out,WB_WB_dest;
wire [11:0]id_shift_operand,id_shift_operand_out;
wire [23:0]id_signed_imm,id_signed_imm_out;
wire [31:0]if_br_adr,if_pc,if_inst,if_pc_out,if_inst_out,id_PC,id_val_rn,id_val_rm,id_val_rn_out,id_val_rm_out,id_PC_out,exe_ALU_res,exe_val_rm,exe_br_adr,exe_val_rm_out,exe_ALU_res_out;
wire [31:0]MEM_DATA,MEM_ALU_res,MEM_ALU_res_out,MEM_DATA_out,WB_WB_val;
wire freeze,MEM_MEM_R,MEM_WB_EN,MEM_WB_EN_out,MEM_MEM_R_out,WB_WB_EN;
wire [3:0]src2forhaz;

IF IF_stg(.clk(clk),.rst(rst),.freeze(freeze),.Branch_taken(if_br_taken),.Branch_Addr(if_br_adr),.PC(if_pc),.Instruction(if_inst));

IF_reg IF_register(.clk(clk),.rst(rst),.freeze(freeze),.flush(exe_br_taken),.PC_in(if_pc),.Instruction_in(if_inst),.PC(if_pc_out),.Instruction(if_inst_out));

ID ID_stg(.clk(clk),.rst(rst),.freeze(freeze),.z(id_z),.c(id_c),.n(id_n),.v(id_v),.instruction(if_inst_out),.PC(if_pc_out),.WB_WB_EN(WB_WB_EN),.WB_Value(WB_WB_val),.WB_Dest(WB_WB_dest),.
    WB_EN(id_WB_EN),.MEM_R(id_MEM_R),.MEM_W(id_MEM_W),.EXE_CMD(id_EXE_CMD),.B(id_B),.S(id_S),.PC_out(id_PC),.val_rn(id_val_rn),.val_rm(id_val_rm),.dest(id_dest),.signed_imm(id_signed_imm),.imm(id_imm),.Shift_Operand(id_shift_operand),.src2forhaz(src2forhaz));

ID_REG ID_rsgister(.clk(clk),.rst(rst),.flush(exe_br_taken),.carry(id_c),.dest(id_dest),.signed_imm(id_signed_imm),.Shift_Operand(id_shift_operand),.imm(id_imm),.val_rm(id_val_rm),.val_rn(id_val_rn),.PC(id_PC),.S(id_S),.B(id_B),.EXE_CMD(id_EXE_CMD),.MEM_W(id_MEM_W),.MEM_R(id_MEM_R),.WB_EN(id_WB_EN),.
    carry_out(id_cry_out),.dest_out(id_dest_out),.signed_imm_out(id_signed_imm_out),.Shift_Operand_out(id_shift_operand_out),.imm_out(id_imm_out),.val_rm_out(id_val_rm_out),.val_rn_out(id_val_rn_out),.PC_out(id_PC_out),.S_out(id_S_out),.B_out(id_B_out),.
    EXE_CMD_out(id_EXE_CMD_out),.MEM_W_out(id_MEM_W_out),.MEM_R_out(id_MEM_R_out),.WB_EN_out(id_WB_EN_out));

EXE EXE_stg(.clk(clk),.rst(rst),.WB_EN(id_WB_EN_out),.MEM_R(id_MEM_R_out),.MEM_W(id_MEM_W_out),.EXE_CMD(id_EXE_CMD_out),.B(id_B_out),.S(id_S_out),.PC(id_PC_out),.val_rn(id_val_rn_out),.val_rm(id_val_rm_out),.imm(id_imm_out),.Shift_Operand(id_shift_operand_out),.signed_imm(id_signed_imm_out),.dest(id_dest_out),.carry(id_cry_out),.
    WB_EN_out(exe_WB_EN),.MEM_R_out(exe_MEM_R),.MEM_W_out(exe_MEM_W),.ALU_res(exe_ALU_res),.val_rm_out(exe_val_rm),.dest_out(exe_dest),.branch_adr(exe_br_adr),.status_out({id_z,id_c,id_n,id_v}),.branch_taken(exe_br_taken));

EXE_reg EXE_register(.clk(clk),.rst(rst),.dest(exe_dest),.val_rm(exe_val_rm),.ALU_res(exe_ALU_res),.MEM_W(exe_MEM_W),.MEM_R(exe_MEM_R),.WB_EN(exe_WB_EN),.
    dest_out(exe_dest_out),.val_rm_out(exe_val_rm_out),.ALU_res_out(exe_ALU_res_out),.MEM_W_out(exe_MEM_W_out),.MEM_R_out(exe_MEM_R_out),.WB_EN_out(exe_WB_EN_out));

MEM mem_stg(.clk(clk),.ALU_res(exe_ALU_res_out),.val_rm(exe_val_rm_out),.MEM_W_EN(exe_MEM_W_out),.MEM_R_EN(exe_MEM_R_out),.WB_EN(exe_WB_EN_out),.Dest(exe_dest_out),.
    DATA(MEM_DATA),.ALU_res_out(MEM_ALU_res),.Dest_out(mem_dest),.MEM_R_EN_out(MEM_MEM_R),.WB_EN_out(MEM_WB_EN));

MEM_REG MEM_register(.clk(clk),.rst(rst),.WB_EN(MEM_WB_EN),.MEM_R(MEM_MEM_R),.ALU_res(MEM_ALU_res),.data_mem(MEM_DATA),.dest(mem_dest),.
WB_EN_out(MEM_WB_EN_out),.MEM_R_out(MEM_MEM_R_out),.ALU_res_out(MEM_ALU_res_out),.data_mem_out(MEM_DATA_out),.dest_out(MEM_dest_out));

WB WB_stg(.WB_EN(MEM_WB_EN_out),.MEM_R(MEM_MEM_R_out),.ALU_res(MEM_ALU_res_out),.data_mem(MEM_DATA_out),.dest(MEM_dest_out),.
    WB_EN_out(WB_WB_EN),.WB_val(WB_WB_val),.WB_Dest_out(WB_WB_dest));

haz_det HDU(.src1(if_inst_out[19:16]),.src2(src2forhaz/*mux_out*/),.Two_src(id_MEM_W|~id_imm),.MEM_dest(exe_dest_out),.MEM_WB(exe_WB_EN_out),.exe_dest(id_dest_out),.exe_WB_EN(id_WB_EN_out),.freeze(freeze));
//assign freeze=1'b0;

endmodule
