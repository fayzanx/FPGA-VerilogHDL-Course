module lab03part03(
	input  [1:0]SW,
	output [0:0]LEDR/*,
	output [2:0]LEDG*/
);
	/*	assign LEDG[0] = LEDR[0];
		assign LEDG[1] = SW[0];
		assign LEDG[2] = SW[1];	*/
	B_flipflopDmse ff1(SW[1], SW[0], LEDR[0]);
endmodule



