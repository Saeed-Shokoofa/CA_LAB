module cache_CU (clk,rst,adr,wdata,MEM_R_EN,MEM_W_EN,rdata,ready,sram_adr,sram_wdata,write,read,sram_rdata,sram_ready);
    input clk,rst,MEM_R_EN,MEM_W_EN,sram_ready;
    input[31:0]adr,wdata;
    input[63:0]sram_rdata;
    output reg write,read;
    output ready;
    output reg[31:0]rdata,sram_adr,sram_wdata;

    reg [63:0]mem1[0:63];
    reg [63:0]mem2[0:63];
    reg [0:63]valid1=0;
    reg [0:63]valid2=0;
    reg [9:0]tag1[0:63];
    reg [9:0]tag2[0:63];
    reg [63:0]LRU=0;

    reg sec_data=0;
    reg [1:0]ps=0,ns=0;
    wire [31:0]data1,data2;

    wire hit0,hit1,hit;
    assign hit0=((adr[18:9]==tag1[adr[8:3]])&&valid1[adr[8:3]])?1'b1:1'b0;
    assign hit1=((adr[18:9]==tag2[adr[8:3]])&&valid2[adr[8:3]])?1'b1:1'b0;
    assign hit=hit0|hit1;

    assign data1=(adr[2])?mem1[adr[8:3]][63:32]:mem1[adr[8:3]][31:0];
    assign data2=(adr[2])?mem2[adr[8:3]][63:32]:mem2[adr[8:3]][31:0];

    integer i;
    always @(*) begin
        if(rst) begin
            for(i=0;i<64;i=i+1)begin
				tag1[i]=0;
                tag2[i]=0;
                mem1[i]=63'd10;
                mem2[i]=63'd10;
			end
        end
        {read,write,rdata}=0;
        sram_adr={adr[31:3],3'b000};
        case (ps)
        2'b00:rdata=(hit0)?data1:data2;
        2'b01:begin
            if(MEM_R_EN)begin
                read=1'b1;
                if(LRU[adr[8:3]])begin
                    valid1[adr[8:3]]=1'b1;
                    mem1[adr[8:3]]=sram_rdata;
                    tag1[adr[8:3]]=adr[18:9];
                end
                else begin
                    valid2[adr[8:3]]=1'b1;
                    mem2[adr[8:3]]=sram_rdata;
                    tag2[adr[8:3]]=adr[18:9];
                end
            end
            if(MEM_W_EN) begin
                if(hit0)
                    valid1[adr[8:3]]=1'b0;
                if(hit1)
                    valid2[adr[8:3]]=1'b0;
                sram_wdata=wdata;
                write=1'b1;
                sram_adr={adr[18:2],2'b0};
            end
        end
        // 2'b10:begin
        //     if(MEM_R_EN)begin
        //         sram_adr={adr[31:3],3'b100};
                
        //     end
        // end
        2'b11: begin
            rdata=(hit0)?data1:data2;
            LRU[adr[8:3]]=hit1;
        end
        endcase
    end
    
    always @(posedge clk,posedge rst) begin
        if(rst)begin
            ns<=0;
        end
        else begin
            case(ps)
            2'b00:ns=(hit&&MEM_R_EN)?2'b11:(MEM_R_EN|MEM_W_EN)?2'b01:2'b00;
            2'b01:ns=(sram_ready)?2'b11:2'b01;
            // 2'b10:ns=(sram_ready)?2'b11:2'b10;
            2'b11:ns=2'b00;
            endcase
        end
    end
    always @(posedge clk,posedge rst) begin
        if(rst)
            ps<=0;
        else
            ps<=ns;
    end
    assign ready=((~MEM_R_EN&~MEM_W_EN)|ps==2'b11);

endmodule
