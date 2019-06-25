module lab03part04(
	output Q1, Q2, Q3,
	input D, Clk
);
	mem_DLatch dl1(Q1, D, Clk);
	mem_Dflippos dff1(Q2, D, Clk);
	mem_Dflipneg dff2(Q3, D, Clk);
endmodule


