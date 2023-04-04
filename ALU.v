module ALU(src1,src2,cmd,carry,out,status_out);
input [31:0]src1,src2;
input [3:0]cmd;
input carry;
output [31:0]out;
output reg[3:0] status_out;
reg [32:0]outt;

always@(*) begin
    status_out[3]=0;
    case(cmd)
    4'b0001:outt=src2;
    4'b1001:outt=~{src2};
    4'b0010:begin outt=src1+src2;  status_out[3]=(src1[31] && src2[31] && ~outt[31])||(~src1[31] && ~src2[31] && outt[31]); end
    4'b0011:begin outt=src1+src2+carry;  status_out[3]=(src1[31] && src2[31] && ~outt[31])||(~src1[31] && ~src2[31] && outt[31]); end
    4'b0100:begin outt=src1-src2;  status_out[3]=(src1[31] && ~src2[31] && ~outt[31])||(~src1[31] && src2[31] && outt[31]); end
    4'b0101:begin outt=src1-src2-~carry; status_out[3]=(src1[31] && ~src2[31] && ~outt[31])||(~src1[31] && src2[31] && outt[31]); end
    4'b0110:outt=src1&src2;
    4'b0111:outt=src1|src2;
    4'b1000:outt=src1^src2;
    endcase
    status_out[0]=&{~outt};
    status_out[1]=outt[32];
    status_out[2]=outt[31];

end
// z c n v
assign out=outt[31:0];

endmodule