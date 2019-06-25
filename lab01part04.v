module lab01part04(
	input [2:0]SW,
	output [6:0]HEX0
);

	base_7SegmentDec0 display(SW[2:0], HEX0[6:0]);

endmodule


//MODELSIM TestBench
module testBencht01p04;

	reg [2:0]sw;
	wire[6:0]hx;
	lab01part04 instancA(sw, hx);
	
	initial begin
			#100;	sw = 3'b000;
			#100;	sw = 3'b001;
			#100;	sw = 3'b010;
			#100;	sw = 3'b011;
			#100;	sw = 3'b100;
			#100;	sw = 3'b101;
			#100;	sw = 3'b110;
			#100;	sw = 3'b111;
	end

endmodule