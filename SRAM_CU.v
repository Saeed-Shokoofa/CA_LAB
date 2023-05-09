module SRAM_CU (clk,rst,wr_en,rd_en,adr,wr_data,rd_data,ready,SRAM_DQ,SRAM_adr,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N);
input clk,rst,wr_en,rd_en;
input [31:0]adr,wr_data;

output reg SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N;
output reg [31:0] rd_data;
output reg [17:0]SRAM_adr;
output ready;
inout [15:0]SRAM_DQ;

reg [2:0]ps;

wire [31:0]temp_data;

always@(posedge clk,posedge rst) begin
    if(rst) begin
        ps<=0;
        {rd_data,SRAM_adr,SRAM_UB_N,SRAM_LB_N,SRAM_CE_N,SRAM_OE_N}<=0;
    end
    else begin
        {SRAM_UB_N,SRAM_LB_N,SRAM_CE_N,SRAM_OE_N,SRAM_adr}=0;
        //SRAM_WE_N=1'b1;
        // SRAM_DQ=16'bzzzzzzzzzzzzzzzz;
        case(ps)
        3'b000: begin
            if(rd_en)begin
                SRAM_adr={adr[18:2],2'b00}-18'd1024;
                ps<=ps+3'd1;
            end
            if(wr_en)begin
                SRAM_adr={adr[18:2],2'b00}-18'd1024;
                // SRAM_DQ=wr_data[15:0];
                //SRAM_WE_N=1'b0;
                ps<=ps+3'd1;
            end
        end
        3'b001:begin
            if(rd_en)begin
                SRAM_adr={adr[18:2],2'b10}-18'd1024;
                // rd_data[15:0]=SRAM_DQ;
                ps<=ps+3'd1;
            end
            if(wr_en)begin
                SRAM_adr={adr[18:2],2'b10}-18'd1024;
                // SRAM_DQ=wr_data[31:16];
                //SRAM_WE_N=1'b0;
                ps<=ps+3'd1;
            end
        end
        // 3'b010:begin
        //     if(rd_en)begin
        //         // rd_data[31:16]=SRAM_DQ;
        //     end
        // end
        3'b101:begin rd_data<=temp_data; ps<=0;  end
        default: ps<=ps+3'd1;
        endcase
    end
end

assign SRAM_DQ=(wr_en&&(ps==3'b000))?wr_data[15:0]:(wr_en&&(ps==3'b001))?
                wr_data[31:16]:16'bzzzzzzzzzzzzzzzz;

assign temp_data[15:0]=(rd_en&&(ps==3'b001))?SRAM_DQ:16'd0;
assign temp_data[31:16]=(rd_en&&(ps==3'b010))?SRAM_DQ:16'd0;
assign ready=((~rd_en&~wr_en)|(ps==3'b101))?1'b1:1'b0;
assign SRAM_WE_N=((ps[2:1]==2'b0)&&(wr_en==1'b1))?1'b0:1'b1;

endmodule