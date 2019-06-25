module base_7SegmentDec0(
	input [2:0]in,
	output [6:0]out
);

	
	assign out[0] = ~((~in[2] & ~in[1] & in[0]) 	|	//001
							(~in[2] & in[1] & in[0]));		//011

	assign out[1] = ~((~in[2] & ~in[1] & ~in[0]) |	//000
							(~in[2] & in[1] & in[0]));		//011

	assign out[2] = ~((~in[2] & ~in[1] & ~in[0])	|	//000
							(~in[2] & in[1] & in[0]));		//011
	
	assign out[3] = ~((~in[2] & ~in[1] & in[0]) 	|	//001
							(~in[2] & in[1] & ~in[0]) 	|	//010
							(~in[2] & in[1] & in[0]));		//011
	
	assign out[4] = ~((~in[2] & ~in[1] & ~in[0]) | 	//000
							(~in[2] & ~in[1] & in[0]) 	|	//001
							(~in[2] & in[1] & ~in[0]) 	|	//010
							(~in[2] & in[1] & in[0]));		//011
							
	assign out[5] = ~((~in[2] & ~in[1] & ~in[0]) | 	//000
							(~in[2] & ~in[1] & in[0]) 	|	//001
							(~in[2] & in[1] & ~in[0]) 	|	//010
							(~in[2] & in[1] & in[0]));		//011
							
							
	assign out[6] =~((~in[2] & ~in[1] & ~in[0]) 	|	//000
							(~in[2] & !in[1] & in[0]));	//011


endmodule