module ARM(clk,rst);

input clk,rst;

IF IF_stg(.clk(clk),.rst(rst),.freeze(),.Branch_taken(),.Branch_Addr(),.PC(),.Instruction());
IF_reg IF_register(.clk(clk),.rst(rst),.freeze(),.flush(),.PC_in(),.Instruction_in(),.PC(),.Instruction());
ID ID_stg(.clk(clk),.rst(rst),.z(),.c(),.n(),.v(),.instruction(),.PC(),.WB_WB_EN(),.WB_Value(),.WB_Dest(),.
    WB_EN(),.MEM_R(),.MEM_W(),.EXE_CMD(),.B(),.S(),.PC_out(),.val_rn(),.val_rm(),.dest(),.signed_imm(),.imm(),.Shift_Operand());
ID_REG ID_rsgister(.clk(clk),.rst(rst),.flush(),.carry(),.dest(),.signed_imm(),.Shift_Operand(),.imm(),.val_rm(),.val_rn(),.PC(),.S(),.B(),.EXE_CMD(),.MEM_W(),.MEM_R(),.WB_EN(),.
    carry_out(),.dest_out(),.signed_imm_out(),.Shift_Operand_out(),.imm_out(),.val_rm_out(),.val_rn_out(),.PC_out(),.S_out(),.B_out(),.
    EXE_CMD_out(),.MEM_W_out(),.MEM_R_out(),.WB_EN_out());
EXE EXE_stg(.clk(clk),.rst(rst),.WB_EN(),.MEM_R(),.MEM_W(),.EXE_CMD(),.B(),.S(),.PC(),.val_rn(),.val_rm(),.imm(),.Shift_Operand(),.signed_imm(),.dest(),.carry(),.
    WB_EN_out(),.MEM_R_out(),.MEM_W_out(),.ALU_res(),.val_rm_out(),.dest_out(),.branch_adr(),.status_out(),.branch_taken());

endmodule