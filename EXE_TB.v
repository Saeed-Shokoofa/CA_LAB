module EXE_TB();
reg clk=0,rst=0,WB_EN=0,MEM_R=0,MEM_W=0,B=0,S=0,imm=0,carry=0;
reg [3:0]EXE_CMD=0,dest=0;reg [31:0]PC=0,val_rn=0,val_rm=0;
reg [11:0]Shift_Operand=0;reg [23:0]signed_imm=0;
wire WB_EN_out,MEM_R_out,MEM_W_out,branch_taken;
wire [31:0]ALU_res,val_rm_out,branch_adr;
wire [3:0] dest_out,status_out;
EXE test_exe(clk,rst,WB_EN,MEM_R,MEM_W,EXE_CMD,B,S,PC,val_rn,val_rm,imm,Shift_Operand,signed_imm,dest,carry,WB_EN_out,MEM_R_out,MEM_W_out,ALU_res,val_rm_out,dest_out,branch_adr,status_out,branch_taken);
always #10 clk=~clk;
initial begin
    #10 rst=1;
    #20 rst=0;
    #30 val_rm=32'd6;val_rn=32'd10;MEM_R=1;
    #30 EXE_CMD=4'b0100;
    #800 $stop;

end 
endmodule
