module val2gen (input [31:0]Rm,input [11:0]Shift_Operand,input imm,en,output reg [31:0] out);
always@(*)begin
    if(en) begin
        if(imm) begin
            case(Shift_Operand[11:8])
            4'b0000:out={24'b0,Shift_Operand[7:0]};
            4'b0001:out={Shift_Operand[1:0],24'b0,Shift_Operand[7:2]};
            4'b0010:out={Shift_Operand[3:0],24'b0,Shift_Operand[7:4]};
            4'b0011:out={Shift_Operand[5:0],24'b0,Shift_Operand[7:6]};
            4'b0100:out={Shift_Operand[7:0],24'b0};
            4'b0101:out={2'b0,Shift_Operand[7:0],22'b0};
            4'b0110:out={4'b0,Shift_Operand[7:0],20'b0};
            4'b0111:out={6'b0,Shift_Operand[7:0],18'b0};
            4'b1000:out={8'b0,Shift_Operand[7:0],16'b0};
            4'b1001:out={10'b0,Shift_Operand[7:0],14'b0};
            4'b1010:out={12'b0,Shift_Operand[7:0],12'b0};
            4'b1011:out={14'b0,Shift_Operand[7:0],10'b0};
            4'b1100:out={16'b0,Shift_Operand[7:0],8'b0};
            4'b1101:out={18'b0,Shift_Operand[7:0],6'b0};
            4'b1110:out={20'b0,Shift_Operand[7:0],4'b0};
            4'b1111:out={22'b0,Shift_Operand[7:0],2'b0};
            endcase
        end
        else begin
            case(Shift_Operand[6:5])
            2'b00:out=Rm<<Shift_Operand[11:7];
            2'b01:out=Rm>>Shift_Operand[11:7];
            2'b10:out=Rm>>>Shift_Operand[11:7];
            2'b11:out=(Rm>>Shift_Operand[11:7])|(Rm<<~Shift_Operand[11:7]);
            endcase
        end
    end
end
endmodule