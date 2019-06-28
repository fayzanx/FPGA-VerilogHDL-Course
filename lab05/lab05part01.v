module lab05part01(
    output [6:0]HEX3, HEX2, HEX1, HEX0,
	output [15:0]outputVal,
    //input  CLOCK_50, //50MHz Clock
    input  [2:0]SW //CLR, CLK, EN
);

	wire noUse;
    //counterBCD1x bcdA(outputVal, noUse, SW[0], SW[1], SW[2], rF);
	//counterBCD2x bcdAB(outputVal, noUse, SW[0], SW[1], SW[2]);
	counterBCD4x bcdABCD(outputVal, noUse, /*EN*/SW[0],/*CLK*/SW[1],/*RESN*/SW[2]);
    hexDecoder7Seg h3(HEX3, outputVal[15:12]);
	hexDecoder7Seg h2(HEX2, outputVal[11:8]);
	hexDecoder7Seg h1(HEX1, outputVal[7:4]);
	hexDecoder7Seg h0(HEX0, outputVal[3:0]);
endmodule

//VERIFICATION
module tbl5p1;
    reg [2:0]sw;
    wire [15:0]bcd;
    wire [6:0]h3, h2, h1, h0;
	wire nu;//, rf;
    lab05part01 testl5p1(h3, h2, h1, h0, bcd, sw);
    integer i;
	initial begin
		sw[1]=1'b0;
		sw[0]=1'b1;
		for(i=0; i<10000; i=i+1) begin
			if(i==0)		//clearing the value
				sw[2] = 0;
			if(i==2)
				sw[2] = 1;
			sw[1] = ~sw[1]; //ticking the clock
			#50; //50us delay
		end //for
	end
endmodule



