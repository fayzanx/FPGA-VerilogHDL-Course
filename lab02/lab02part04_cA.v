module lab02part04_cA(
	input  [3:0]X,
	output [3:0]Y
);
		assign Y[3] = ((~X[3] & X[1]));
		assign Y[2] = ((X[3] & ~X[1]) | (X[2] & X[1]));
		assign Y[1] = (~X[1]);
		assign Y[0] = X[0];
		
endmodule
