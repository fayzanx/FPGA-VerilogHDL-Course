module B_flipflopDmse(
	input  CLCK, D,
	output Q
);
	wire Qm, Qs, CL2;
	assign CL2 = ~CLCK;
	B_latchDe ffa(CL2, D, Qm);
	B_latchDe ffb(CLCK, Qm, Qs);
	assign Q = Qs;
endmodule