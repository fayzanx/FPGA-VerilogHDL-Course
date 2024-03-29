//artithmetic

// A helper function for a BCD Display
// [../B_is2Digit]
module B_is2Digit(
	input [3:0]num,
	output z
);
/*
	Checks if the given 4-bit number is greater than 9.
*/
	assign z = (num[3] & (num[2] | num[1] | num[0]));
endmodule

// 1-BIT Full Adder Binary
// [moved form B_1xFullAdder.v]
module B_1xFullAdder(
	input  A, B, C,
	output cot, sum
);

	assign cot = ((A & B) | (B & C) | (C & A));
	assign sum = ((~A & ~B & C) | (~A & B & ~C) | (A & ~B & ~C) | (A & B & C));

endmodule


// 1-DIGIT Full Adder BCD
// [moved form B_1dBCDAdder.v]
module B_1dBCDAdder(
	input CIN,
	input [3:0] numA, numB,
	output COUT,
	output [3:0] sumBCD
);
	wire [4:0]sumBin;
	wire [9:0]bcdMid;
	B_4xFullAdderRipple add0(CIN, numA[3:0], numB[3:0], sumBin[4], sumBin[3:0]);
	B_8xBin2BCD convertSum({3'b000, sumBin[4:0]}, bcdMid[9:0]);
	assign sumBCD[3:0] = bcdMid[3:0];
	assign COUT = bcdMid[4];
	
endmodule


// 2-DIGIT BCD Adder
// [moved from B_2dBCDAdder.v
module B_2dBCDAdder(
		input CIN,
		input [7:0]numA,
		input [7:0]numB,
		output COUT,
		output [7:0]sumBCD
);
	wire carry0;
	B_1dBCDAdder add0( CIN, numA[3:0], numB[3:0], carry0, sumBCD[3:0]);
	B_1dBCDAdder add1(carry0, numA[7:4], numB[7:4], COUT, sumBCD[7:4]);
endmodule


//4-BIT Comparator
//[../moved here from B_4xComp.v]
module B_4xComp(
	input  Ll, El, Gl,
	input  [3:0]numA, numB,
	output L, E, G
);

	wire x0, x1, x2, x3;	//XNOR
	wire Lh, Eh, Gh;
	assign x0 = ((numA[0] & numB[0]) | (~numA[0] & ~numB[0]));
	assign x1 = ((numA[1] & numB[1]) | (~numA[1] & ~numB[1]));
	assign x2 = ((numA[2] & numB[2]) | (~numA[2] & ~numB[2]));
	assign x3 = ((numA[3] & numB[3]) | (~numA[3] & ~numB[3]));
	
	assign Eh = (x0 & x1 & x2 & x3);
	assign Gh = ((numA[3] & ~numB[3]) | (x3 & numA[2] & ~numB[2]) |
					(x3 & x2 & numA[1] & ~numB[1]) | (x3 & x2 & x1 & numA[1] & ~numB[1]));
	assign Lh = ((~numA[3] & numB[3]) | (x3 & ~numA[2] & numB[2]) |
					(x3 & x2 & ~numA[1] & numB[1]) | (x3 & x2 & x1 & ~numA[1] & numB[1]));
	assign E  = (Eh & El);
	assign L  = ((Eh & Ll) | Lh);
	assign G  = ((Eh & Gl) | Gh);

endmodule



//8-BIT COMPARATOR
//[../moved here from B_8xComp.v]
module B_8xComp(
	input  [7:0]numA, numB,
	output LT, EQ, GT
);
	wire [2:0]resCompL;
	B_4xComp	compL(1'b0, 1'b1, 1'b0, numA[3:0], numB[3:0], resCompL[2], resCompL[1], resCompL[0]);
	B_4xComp	compH(resCompL[2], resCompL[1], resCompL[0], numA[7:4], numB[7:4], LT, EQ, GT);

endmodule

//4-BIT Ripple Full Adder
//[../B_4xFullAdderRipple.v]
module B_4xFullAdderRipple(
	input  CIN,
	input  [3:0]A, B,
	output COUT,
	output [3:0]S
);
    // wrapper function, retained for backward compatibility
    wire noUse; //not used
    addnSubX addEm(noUse, COUT, S, CIN, A, B, 1'b0);
	/*wire [2:0]carryAhead;
	B_1xFullAdder sum1(A[0], B[0], CIN, carryAhead[0], S[0]);
	B_1xFullAdder sum2(A[1], B[1], carryAhead[0], carryAhead[1], S[1]);
	B_1xFullAdder sum3(A[2], B[2], carryAhead[1], carryAhead[2], S[2]);
	B_1xFullAdder sum4(A[3], B[3], carryAhead[2], COUT, S[3]);*/
endmodule

// A generic N-Bit Adder
module addnSubX #(parameter adderWidth = 4)(
    output overflowFlag,
    output carryOut,
    output [adderWidth-1:0]SUM,
    input  carryIn,
    input  [adderWidth-1:0]numA, numB,
	input opSelect
);	// parameter adderWidth = 4;
    
    // carry ahead logic
	//.. ISSUE: carryIn should be removed from portIN.
    wire [adderWidth:0]carryAhead;
    assign carryAhead[0] = carryIn | opSelect; //for subtraction
    assign carryOut = carryAhead[adderWidth];

	// adding subtraction feature, Inverting B
	wire [adderWidth-1:0]numBx;
    genvar j;
    generate 
		for (j=0; j<adderWidth; j=j+1) begin: n
			assign numBx[j] = opSelect ^ numB[j];
		end
	endgenerate

    // main block
    genvar i;
    generate
        for(i=0; i<adderWidth; i=i+1) begin: m
            B_1xFullAdder sumEmAll(numA[i], numBx[i], carryAhead[i], carryAhead[i+1], SUM[i]);
        end//for
    endgenerate

    // overflow detection
    assign overflowFlag = carryAhead[adderWidth] ^ carryAhead[adderWidth-1];
endmodule


// Multiplier
module multiplierNx #(parameter MULSize = 2)(
	output [((2*MULSize))-1:0]mulAns,
	input  [(MULSize-1):0]numA, numB
);
	wire [(MULSize-1):0]noUse;
	// Intermediates
	wire [((2*MULSize)-1):0]sumIntermediate[(MULSize):0];
	reg  [((2*MULSize)-1):0]mulIntermediate[(MULSize):0];
	wire [(MULSize+1):0]carryAhead;

	// Generating the multiplied array of both numbers
	integer i,j;
	always@(*) begin
		// Initiating to zero, to avoid X.
		for(i=0; i<(MULSize); i=i+1) begin
			for (j=0; j<(2*MULSize); j=j+1) begin
					mulIntermediate[i][j] = 0;
			end
		end
		// Generating Multiplicands
		for(i=0; i<MULSize; i=i+1) begin
			for(j=0; j<MULSize; j=j+1) begin
					mulIntermediate[i][i+j] = (numA[j] & numB[i]);
			end
		end
	end //always block

	// preseting for algo
	assign carryAhead[0] = 0;
	assign sumIntermediate[0] = mulIntermediate[0];
	assign mulAns = sumIntermediate[MULSize-1];

	// Summing up the array to generate final answer
	genvar k;
	generate for(k=0; k<MULSize; k=k+1) begin: o
		addnSubX #(2*MULSize) adder1(.overflowFlag(noUse[k]), .carryOut(carryAhead[k+1]),
			.SUM(sumIntermediate[k+1]),	.carryIn(carryAhead[k]), .numA(sumIntermediate[k]),
			.numB(mulIntermediate[k+1]), .opSelect(1'b0));
	end	endgenerate
endmodule
