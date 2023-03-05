module CU(opcode,mode,s);
input [3:0] opcode;
input [1:0] mode;
input s;
output WB_EN,MEM_R,MEM_W,B,S;
output [3:0] EXE_CMD;

always @(*) begin
    if(mode==2'b00)begin
        case(opcode)
            4'b0000:
            4'b1101:
            4'b1111:
            4'b0100:
            4'b0101:
            4'b0010:
            4'b0110:
            4'b0000:
            4'b1100:
            4'b0001:
            4'b1010:
            4'b1000:
        endcase
    end
    else if(mode==2'b01&&opcode==4'b0100) begin

    end
    else if(mode==2'b10) begin

    end
    
end


endmodule