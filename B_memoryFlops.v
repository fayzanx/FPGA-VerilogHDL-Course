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

module mem_Tflippos(
	output reg Q,
	input T, clk, reset
);
	wire d;
	xor(d, Q, T);
	
	always@(posedge clk)
	begin
		if(~reset)
			Q <= 1'b0;
		//else if(T)
		//	Q <= ~Q;
		else
			Q <= d;
	end
endmodule


// T FLIP FLOP & AND GATE
//[out+and][out][X][CLK][RESN]
module lab04part01_TFlipAnd(
	output Y, ya,
	input  X, CLK, RESN
);
	mem_Tflippos createTflip1(ya, X, CLK, RESN);
	assign Y = (ya & X);
endmodule