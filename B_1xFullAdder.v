module B_1xFullAdder(
	input  A, B, C,
	output cot, sum
);

	assign cot = ((A & B) | (B & C) | (C & A));
	assign sum = ((~A & ~B & C) | (~A & B & ~C) | (A & ~B & ~C) | (A & B & C));

endmodule