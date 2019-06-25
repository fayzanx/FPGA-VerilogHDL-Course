module B_1xMUX2to1(
	input S, X, Y,
	output M
);
	assign M = ((~S & X) | (S & Y));
endmodule