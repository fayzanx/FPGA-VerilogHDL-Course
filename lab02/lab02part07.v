module lab02part07(
	input  [5:0]SW,
	output [6:0]HEX1, HEX0
);
	wire [9:0]numBCD;	//10-bit [0~255]
	B_8xBin2BCD getBCD({2'b00, SW[5:0]}, numBCD[9:0]);
	B_7SegDec showTens(numBCD[7:4], HEX1[6:0]);
	B_7SegDec showUnts(numBCD[3:0], HEX0[6:0]);

endmodule

module tBl2p7;
	reg  [5:0]sw;
	wire [6:0]h1, h0;
	lab02part07 testl2p7(sw, h1, h0);
	initial begin
		sw = 6'b001000; #100;
		sw = 6'b010000; #100;
		sw = 6'b100000; #100;
		sw = 6'b111111; #100;
	end
endmodule