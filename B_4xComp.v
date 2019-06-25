module B_4xComp(
	input  Ll, El, Gl,
	input  [3:0]numA, numB,
	output L, E, G
);

	wire x0, x1, x2, x3;	//XNOR
	wire Lh, Eh, Gh;
	assign x0 = ((numA[0] & numB[0]) | (~numA[0] & ~numB[0]));
	assign x1 = ((numA[1] & numB[1]) | (~numA[1] & ~numB[1]));
	assign x2 = ((numA[2] & numB[2]) | (~numA[2] & ~numB[2]));
	assign x3 = ((numA[3] & numB[3]) | (~numA[3] & ~numB[3]));
	
	assign Eh = (x0 & x1 & x2 & x3);
	assign Gh = ((numA[3] & ~numB[3]) | (x3 & numA[2] & ~numB[2]) |
					(x3 & x2 & numA[1] & ~numB[1]) | (x3 & x2 & x1 & numA[1] & ~numB[1]));
	assign Lh = ((~numA[3] & numB[3]) | (x3 & ~numA[2] & numB[2]) |
					(x3 & x2 & ~numA[1] & numB[1]) | (x3 & x2 & x1 & ~numA[1] & numB[1]));
	assign E  = (Eh & El);
	assign L  = ((Eh & Ll) | Lh);
	assign G  = ((Eh & Gl) | Gh);

endmodule


