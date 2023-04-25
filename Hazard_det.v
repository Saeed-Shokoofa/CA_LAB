module haz_det(src1,src2,Two_src,MEM_dest,MEM_WB,exe_dest,exe_WB_EN,exe_MEM_R,forward_en,freeze);
input [3:0]src1,src2,MEM_dest,exe_dest;
input Two_src,MEM_WB,exe_WB_EN,exe_MEM_R,forward_en;
output freeze;

reg first,second;

always @(*) begin
    {first,second}=0;
    if(~forward_en)begin
        if((MEM_WB && (MEM_dest==src1)) || (exe_WB_EN && (exe_dest==src1)))begin
            first=1'b1;
        end
        else 
            first=1'b0;
        if((MEM_WB && (MEM_dest==src2)) || (exe_WB_EN && (exe_dest==src2)))begin
            second=1'b1;
        end
        else 
            second=1'b0;
    end
    else if(exe_MEM_R) begin
        if((src1==exe_dest)&&(exe_WB_EN==1'b1))
            first=1'b1;
        if((src2==exe_dest)&&(exe_WB_EN==1'b1))
            second=1'b1;
    end
end

assign freeze=(Two_src)?(first|second):first;

endmodule