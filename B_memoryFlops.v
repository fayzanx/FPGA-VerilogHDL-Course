//D latch using logical expressions
//[../B_latchDe.v]
module B_latchDe(
	input CLK, D,
	output Q
);
	wire Qa, Qb/* synthesis keep */;
	assign Qa = ~(~(D & CLK) & Qb);
	assign Qb = ~(~(~D & CLK) & Qa);
	assign Q  = Qa;
	
endmodule


//RS Latch using Expressions
//[../B_latchRSe.v]
module B_latchRSe(
	input clock, R, S,
	output Q
);
	wire Qa, Qb;
	assign Qa = ~((R & clock) | Qb);
	assign Qb = ~((S & clock) | Qa);
	assign Q = Qa;
endmodule


//RS Latch using gate level modelling
//[../B_latchRSg.v]
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


//D Flip Flop
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
	input D, clk, resetN
);
	always@(posedge clk or negedge resetN)
	begin
		if(~resetN) begin
			Q <= 0;
		end //if
		else begin
			Q <= D;
		end
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

// 8-bit Register using D flops
// Instantiation: registerNx #(width) name(.Q(), .D(), .regCLK(), .regRESN());
module registerNx #(parameter regWidth=8)(
	output [regWidth-1 : 0]Q,
	input  [regWidth-1 : 0]D,
	input  regCLK, regRESN
);
	//parameter regWidth=8;
	genvar i;
	generate
		for(i=0; i<regWidth; i=i+1) begin: m
			mem_Dflippos df(Q[i], D[i], regCLK, regRESN);
		end //for
	endgenerate
endmodule

// 4-bit shift register using D flip flops
// Instantiation: shiftRegisterNx #(width) name(.Q(), .D(), .sregCLK(), .sregRESN());
module shiftRegisterNx #(parameter regWidth=4) (
	output [(regWidth-1):0]Q,
	input  D,
	input  sregCLK, sregRESN
);
	wire [(regWidth):0]shiftAhead;
	assign shiftAhead[0] = D;
	assign Q[(regWidth-1):0] = shiftAhead[(regWidth):1];
	genvar i;
	generate
		for(i=0; i<regWidth; i=i+1) begin: m
			mem_Dflippos df(shiftAhead[i+1], shiftAhead[i], sregCLK, sregRESN);
		end //for
	endgenerate
endmodule