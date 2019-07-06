/*  SYNCed ARRAY MULTIPLIER */
module lab06part06(
    output [6:0]HEX1, HEX0,
    output [7:0]LEDG,
	input  [8:0]SW, 
    input  [3:3]KEY
);
    wire [7:0]ans;
    syncMultiplierNx #(4) multhem(ans, SW[7:4], SW[3:0], SW[8], KEY[3]);
    hexDecoder7Seg disp1(HEX1, ans[7:4]);
    hexDecoder7Seg disp0(HEX0, ans[3:0]);
	assign LEDG[7:0] = ans;
    
endmodule

module tbtestl6p6;
    wire [6:0]h1,h0;
    reg  [3:0]a,b;
    wire [7:0]ans;
    reg clk, res;
    lab06part06 testl6p6(h1,h0,ans, {clk, a, b}, res);
    
    initial begin
        clk = 1'b0;
        res = 1'b0; #100; res=1'b1; #100;
        forever #50 clk=~clk;
    end

    integer i, j;
    initial begin
        

        for(i=0; i<16; i=i+1) begin
            for(j=0; j<16; j=j+1) begin
                a=i; b=j; #100; 
            end
        end
    end
endmodule