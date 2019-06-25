module lab01part02(
	input [17:0] SW,
	output [7:0] LEDG,
	output [17:0] LEDR
);
	base_8xMUX2to1 muxer(SW[17], SW[7:0], SW[15:8], LEDG[7:0]);
	lab01part01 switcher(SW, LEDR);	//assigns switches to LEDs
endmodule