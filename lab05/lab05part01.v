module lab05part01(
    output [6:0]HEX2,// HEX1, HEX0,
	output [3:0]outputVal,
    //input  CLOCK_50, //50MHz Clock
    input  [2:0]SW //CLR, CLK, EN
);
								//EN CLK RESN
    counter1xBCD_test bcdA(outputVal, SW[0], SW[1], SW[2]);
    hexDecoder7Seg h0(HEX2, outputVal);
endmodule

//VERIFICATION
module tbl5p1;
    reg [2:0]sw;
    wire [3:0]bcd;
    wire [6:0]h2;
    lab05part01 testl5p1(h2, bcd, sw);
    integer i;
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
