module lab01part01(input [17:0]SW,
						output [17:0]LEDR);
	assign LEDR = SW;		//connect each switch to light
endmodule

module testBenchT01;
	reg [17:0]sw;
	wire[17:0]ld;
	
	lab01part01 testingLab1Task1(sw, ld);
	initial begin
	#100;
	sw = 18'b000000000000000000;
	#100;
	sw = 18'b000000000000000001;
	#100;
	sw = 18'b000000000000001111;
	#100;
	end
	
endmodule