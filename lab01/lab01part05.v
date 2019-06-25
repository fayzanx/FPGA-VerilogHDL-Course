module lab01part05(
	//input [17:0]SW,
	input [2:0]SW,
	output [6:0]HEX0, HEX1, HEX2, HEX3, HEX4
);

	wire [2:0]M;
	reg  [2:0]N,O,P/*,Q*/,R;
	reg  [2:0]v,w,x,y;//,z;
	//base_3xMUX5to1	characterSelect(SW[17:15], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], M[2:0]);
	base_3xMUX5to1	characterSelect(SW[2:0], 3'b000, 3'b001, 3'b010, 3'b011, 3'b100, M[2:0]);
	
	always@(*)
	begin
		case(M)
			/*3'b000:	begin v=0; w=0; x=0; y=0; z=0; end
 			3'b001:	begin v=0; w=0; x=0; y=0; z=5; end
			3'b010:	begin v=0; w=0; x=0; y=5; z=5; end
			3'b011:	begin v=0; w=0; x=5; y=5; z=5; end
			3'b100:	begin v=0; w=5; x=5; y=5; z=0; end
			3'b101:	begin v=5; w=5; x=5; y=0; z=0; end
			3'b110:	begin v=5; w=5; x=0; y=0; z=0; end
			3'b111:	begin v=5; w=0; x=0; y=0; z=0; end*/
			3'b000:	begin v=0; w=0; x=0; y=0; end
 			3'b001:	begin v=0; w=0; x=0; y=4; end
			3'b010:	begin v=0; w=0; x=4; y=4; end
			3'b011:	begin v=0; w=4; x=4; y=4; end
			3'b100:	begin v=4; w=4; x=4; y=4; end
			3'b101:	begin v=4; w=4; x=4; y=0; end
			3'b110:	begin v=4; w=4; x=0; y=0; end
			3'b111:	begin v=4; w=0; x=0; y=0; end
		endcase
		
		R = M+3'b000-v;
		N = M+3'b001-w;
		O = M+3'b010-x;
		P = M+3'b011-y;
		//O = M+3'b100-z;		
	
	end
	
		base_7SegmentDec0	displayHex0(R[2:0], HEX3[6:0]);
		base_7SegmentDec0 displayHex1(N[2:0], HEX2[6:0]);
		base_7SegmentDec0 displayHex2(O[2:0], HEX1[6:0]);
		base_7SegmentDec0 displayHex3(P[2:0], HEX0[6:0]);
		//base_7SegmentDec0 displayHex4(Q[2:0], HEX4[6:0]);
	
	/*reg [2:0]N, O, P, Q, adj;
	always@(*)
	begin
		if(M > 0)
			adj = M;
		else
			adj = 0;
			
		N = M + 1 - adj;
		O = N + 1 - adj;
		P = O + 1 - adj;
		Q = P + 1 - adj;
	end
	base_7SegmentDec0(N[2:0], HEX1[6:0]);
	base_7SegmentDec0(O[2:0], HEX2[6:0]);
	base_7SegmentDec0(P[2:0], HEX3[6:0]);
	base_7SegmentDec0(Q[2:0], HEX4[6:0]);*/

endmodule


//TestBench
module testBenchL01T05;

	//reg [17:0]sw;
	reg [2:0]sw;
	wire [6:0]h0, h1, h2, h3, h4;
	lab01part05 lab1Verify5(sw, h0, h1, h2, h3, h4);
	
	initial begin
		/*#100; sw=18'b000000001010011100;
		#100; sw=18'b001000001010011100;
		#100; sw=18'b010000001010011100;
		#100; sw=18'b011000001010011100;
		#100; sw=18'b100000001010011100;
		#100; sw=18'b101000001010011100;
		#100; sw=18'b110000001010011100;
		#100; sw=18'b111000001010011100;*/
		#100; sw=3'b000;
		#100; sw=3'b001;
		#100; sw=3'b010;
		#100; sw=3'b011;
		#100; sw=3'b100;
		#100; sw=3'b101;
		#100; sw=3'b110;
		#100; sw=3'b111;
	end

endmodule