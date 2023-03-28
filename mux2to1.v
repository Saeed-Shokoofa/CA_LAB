module mux2to1 #(parameter n =32)(input sel,input[n-1:0] in1,in2,output[n-1:0] out);
	assign out=sel?in2:in1;
endmodule
