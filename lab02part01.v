module lab02part01(
	input [7:0]SW,
	output [6:0]HEX1, HEX0
);
/*
	As we only have 10 switches available, so using only 2 dispalys (8 switches)
*/
	B_7SegDec num1(SW[7:4], HEX1[6:0]);
	B_7SegDec num2(SW[3:0], HEX0[6:0]);
	
endmodule


// VERIFICATION
module testBenchL2P1;
	
	reg [7:0]sw;
	wire [6:0]h0, h1;
	lab02part01 siml1p1(sw, h1, h0);
	
	initial begin
		#100;	sw = 8'b00000000;
		#100;	sw = 8'b00000001;
		#100;	sw = 8'b00000010;
		#100;	sw = 8'b00000011;
		#100;	sw = 8'b00000100;
		#100;	sw = 8'b00000101;
		#100;	sw = 8'b00000110;
		#100;	sw = 8'b00000111;
		#100;	sw = 8'b00001000;
		#100;	sw = 8'b00001001;
		#100;	sw = 8'b00001010;	
		#100;	sw = 8'b00010000;
		#100;	sw = 8'b00100000;
		#100;	sw = 8'b00110000;
		#100;	sw = 8'b01000000;
		#100;	sw = 8'b01010000;
		#100;	sw = 8'b01100000;
		#100;	sw = 8'b01110000;
		#100;	sw = 8'b10000000;
		#100;	sw = 8'b10010000;
		
	end
	
endmodule