module lab02part02_circuitA(
		input 	[2:0]num,
		output 	[2:0]out
);
/*
2	AB
1	B'
0	C
*/

	assign out[2] = (num[2] & num[1]);
	assign out[1] = (~num[1]);
	assign out[0] = (num[0]);

endmodule