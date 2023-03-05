module CU(opcode,mode,s,WB_EN,MEM_R,MEM_W,B,S_OUT,EXE_CMD);
input [3:0] opcode;
input [1:0] mode;
input s;
output reg WB_EN,MEM_R,MEM_W,B,S_OUT;
output reg [3:0] EXE_CMD;

always @(*) begin
    {WB_EN,MEM_R,MEM_W,B,S_OUT,EXE_CMD}=0;
    S_OUT=s;
    if(mode==2'b00)begin
        case(opcode)
            4'b0000:{WB_EN,MEM_R,MEM_W,B,S_OUT,EXE_CMD}=0;
            4'b1101:{WB_EN,EXE_CMD}=5'b10001;
            4'b1111:{WB_EN,EXE_CMD}=5'b11001;
            4'b0100:{WB_EN,EXE_CMD}=5'b10010;
            4'b0101:{WB_EN,EXE_CMD}=5'b10011;
            4'b0010:{WB_EN,EXE_CMD}=5'b10100;
            4'b0110:{WB_EN,EXE_CMD}=5'b10101;
            4'b0000:{WB_EN,EXE_CMD}=5'b10110;
            4'b1100:{WB_EN,EXE_CMD}=5'b10111;
            4'b0001:{WB_EN,EXE_CMD}=5'b11000;
            4'b1010:{EXE_CMD}=4'b0100;
            4'b1000:{EXE_CMD}=4'b0110;
        endcase
    end
    else if(mode==2'b01&&opcode==4'b0100) begin
        if(s==1'b1)
            {MEM_R,WB_EN,EXE_CMD}=6'b110010;
        else
            {MEM_W,EXE_CMD}=5'b10010;
    end
    else if(mode==2'b10) begin
        {B}=1'b1;
    end
    
end


endmodule