module B_latchRSg(
	input clock, R, S,
	output Q
);
	wire Qa, Qb, R_g, S_g/* synthesis keep */;
	and(R_g, R, clock);
	and(S_g, S, clock);
	or(Qa, R_g, Qb);
	or(Qb, S_g, Qa);
	assign Q = Qa;

endmodule
