module condition_check(input [3:0]cond,input z,c,n,v,output reg out);

always@(*) begin
    case(cond)
    4'b0000:out=(z==1'b1)?1:0;
    4'b0010:out=(c==1'b1)?1:0;
    4'b0011:out=(c==1'b0)?1:0;
    4'b0100:out=(n==1'b1)?1:0;
    4'b0101:out=(n==1'b0)?1:0;
    4'b0110:out=(v==1'b1)?1:0;
    4'b0111:out=(v==1'b0)?1:0;
    4'b1000:out=({c,z}==2'b10)?1:0;
    4'b1001:out=(c==1'b0)?1:(z==1'b1)?1:0;
    4'b1010:out=(n==v)?1:0;
    4'b1011:out=(n!=v)?1:0;
    4'b1100:out=(z==1'b0&&n==v)?1:0;
    4'b1101:out=(z==1)?1:(n!=v)?1:0;
    4'b1110:out=1'b1;
    4'b1111:out=1'b1;
    endcase
end

endmodule