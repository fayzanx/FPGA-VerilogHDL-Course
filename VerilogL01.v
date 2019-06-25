module VerilogL01 (input x, y, output reg sum, carry);

	/*wire a, b, c;
	//assign sum = ((~x & y) | (x & ~y));
	//assign carry = x & y;
	xor(sum, x, y, cin);
	and(a, x, y);
	and(b, y, z);
	and(c, x, z);
	or(carry, a, b, c);*/
	always@(*)
	begin
		sum = x + y;
	end
	

endmodule