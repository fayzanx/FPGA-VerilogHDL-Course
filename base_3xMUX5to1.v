module base_3xMUX5to1(
	input [2:0] S,
	input [2:0] U, V, W, X, Y,
	output reg [2:0] M
);

	always@(*)
	begin
		case(S)
			3'b000:	begin M = U; end
 			3'b001:	begin M = V; end
			3'b010:	begin M = W; end
			3'b011:	begin M = X; end
			3'b100:	begin M = Y; end
			3'b101:	begin M = Y; end
			3'b110:	begin M = Y; end
			3'b111:	begin M = Y; end
		endcase
	end
	
endmodule