module B_4xMUX2to1(
	input S,
	input [3:0]numA, numB,
	output [3:0]M
);
	B_1xMUX2to1 m3(S, numA[3], numB[3], M[3]);
	B_1xMUX2to1 m2(S, numA[2], numB[2], M[2]);
	B_1xMUX2to1 m1(S, numA[1], numB[1], M[1]);
	B_1xMUX2to1 m0(S, numA[0], numB[0], M[0]);
endmodule
