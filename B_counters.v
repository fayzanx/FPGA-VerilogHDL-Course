/*	4-BIT COUNTER USING T-FLIP FLOPS	*/
module counter4x(
	output [3:0]countVal, ANDr,
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
	lab04part01_TFlipAnd a1(andOut[0], countVal[0], ANDl,      CLK, RESN);
	lab04part01_TFlipAnd a2(andOut[1], countVal[1], andOut[0], CLK, RESN);
	lab04part01_TFlipAnd a3(andOut[2], countVal[2], andOut[1], CLK, RESN);
	lab04part01_TFlipAnd a4(andOut[3], countVal[3], andOut[2], CLK, RESN);
	assign ANDr = andOut[3];
endmodule



/*	16-BIT COUNTER USING T-FLIP FLOPS	*/
module counter16x(
	output [15:0]countVal, ANDr,
	input  ANDl, CLK, RESN
);
	wire [3:0]carryOn;
	counter4x countA(countVal[ 3: 0], carryOn[3], ANDl, 	  CLK, RESN);
	counter4x countB(countVal[ 7: 4], carryOn[2], carryOn[3], CLK, RESN);
	counter4x countC(countVal[11: 8], carryOn[1], carryOn[2], CLK, RESN);
	counter4x countD(countVal[15:12], carryOn[0], carryOn[1], CLK, RESN);
	assign ANDr = carryOn[0];
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
