module ID_TB();
reg [31:0]instruction=0,PC=0,WB_Value=0;
reg clk=0,rst,z=0,c=0,n=0,v=0,WB_WB_EN=0;
reg [3:0]WB_Dest=0;
wire WB_EN,MEM_R,MEM_W,B,S;
wire [3:0]EXE_CMD,dest;
wire [31:0]PC_out,val_rn,val_rm;
wire imm;
wire [23:0] signed_imm;
wire [11:0]Shift_Operand;

ID IID(clk,rst,z,c,n,v,instruction,PC,WB_WB_EN,WB_Value,WB_Dest,
WB_EN,MEM_R,MEM_W,EXE_CMD,B,S,PC_out,val_rn,val_rm,dest,signed_imm,imm,Shift_Operand);

always #10 clk=~clk;

initial begin
    #25 rst=1'b1;
    #20 rst=1'b0;
    #20 instruction=32'b11100011101000000000000000010100; //mov
    #20 instruction=32'b11100011101000000001101000000001; //mov
    #20 instruction=32'b11100011101000000010000100000011; //mov
    #20 instruction=32'b11100000100100100011000000000010; //ADD
    #20 instruction=32'b11100000000001111000000000000011; //AND
    #20 instruction=32'b11100100100000000100000000001101; //STR
    #20 instruction=32'b10111010111111111111111111110111; //branch
end

endmodule