/*	4-BIT COUNTER USING T-FLIP FLOPS	*/
module counter4x(
	output [3:0]countVal4x,
    output ANDr,
	input  ANDl, CLK, RESN
);
	/*genvar i;
	generate
		//for(i=1; i<17; i=i+1) begin: m
		for(i=1; i<5; i=i+1) begin: m
			lab04part01_TFlipAnd (cBout[i], cBout[i-1], SW[1], SW[2]);
		end //for
	endgenerate*/
	
	wire [3:0]andOut;
	lab04part01_TFlipAnd a1(andOut[0], countVal4x[0], ANDl,      CLK, RESN);
	lab04part01_TFlipAnd a2(andOut[1], countVal4x[1], andOut[0], CLK, RESN);
	lab04part01_TFlipAnd a3(andOut[2], countVal4x[2], andOut[1], CLK, RESN);
	lab04part01_TFlipAnd a4(andOut[3], countVal4x[3], andOut[2], CLK, RESN);
	assign ANDr = andOut[3];
endmodule

/*	16-BIT COUNTER USING T-FLIP FLOPS	*/
module counter16x(
	output [15:0]countVal,
	output ANDr,
	input  ANDl, CLK, RESN
);
	wire [3:0]carryOn;
	counter4x countA(countVal[ 3: 0], carryOn[3], ANDl, 	  CLK, RESN);
	counter4x countB(countVal[ 7: 4], carryOn[2], carryOn[3], CLK, RESN);
	counter4x countC(countVal[11: 8], carryOn[1], carryOn[2], CLK, RESN);
	counter4x countD(countVal[15:12], carryOn[0], carryOn[1], CLK, RESN);
	assign ANDr = carryOn[0];
endmodule

/*	32-BIT COUNTER USING T-FLIP FLOPS	*/
module counter32x(
	output [31:0]countVal,
	output ANDr,
	input  ANDl, CLK, RESN
);
	wire carryOn;
	counter16x count0(countVal[15: 0], carryOn, ANDl, CLK, RESN);
	counter16x count1(countVal[31:16], ANDr, carryOn, CLK, RESN);
endmodule

/*	16-BIT COUNTER USING +1	*/
module counter16x_add(
	output reg [15:0]countVal,
	input  EN, CLK, RESN
);
	always@(posedge CLK) begin
		if(EN)
			countVal <= countVal + 1;
		if(~RESN)
			countVal <= 16'h0000;
		else if(~EN & RESN)
			countVal <= countVal;
	end //always
endmodule


/*
	PROBLEM STATEMENT
	--------------------------------
	Create a BCD counter 1-digit.

	SOLUTION:
		Using a 4-bit counter, with reset at 10.

	ISSUE: Increments the value of 9 at 90, instead of 99.
*/

/*	SINGLE DIGIT BCD COUNTER USING T-FLOPS	*/
// module counterBCD1x(
// 	output [3:0]countVal1xBCD,
//     output incNext1d,
// 	input  incPrev1d, CLK1d, RESN1d
// );
// 	reg resetF;
// 	wire [3:0]andOut;
// 	//resetF is 0 for RESN=0 OR count=1010;
// 	always@(negedge CLK1d) begin
// 	/* I have used negative edge for storing reset of the reset flip flop,
// 	 so that counter is able to  reset on next positive edge of counter clock.*/
// 		if(~RESN1d) begin
// 			resetF <= 1'b0;
// 		end //if
// 		else if(countVal1xBCD > 4'd8 && incPrev1d) begin
// 			resetF <= ~resetF;
// 		end //elseif
// 		else begin
// 			resetF <= 1'b1;
// 		end //else
// 		//resetF <= ~(~RESN1d | (countVal1xBCD[3]&~countVal1xBCD[2]&countVal1xBCD[1]&~countVal1xBCD[0]));
// 	end //always
// 	lab04part01_TFlipAnd a1(andOut[0], countVal1xBCD[0], incPrev1d,   CLK1d, resetF);
// 	lab04part01_TFlipAnd a2(andOut[1], countVal1xBCD[1], andOut[0], CLK1d, resetF);
// 	lab04part01_TFlipAnd a3(andOut[2], countVal1xBCD[2], andOut[1], CLK1d, resetF);
// 	lab04part01_TFlipAnd a4(andOut[3], countVal1xBCD[3], andOut[2], CLK1d, resetF);
// 	assign incNext1d = ~resetF;
// endmodule


/*	2-DIGIT BCD COUNTER USING 1-DIGIT BCD MODULE (T-FLOPS)	*/
// module counterBCD2x(
// 	output [7:0]countVal2xBCD,
// 	output incNext2d,
// 	input  incPrev2d, CLK2d, RESN2d
// );
// 	wire incMiddle;
// 	counterBCD1x count0(countVal2xBCD[3:0], incMiddle, incPrev2d, CLK2d, RESN2d);
// 	counterBCD1x count1(countVal2xBCD[7:4], incNext2d, incMiddle, CLK2d, RESN2d);
// endmodule


/*	4-DIGIT BCD COUNTER USING 2-DIGIT BCD MODULE(S) [T-FLOPS]	*/
// module counterBCD4x(
// 	output [15:0]countVal4xBCD,
// 	output incNext4d,
// 	input  incPrev4d, CLK4d, RESN4d
// );
// 	wire incMiddle;
// 	counterBCD2x count01(countVal4xBCD[7:0], incMiddle, incPrev4d, CLK4d, RESN4d);
// 	counterBCD2x count23(countVal4xBCD[15:8], incNext4d, incMiddle, CLK4d, RESN4d);
// endmodule

/*	SINGLE DIGIT BCD COUNTER USING BEHAVORIAL CODING	*/
module counterBCD1d(
	output reg [3:0]countVal1dBCD,
	output reg next1d, 
	input /*prev1d,*/ CLK1d, RESN1d
);
	initial countVal1dBCD = 4'h0;
	always@(posedge CLK1d or negedge RESN1d) begin
		
		if(~RESN1d) begin
			countVal1dBCD <= 4'h0;
			next1d <= 1'b0;
		end //if	
		else if(countVal1dBCD < 4'd9) begin
				countVal1dBCD <= countVal1dBCD + 4'h1;
				next1d <= 1'b0;
		end //elseif
		else if(countVal1dBCD >= 4'h9) begin //reset
			countVal1dBCD <= 4'h0;
			next1d <= 1'b1;
		end //elseif
	end //always
endmodule

/*	2-DIGIT BCD COUNTER: using behavorial modelling	*/
module counterBCD2d(
	output [7:0]countVal2dBCD,
	output next2d,
	input /*prev2d,*/ CLK2d, CLR2d
	,output [1:0]next
);
	wire connect2;
	counterBCD1d countA(countVal2dBCD[3:0], connect2/*, prev2d*/, CLK2d, CLR2d);
	counterBCD1d countB(countVal2dBCD[7:4], next2d/*, connect2*/, connect2, CLR2d);

	assign next[0] = connect2;
	assign next[1] = next2d; 
endmodule


/*	4-DIGIT BCD COUNTER: using behavorial modelling	*/
module counterBCD4d(
	output [15:0]countVal4dBCD,
	output next4d,
	input prev4d, CLK4d, CLR4d
	,output [3:0]next
);
	wire connect4;
	counterBCD2d countA(countVal4dBCD[7:0], connect4, /*prev4d,*/ CLK4d, CLR4d, next[1:0]);
	counterBCD2d countB(countVal4dBCD[15:8], next4d, /*connect4,*/ connect4, CLR4d, next[3:2]);
endmodule