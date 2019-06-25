module B_2dBCDAdder(
		input CIN,
		input [7:0]numA,
		input [7:0]numB,
		output COUT,
		output [7:0]sumBCD
);
	wire carry0;
	B_1dBCDAdder add0( CIN, numA[3:0], numB[3:0], carry0, sumBCD[3:0]);
	B_1dBCDAdder add1(carry0, numA[7:4], numB[7:4], COUT, sumBCD[7:4]);
endmodule
