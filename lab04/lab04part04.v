module lab04part04(
	output [9:0]LEDR,
	output [7:0]LEDG,
    output [6:0]HEX0,
	input CLOCK_50,
	input [0:0]SW
);
	wire noUse;
	wire [3:0]numDisp;
	wire ifInc;
	wire [25:0]countVal;
	clock_1s getDelay(countVal[25:0], ifInc, CLOCK_50);
	counter4x c4b(numDisp, noUse, 1'b1, ifInc, 1'b1);
    hexDecoder7Seg h0(HEX0, numDisp);
	
	assign LEDR[9:0] = countVal[25:16];
	assign LEDG[7:0] = countVal[15:8];
endmodule
