module MEM(input clk,input [31:0]adr,data_in,input MEM_W_EN,MEM_R_EN,WB_EN,Dest,output [31:0]DATA,adr,output Dest,MEM_R_EN,WB_EN);
    reg [7:0]mem[0:1023];
    always @(negedge clk)begin
        if(MEM_R_EN)begin
            DATA <= {mem[((adr-32'd1024))],mem[((adr-32'd1024))+32'd1],mem[((adr-32'd1024))+32'd2],mem[((adr-32'd1024))+32'd3]};
        end
        else if(MEM_W_EN)begin
            {mem[((adr-32'd1024))],mem[((adr-32'd1024))+32'd1],mem[((adr-32'd1024))+32'd2],mem[((adr-32'd1024))+32'd3]} <= data_in; 
        end
    end
endmodule