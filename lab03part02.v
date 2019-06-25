module lab03part02(
	input [1:0]SW,
	output[0:0]LEDR
);
	B_latchDe testDe(SW[1], SW[0], LEDR[0]);
endmodule