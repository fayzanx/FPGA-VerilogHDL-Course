module lab06part01(
	output [15:0]OUT,
	input  [15:0]IN,
	input CLOCK_50,
	input RESN	
);
	registerNx #(16) abc(OUT, IN, CLOCK_50, RESN);
endmodule
