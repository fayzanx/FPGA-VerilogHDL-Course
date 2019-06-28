module lab04part03(
	output [15:0]LEDR,
	output [6:0]HEX3, HEX2, HEX1, HEX0,
	input  [1:0]SW,
	input  KEY1
);
	//CNT_EN = SW[0], S_CLR = SW[1] 
	count1 lpmcount(KEY1, SW[0], SW[1], LEDR[15:0]);
	hexDecoder7Seg h3(HEX3[6:0], LEDR[15:12]);
	hexDecoder7Seg h2(HEX2[6:0], LEDR[11:8]);
	hexDecoder7Seg h1(HEX1[6:0], LEDR[7:4]);
	hexDecoder7Seg h0(HEX0[6:0], LEDR[3:0]);
endmodule

module tbl4p3;
	reg  [2:0]sw;
	wire [15:0]lr;
	wire [6:0]h3, h2, h1, h0;
	integer i;
	lab04part03 testl4p3(lr, h3, h2, h1, h0, {sw[2], sw[0]}, sw[1]);
	initial begin
		sw[1]=1'b0;
		sw[0]=1'b1;
		for(i=0; i<100; i=i+1) begin
		#100;
			if(i==0)		//clearing the value
				sw[2] = 1;
			if(i==2)
				sw[2] = 0;
			sw[1] = ~sw[1]; //ticking the clock
		end //for

	end
endmodule