module B_4xFullAdderRipple(
	input  CIN,
	input  [3:0]A, B,
	output COUT,
	output [3:0]S
);
`
	wire [2:0]carryAhead;
	B_1xFullAdder sum1(A[0], B[0], CIN, carryAhead[0], S[0]);
	B_1xFullAdder sum2(A[1], B[1], carryAhead[0], carryAhead[1], S[1]);
	B_1xFullAdder sum3(A[2], B[2], carryAhead[1], carryAhead[2], S[2]);
	B_1xFullAdder sum4(A[3], B[3], carryAhead[2], COUT, S[3]);
	
endmodule