module mux4to1 #(parameter n=32) (i0,i1,i2,i3,sel,out);
    input [n-1:0]i0,i1,i2,i3;
    input [1:0]sel;
    output [n-1:0]out;

    assign out=(sel==2'b00)?i0:
        (sel==2'b01)?i1:
        (sel==2'b10)?i2:
        i3;
endmodule