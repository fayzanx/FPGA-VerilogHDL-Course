module B_8xComp(
	input  [7:0]numA, numB,
	output LT, EQ, GT
);
	wire [2:0]resCompL;
	B_4xComp	compL(1'b0, 1'b1, 1'b0, numA[3:0], numB[3:0], resCompL[2], resCompL[1], resCompL[0]);
	B_4xComp	compH(resCompL[2], resCompL[1], resCompL[0], numA[7:4], numB[7:4], LT, EQ, GT);

endmodule
