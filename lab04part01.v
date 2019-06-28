module lab04part01(
	output [15:0]countVal,
	output [6:0]HEX3, HEX2, HEX1, HEX0,
	output [2:0]LEDG,
	input [2:0]SW
);
	wire noUse;
	counter16x c16(countVal[15:0], noUse, SW[0], SW[1], SW[2]);
	
	hexDecoder7Seg d3(HEX3[6:0], countVal[15:12]);
	hexDecoder7Seg d2(HEX2[6:0], countVal[11:8]);
	hexDecoder7Seg d1(HEX1[6:0], countVal[7:4]);
	hexDecoder7Seg d0(HEX0[6:0], countVal[3:0]);
	assign LEDG[2:0] = SW[2:0];
endmodule



module tbl4p1;
	reg  [2:0]sw;
	wire [15:0]lr;
	wire [6:0]h3, h2, h1, h0;
	integer i;
	lab04part02 testl4p2(lr, h3, h2, h1, h0, sw);
	initial begin
		sw[1]=1'b0;
		sw[0]=1'b1;
		for(i=0; i<100; i=i+1) begin
		#100;
			if(i==0)		//clearing the value
				sw[2] = 0;
			if(i==2)
				sw[2] = 1;
			sw[1] = ~sw[1]; //ticking the clock
		end //for

	end
endmodule