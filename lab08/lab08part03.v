module lab08part03(
	output [7:0]q,
	input  [7:0]data,
	input  [4:0]addr,
	input  clk, wren
);
    genericRAM #(8, 5) ram_inst(.Q(q), .dataIN(data), .addr(addr), .pCLK(clk), .enWR(wren));
endmodule


module tbtest;
	reg  [4:0]addr;
	reg  wren, clk;
	reg  [7:0]data;
	wire [7:0]q;
	lab08part03 testl8p1(q, data, addr, clk, wren);

	initial begin
		clk = 1'b0;
	end
	initial begin
		forever #50 clk=~clk;
	end

	integer i;
	initial begin
		for (i=0; i<32; i=i+1) begin
			wren = 1'b1;
			addr = i;
			data = i;
			#100;
		end
		data = 0;
		for (i=0; i<32; i=i+1) begin
			wren = 1'b0;
			addr = i;
			#100;
		end
	end

endmodule