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