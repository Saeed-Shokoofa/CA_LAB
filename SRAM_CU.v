module SRAM_CU (clk,rst,wr_en,rd_en,adr,wr_data,rd_data,ready,SRAM_DQ,SRAM_adr,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N);
input clk,rst,wr_en,rd_en;
input [31:0]adr,wr_data;

output reg SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N;
output reg [63:0] rd_data;
output [17:0]SRAM_adr;
output ready;
inout [15:0]SRAM_DQ;

reg [2:0]ps,ns;
wire [31:0]s_adr;
reg [63:0]temp_data=0;

always @(posedge clk,posedge rst) begin
    if(rst)
        ps<=0;
    else
        ps<=ns; 
end

always@(wr_en,rd_en,ps,SRAM_DQ) begin
    {rd_data,SRAM_UB_N,SRAM_LB_N,SRAM_CE_N,SRAM_OE_N}<=0;
    SRAM_WE_N=1'b1;
    // SRAM_DQ=16'bzzzzzzzzzzzzzzzz;
    case(ps)
    3'b000: begin
        ns<=ps;
        if(wr_en)begin
            ns<=ps+3'd1;
        end
        if(rd_en)begin
            // SRAM_adr={s_adr[18:2],1'b0};
            ns<=ps+3'd1;
			temp_data[15:0]=SRAM_DQ;
        end
        if(wr_en&&~s_adr[2])begin
            // SRAM_adr={s_adr[18:2],1'b0};
            // SRAM_DQ=wr_data[15:0];
            SRAM_WE_N=1'b0;
            ns<=ps+3'd1;
        end
    end
    3'b001:begin
        ns<=ps;
        if(wr_en)begin
            ns<=ps+3'd1;
        end
        if(rd_en)begin
            // SRAM_adr={s_adr[18:2],1'b1};
            // rd_data[15:0]=SRAM_DQ;
            temp_data[31:16]=SRAM_DQ;
            ns<=ps+3'd1;
        end
        if(wr_en&&~s_adr[2])begin
            // SRAM_adr={s_adr[18:2],1'b1};
            // SRAM_DQ=wr_data[31:16];
            SRAM_WE_N=1'b0;
            ns<=ps+3'd1;
        end
    end
    3'b010:begin
        ns<=ps+3'd1;
        if(rd_en)begin
            temp_data[47:32]=SRAM_DQ;
        end
        if(wr_en&&s_adr[2])begin
            // SRAM_adr={s_adr[18:2],1'b1};
            // SRAM_DQ=wr_data[31:16];
            SRAM_WE_N=1'b0;
        end
    end
    3'b011: begin if(rd_en)begin
             temp_data[63:48]=SRAM_DQ;
        end
        if(wr_en&&s_adr[2])begin
            // SRAM_adr={s_adr[18:2],1'b1};
            // SRAM_DQ=wr_data[31:16];
            SRAM_WE_N=1'b0;
        end
        ns<=ps+3'd1;
    end
    3'b101:begin rd_data<=temp_data; ns<=0;  end
    default: ns<=ps+3'd1;
    endcase
end

assign SRAM_DQ=(wr_en&&(ps==3'b000||ps==3'b010))?wr_data[15:0]:(wr_en&&(ps==3'b001||ps==3'b011))?
                wr_data[31:16]:16'bzzzzzzzzzzzzzzzz;

// assign temp_data[15:0]=(rd_en&&(ps==3'b001))?SRAM_DQ:16'd0;
// assign temp_data[31:16]=(rd_en&&(ps==3'b010))?SRAM_DQ:16'd0;
assign ready=((~rd_en&~wr_en)|(ps==3'b101))?1'b1:1'b0;
assign s_adr=adr-32'd1024;
assign SRAM_adr=(ps==3'b000)?{s_adr[18:3],2'b0}:(ps==3'b001)?{s_adr[18:3],2'b01}:(ps==3'b010)?{s_adr[18:3],2'b10}:(ps==3'b011)?{s_adr[18:3],2'b11}:0;
// assign SRAM_WE_N=((ps[2:1]==2'b0)&&(wr_en==1'b1))?1'b0:1'b1;

endmodule