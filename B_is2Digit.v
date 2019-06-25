module B_is2Digit(
	input [3:0]num,
	output z
);
/*
	Checks if the given 4-bit number is greater than 9.
*/
	assign z = (num[3] & (num[2] | num[1] | num[0]));
endmodule