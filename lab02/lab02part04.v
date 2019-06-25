module lab02part04(
	input  [8:0]SW,
	output [4:0]LEDG,			//BCD Sum
	output [8:0]LEDR,			//Output
	output [6:0]HEX3, HEX2, HEX1, HEX0
);
	//Showing IN on HEX
	B_7SegDec showA(SW[7:4], HEX3[6:0]);
	B_7SegDec showB(SW[3:0], HEX2[6:0]);

	//adding the BCD Numbers
	wire [4:0]adderSum;
	B_4xFullAdderRipple addAB(SW[8], SW[7:4], SW[3:0], adderSum[4], adderSum[3:0]);
	assign LEDR[8:0] = SW[8:0];		//LED Rep of IN
	assign LEDG[4:0] = adderSum[4:0];//LED Rep of OUT
	
	//Z determination	
	wire L, E, G;
	B_8xComp comparator({3'b000,adderSum}, {8'h10}, L, E, G);
	B_7SegDec digitTens({3'b000, G}, HEX1[6:0]);
	
	//Final SUM
	wire [3:0]adjSum, BCDSumS0;
	lab02part04_cA adjst(adderSum[3:0], adjSum[3:0]);
	B_4xMUX2to1	selS(G, adderSum[3:0], adjSum[3:0], BCDSumS0[3:0]);
	B_7SegDec digitUnits(BCDSumS0[3:0], HEX0[6:0]);
	

endmodule


// VERIFICATION
module testBenchl2p4;
	reg  [8:0]sw;
	wire [4:0]lg;
	wire [8:0]lr;
	wire [6:0]h3,h2,h1,h0;
	lab02part04 verifyl2p4(sw, lg, lr, h3, h2, h1, h0);
	initial begin
		sw = {1'b0, 4'b0000, 4'b0000}; #100;
		sw = {1'b0, 4'b0001, 4'b0001}; #100;
		sw = {1'b0, 4'b0001, 4'b1001}; #100;
		sw = {1'b0, 4'b1000, 4'b1000}; #100;
		sw = {1'b1, 4'b1001, 4'b1001}; #100;
		
		
	end
endmodule
