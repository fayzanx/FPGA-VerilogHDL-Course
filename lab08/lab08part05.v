module lab08part05(
    output [7:0]dataOUT,
    input  CLK,
    input  [7:0]dataIN,
    input  [4:0]addrREAD, addrWRITE,
    input  wrEN
);
    lpmRAM2port	my2pRAM(CLK, dataIN, addrREAD, addrWRITE, wrEN, dataOUT);
endmodule

module tbtesl8p5;
	reg  [4:0]addrR, addrW;
	reg  wren, clk;
	reg  [7:0]dataIN;
	wire [7:0]dataOUT;
	lab08part05 testl8p5(dataOUT, clk, dataIN, addrR, addrW, wren);

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
			if (i != 0) begin
				addrR = i-1;
			end else begin
				addrR = i;
			end
			addrW = i;
			dataIN = i;
			#100;
		end
		dataIN = 0;
		for (i=0; i<32; i=i+1) begin
			wren = 1'b0;
			addrR = i;
			#100;
		end
	end

endmodule
