//7 Segment Deconder [0-9 Only] [.../moved from B_7SegDec.v]
module B_7SegDec(
	input  [3:0] X,
	output [6:0] Y
);

/*
6	A'B'C' + BCD
5	B'C + CD + A'B'D
4	D + BC'
3	BC'D' + BCD + A'B'C'D
2	B'CD'
1	BC'D + BCD'
0	BC'D' + A'B'C'D
---------------------------------------------
6	(~X[3])(~X[2])(~X[1]) + (X[2])(X[1])(X[0])
5	(~X[2])(X[1]) 		   + (X[1])(X[0]) + (~X[3])(~X[2])(X[0])
4	(X[0]) + (X[2])(~X[1])
3	(X[2])(~X[1])(~X[0]) + (X[2])(X[1])(X[0]) + (~X[3])(~X[2])(~X[1])(X[0])
2	(~X[2])(X[1])(~X[0])
1	(X[2])(~X[1])(X[0]) + (X[2])(X[1])(~X[0])
0	(X[2])(~X[1])(~X[0]) + (~X[3])(~X[2])(~X[1])(X[0])
*/

	assign Y[6] = ((~X[3] & ~X[2] & ~X[1])|(X[2] & X[1] & X[0]));
	assign Y[5] = ((~X[2] & X[1]) |(X[1] & X[0])|(~X[3] & ~X[2] & X[0]));
	assign Y[4] = ((X[0])|(X[2] & ~X[1]));
	assign Y[3] = ((X[2] &~X[1] & ~X[0])|(X[2] & X[1] & X[0])|(~X[3] & ~X[2] & ~X[1] & X[0]));
	assign Y[2] = (~X[2] & X[1] & ~X[0]);
	assign Y[1] = ((X[2] & ~X[1] & X[0])|(X[2] & X[1] & ~X[0]));
	assign Y[0] = ((X[2] & ~X[1] & ~X[0])|(~X[3] & ~X[2] & ~X[1] & X[0]));

endmodule

//TestBench

/*module testBench7Seg;

	reg [3:0]x;
	wire [6:0]y;
	B_7SegDec verify7Seg(x, y);
	
	initial begin
	#100; x=4'b0000;
	#100; x=4'b0001;
	#100; x=4'b0010;
	#100; x=4'b0011;
	#100; x=4'b0100;
	#100; x=4'b0101;
	#100; x=4'b0110;
	#100; x=4'b0111;
	#100; x=4'b1000;
	#100; x=4'b1001;
	end

endmodule*/

// 7 Segment Decoder [0-F]
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


// A helper function to display 16 bit value on HEX Displays
module hexDisplay4digit(
	output [6:0]d3, d2, d1, d0,
	inout  [15:0]displayVal
);
    hexDecoder7Seg h3(d3, displayVal[15:12]);
	hexDecoder7Seg h2(d2, displayVal[11:8]);
	hexDecoder7Seg h1(d1, displayVal[7:4]);
	hexDecoder7Seg h0(d0, displayVal[3:0]);
endmodule