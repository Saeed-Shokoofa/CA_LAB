module memory(input clk,input [31:0]adr,data_in,input MEM_W_EN,MEM_R_EN,output reg[31:0]DATA);
wire [31:0]real_adr;
reg [7:0]mem[0:31];
    always @(negedge clk)begin
        if(MEM_R_EN)begin
            DATA <= {mem[((real_adr-32'd1024))],mem[((real_adr-32'd1024))+32'd1],mem[((real_adr-32'd1024))+32'd2],mem[((real_adr-32'd1024))+32'd3]};
        end
        else if(MEM_W_EN)begin
            {mem[((real_adr-32'd1024))],mem[((real_adr-32'd1024))+32'd1],mem[((real_adr-32'd1024))+32'd2],mem[((real_adr-32'd1024))+32'd3]} <= data_in; 
        end
    end
assign real_adr={adr[31:2],2'b0};
endmodule
