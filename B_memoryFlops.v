/*	GATED D LATCH */
module mem_DLatch(
	output reg Q,
	input D, clk
);
	always@(D, clk)
	begin
		if(clk)
			Q <= D;
	end
endmodule

/* POSITIVE EDGE TRIGGERED - D FLIP FLOP */
module mem_Dflippos(
	output reg Q,
	input D, clk
);
	always@(posedge clk)
	begin
		Q <= D;
	end
endmodule


/* NEGATIVE EDGE TRIGGERED - D FLIP FLOP */
module mem_Dflipneg(
	output reg Q,
	input D, clk
);
	always@(negedge clk)
	begin
		Q <= D;
	end
endmodule