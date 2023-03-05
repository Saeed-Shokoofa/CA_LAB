module IF(input clk,rst,freeze,Branch_taken, input[31:0] Branch_Addr,output reg [31:0] PC,output [31:0]Instruction );
	reg [7:0]mem[0:128];
	always @(posedge clk, posedge rst)begin
		if(rst) begin
		PC<= 32'b0;
	   {mem[0], mem[1], mem[2],    mem[3]}= 32'b00000000_00100010_00000000_00000000;
	   {mem[4], mem[5], mem[6],    mem[7]}= 32'b00000000_01100100_00000000_00000000;
	   {mem[8], mem[9], mem[10],  mem[11]}= 32'b00000000_10100110_00000000_00000000;
	   {mem[12], mem[13], mem[14], mem[15]}=32'b00000000_11101000_00010000_00000000;
	   {mem[16], mem[17], mem[18], mem[19]}=32'b00000001_00101010_00011000_00000000;
	   {mem[20], mem[21], mem[22], mem[23]}=32'b00000001_01101100_00000000_00000000;
	   {mem[24], mem[25], mem[26], mem[27]}=32'b00000001_10101110_00000000_00000000;
	   end
		else begin
			PC<=PC+32'd4;
		end
	end
	assign Instruction = {mem[PC], mem[PC+32'd1], mem[PC+32'd2], mem[PC+32'd3]};
endmodule
