module forwarding_unit(en,src1,src2,mem_WB,mem_Dest,WB_WB,WB_dest,sel_src1,sel_src2);
input [3:0]src1,src2,mem_Dest,WB_dest;
input mem_WB,WB_WB,en;
output reg[1:0]sel_src1,sel_src2;
always@(*)begin
    sel_src1=2'b00;
    sel_src2=2'b00;
    if(en)begin
        if(mem_WB==1'b1&&mem_Dest==src1)
            sel_src1=2'b01;
        else if(WB_WB==1'b1&&WB_dest==src1)
            sel_src1=2'b10;
        if(mem_WB==1'b1&&mem_Dest==src2)
            sel_src2=2'b01;
        else if(WB_WB==1'b1&&WB_dest==src2) 
            sel_src2=2'b10;
    end
end

endmodule