module Val2gen_TB();
    reg [31:0]Rm=0;
    reg [11:0]Shift_Operand=0;
    reg imm=0,en=0;
    wire [31:0]out;
    val2gen v2n(Rm,Shift_Operand,imm,en,out);
    

    initial begin
        #30 en=1;
        #30 Shift_Operand=12'b110010101111;
        #30 Rm=32'd10;
        #30 imm=1;
        #80 $stop;
    end
endmodule