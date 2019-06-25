module B_add3BCD(
	input  [3:0]numIN,
	output [3:0]numOT
);
/*
Adds 3 if input > 4.
	Y3 | A + BC + BD	
	Y2	| AD + BC'D'	
	Y1	| B'C + CD + AD'	
	Y0	| AD' + A'B'D + BCD'	
*/
	assign numOT[3] = ((numIN[3]) | (numIN[2] & numIN[1]) | (numIN[2] & numIN[0]));
	assign numOT[2] = ((numIN[3] & numIN[0]) | (numIN[2] & ~numIN[1] & ~numIN[0]));
	assign numOT[1] = ((~numIN[2] & numIN[1]) | (numIN[1] & numIN[0]) | (numIN[3] & ~numIN[0]));
	assign numOT[0] = ((numIN[3] & ~numIN[0]) | (~numIN[3] & ~numIN[2] & numIN[0]) | (numIN[2] & numIN[1] & ~numIN[0]));
endmodule
