module B_latchRSe(
	input clock, R, S,
	output Q
);
	wire Qa, Qb;
	assign Qa = ~((R & clock) | Qb);
	assign Qb = ~((S & clock) | Qa);
	assign Q = Qa;
endmodule
