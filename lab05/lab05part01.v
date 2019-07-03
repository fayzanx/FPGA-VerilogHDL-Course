module lab05part01(
    output [6:0]HEX3, HEX2, HEX1, HEX0,
	output [15:0]LEDR,
    input  CLOCK_50 //50MHz Clock
    //input  [1:0]SW //CLR, CLK, EN
	//,output [3:0]nextSignal
);

	wire ifInc, noUseCarry;
	//wire [25:0]countVal;
	wire [3:0]debugSignal;

	//50MHz Clock producing 1second delay
	clock_1s getDelay(/*countVal[25:0],*/ ifInc, CLOCK_50);

	wire [15:0]outputVal;
	counterBCD4d bcdABCD(outputVal, noUseCarry, /*ENSW[0]*/1'b1,/*CLK*/ifInc,/*RESNSW[1]*/1'b1, debugSignal[3:0]);
	hexDisplay4digit disp(HEX3, HEX2, HEX1, HEX0, outputVal);
	assign LEDR[15:0] = outputVal[15:0];
endmodule

//VERIFICATION
/*module tbl5p1;
    reg [2:0]sw;
    wire [15:0]bcd;
    wire [6:0]h3, h2, h1, h0;
	wire [3:0]nextSignal;//, rf;
    lab05part01 testl5p1(h3, h2, h1, h0, bcd, sw, nextSignal);
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
endmodule*/



