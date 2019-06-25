module lab01part03(
	input [17:0]SW,
	output [17:0]LEDR,
	output [2:0]LEDG
);
	
	base_3xMUX5to1 muxer(SW[17:15], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], LEDG[2:0]);
	lab01part01 switchestoLEDs(SW, LEDR);

endmodule