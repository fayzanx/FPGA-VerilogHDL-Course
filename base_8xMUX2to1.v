module base_8xMUX2to1 (	input s, 
								input [7:0] X, Y,
								output [7:0] M);			
							
	assign M[7] = ((~s & X[7])|(s & Y[7]));
	assign M[6] = ((~s & X[6])|(s & Y[6]));
	assign M[5] = ((~s & X[5])|(s & Y[5]));
	assign M[4] = ((~s & X[4])|(s & Y[4]));
	assign M[3] = ((~s & X[3])|(s & Y[3]));
	assign M[2] = ((~s & X[2])|(s & Y[2]));
	assign M[1] = ((~s & X[1])|(s & Y[1]));
	assign M[0] = ((~s & X[0])|(s & Y[0]));
	//assign M = ((~s & X) | (s & Y));
							
endmodule