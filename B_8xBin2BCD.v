module B_8xBin2BCD(
	input  [7:0]numBin,
	output [9:0]numBCD
);

/*
	8-BIT BINARY TO BCD CONVERTER
	-----------------------------
	[+] Using Double Dabble
	[+] Flow: https://johnloomis.org/ece314/notes/devices/binary_to_BCD/bcd04.png
	
*/

	wire [3:0]add3Out[6:0];
	B_add3BCD C1({1'b0, numBin[7:5]}, add3Out[6][3:0]);
	B_add3BCD C2({add3Out[6][2:0], numBin[4]}, add3Out[5][3:0]);
	B_add3BCD C3({add3Out[5][2:0], numBin[3]}, add3Out[4][3:0]);
	B_add3BCD C4({add3Out[4][2:0], numBin[2]}, add3Out[3][3:0]);
	B_add3BCD C5({add3Out[3][2:0], numBin[1]}, add3Out[2][3:0]);
	
	B_add3BCD C6({1'b0, add3Out[6][3], add3Out[5][3], add3Out[4][3]}, add3Out[1][3:0]);
	B_add3BCD C7({add3Out[1][2:0], add3Out[3][3]}, add3Out[0][3:0]);
	
	assign numBCD[9]   = add3Out[1][3];
	assign numBCD[8:5] = add3Out[0][3:0];
	assign numBCD[4:1] = add3Out[2][3:0];
	assign numBCD[0]   = numBin[0];

endmodule

module testBenchbin2bcd;
	reg  [7:0]binx;
	wire [9:0]bcdy;
	B_8xBin2BCD testconv(binx, bcdy);
	initial begin
		binx=8'b00001111; #100;
		binx=8'b11111111; #100;
	end
endmodule
