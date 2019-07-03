module hexDecoder7Seg(
	output [6:0]SevenSeg,
	input  [3:0]X
);

	assign SevenSeg[6]=((~X[3]&~X[2]&~X[1])|(~X[3]&X[2]&X[1]&X[0])|(X[3]&X[2]&~X[1]&~X[0]));
	assign SevenSeg[5]=((~X[3]&~X[2]&X[0])|(~X[3]&~X[2]&X[1])|(~X[3]&X[1]&X[0])|(X[3]&X[2]&~X[1]&X[0]));
	assign SevenSeg[4]=((~X[3]&X[0])|(~X[2]&~X[1]&X[0])|(~X[3]&X[2]&~X[1]));
	assign SevenSeg[3]=((X[3]&~X[2]&X[1]&~X[0])|(~X[3]&X[2]&~X[1]&~X[0])|(X[2]&X[1]&X[0])|(~X[3]&~X[2]&~X[1]&X[0]));
	assign SevenSeg[2]=((X[3]&X[2]&~X[0])|(X[3]&X[2]&X[1])|(~X[3]&~X[2]&X[1]&~X[0]));
	assign SevenSeg[1]=((X[2]&X[1]&~X[0])|(X[3]&X[1]&X[0])|(X[3]&X[2]&~X[0])|(~X[3]&X[2]&~X[1]&X[0]));
	assign SevenSeg[0]=((~X[3]&~X[2]&~X[1]&X[0])|(~X[3]&X[2]&~X[1]&~X[0])|(X[3]&~X[2]&X[1]&X[0])|(X[3]&X[2]&~X[1]&X[0]));

endmodule

module hexDisplay4digit(
	output [6:0]d3, d2, d1, d0,
	inout  [15:0]displayVal
);
    hexDecoder7Seg h3(d3, displayVal[15:12]);
	hexDecoder7Seg h2(d2, displayVal[11:8]);
	hexDecoder7Seg h1(d1, displayVal[7:4]);
	hexDecoder7Seg h0(d0, displayVal[3:0]);
endmodule