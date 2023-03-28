module RegisterFile(input clk,rst,input[3:0] src1,src2,Dest_wb,input[31:0] Result_WB,input writeBackEn,output[31:0]reg1,reg2);
	reg [31:0]mem[15:0];
	integer i;
	always@(negedge clk)begin
		if(rst)begin
			for(i=0;i<16;i=i+1)begin
				mem[i]=32'd0;
			end
		end
		else begin
			if(writeBackEn)begin
				mem[Dest_wb]=Result_WB;
			end
		end
	end
	assign reg1=mem[src1];
	assign reg2=mem[src2];
endmodule
