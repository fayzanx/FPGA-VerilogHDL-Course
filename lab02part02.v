module lab02part02(
	input  [3:0]SW,
	output [6:0]HEX1, HEX0
);
	wire Z;
	wire [2:0]A;
	wire [3:0]M;
	B_is2Digit		isgth9(SW[3:0], Z);
	B_7SegDec		digit1({3'b000,Z}, HEX1[6:0]);
	lab02part02_circuitA	adjst(SW[2:0], A[2:0]);
	B_1xMUX2to1 	m3(Z, SW[3], 1'b0, M[3]);
	B_1xMUX2to1 	m2(Z, SW[2], A[2], M[2]);
	B_1xMUX2to1 	m1(Z, SW[1], A[1], M[1]);
	B_1xMUX2to1 	m0(Z, SW[0], A[0], M[0]);
	B_7SegDec		digit0(M[3:0], 	 HEX0[6:0]);
 
endmodule

//VERIFICATION
module testBenchl2p2;
	reg  [3:0]sw;
	wire [6:0]h1, h0;
	lab02part02 testp2(sw, h1, h0);
	initial begin
		sw = 4'b0000;   #100;
		sw = 4'b0001;   #100;
		sw = 4'b0010;   #100;
		sw = 4'b0011;   #100;
		sw = 4'b0100;   #100;
		sw = 4'b0101;   #100;
		sw = 4'b0110;   #100;
		sw = 4'b0111;   #100;
		sw = 4'b1000;   #100;
		sw = 4'b1001;   #100;
		sw = 4'b1010;   #100;
		sw = 4'b1011;   #100;
		sw = 4'b1100;   #100;
		sw = 4'b1101;   #100;
		sw = 4'b1110;   #100;
		sw = 4'b1111;   #100;	
	end
endmodule
