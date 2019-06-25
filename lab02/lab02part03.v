module lab02part03(
	input  [8:0]SW,
	output [8:0]LEDR,
	output [4:0]LEDG
);

	B_4xFullAdderRipple addAB(SW[8], SW[7:4], SW[3:0], LEDG[4], LEDG[3:0]);
	assign LEDR[8:0] = SW[8:0];
	
endmodule


// VERIFICATION
module testBenchl1p3;
	reg  [8:0]sw;
	wire [8:0]lr;
	wire [4:0]lg;
	lab02part03 verifyl2p3(sw, lr, lg);
	initial begin
		sw={1'b0, 4'b0000, 4'b0000}; #100;
		sw={1'b0, 4'b0000, 4'b0001}; #100;
		sw={1'b0, 4'b0001, 4'b0000}; #100;
		sw={1'b1, 4'b0010, 4'b0001}; #100;
		sw={1'b1, 4'b0100, 4'b0001}; #100;
		sw={1'b1, 4'b1000, 4'b1000}; #100;
		sw={1'b1, 4'b1111, 4'b0000}; #100;
		end
endmodule