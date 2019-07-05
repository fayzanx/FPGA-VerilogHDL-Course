/*  ARRAY MULTIPLIER */
module lab06part05(
    output [3:0]ans,
	input  [1:0]a, b
);
    multiplierNx #(2) multhem(ans, a, b);
endmodule

module tbtest;
    reg [1:0]a,b;
    wire [3:0]ans;
    lab06part05 testl6p5(ans, a, b);
    initial begin
        #100; a = 2'b01; b=2'b01;
        #100; a = 2'b11; b=2'b01;
        #100; a = 2'b10; b=2'b01;
        #100; a = 2'b11; b=2'b11;
    end
endmodule