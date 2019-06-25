module B_latchDe(
	input CLK, D,
	output Q
);
	wire Qa, Qb/* synthesis keep */;
	assign Qa = ~(~(D & CLK) & Qb);
	assign Qb = ~(~(~D & CLK) & Qa);
	assign Q  = Qa;
	
endmodule

