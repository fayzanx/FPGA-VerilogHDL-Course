module lab02part05(
	input  [7:0]numA,
	input  [7:0]numB,
	output [11:0]sumBCD
);
		assign sumBCD[11:9] = 3'b000;
		B_2dBCDAdder get2DigitBCD(1'b0, numA[7:0], numB[7:0], sumBCD[8], sumBCD[7:0]);
endmodule


//VERIFICATION
module testBenchl2p5;
	reg  [7:0]a;
	reg  [7:0]b;
	wire [3:0]h, t, u;
	lab02part05	testl2p5(a, b, {h, t, u});
	initial begin
		a = {4'b0001, 4'b0001}; b = {4'b0001, 4'b0001};	#100;
		a = {4'b1000, 4'b0001}; b = {4'b0001, 4'b0001};	#100;
		a = {4'b1001, 4'b1001}; b = {4'b1001, 4'b1001};	#100;
		a = {4'b0001, 4'b0000}; b = {4'b0001, 4'b0000};	#100;
	end
endmodule