module B_1dBCDAdder(
	input CIN,
	input [3:0] numA, numB,
	output COUT,
	output [3:0] sumBCD
);
	wire [4:0]sumBin;
	wire [9:0]bcdMid;
	B_4xFullAdderRipple add0(CIN, numA[3:0], numB[3:0], sumBin[4], sumBin[3:0]);
	B_8xBin2BCD convertSum({3'b000, sumBin[4:0]}, bcdMid[9:0]);
	assign sumBCD[3:0] = bcdMid[3:0];
	assign COUT = bcdMid[4];
	
endmodule
