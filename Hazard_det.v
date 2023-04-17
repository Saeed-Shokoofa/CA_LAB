module haz_det(src1,src2,Two_src,MEM_dest,MEM_WB,exe_dest,exe_WB_EN,freeze);
input [3:0]src1,src2,MEM_dest,exe_dest;
input Two_src,MEM_WB,exe_WB_EN;
output freeze;

reg first,second;

always @(*) begin
    if((MEM_WB&&MEM_dest==src1)||(exe_WB_EN&&exe_dest==src1))begin
        first=1'b1;
    end
    if((MEM_WB&&MEM_dest==src2)||(exe_WB_EN&&exe_dest==src2))begin
        second=1'b1;
    end
end

assign freeze=(Two_src)?(first|second):first;

endmodule