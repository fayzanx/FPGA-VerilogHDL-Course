module base_halfAdder(input x, y, output reg sum, carry);
	
	always@(*)
	begin
		sum = x + y;
	end
	
endmodule