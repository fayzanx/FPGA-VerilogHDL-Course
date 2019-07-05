/*  ARRAY MULTIPLIER */
module lab06part05(
    output [6:0]HEX1, HEX0,
    output [7:0]LEDG,
	input  [7:0]SW
);
    wire [7:0]ans;
    multiplierNx #(4) multhem(ans, SW[7:4], SW[3:0]);
    hexDecoder7Seg disp1(HEX1, ans[7:4]);
    hexDecoder7Seg disp0(HEX0, ans[3:0]);
	assign LEDG[7:0] = ans;
endmodule

module tbtestl6p5;
    reg [6:0]h1,h0;
    reg [3:0]a,b;
    wire [7:0]ans;
    lab06part05 testl6p5(h1,h0,ans, {a, b});
    integer i, j;
    initial begin
        for(i=0; i<16; i=i+1) begin
            for(j=0; j<16; j=j+1) begin
                #100; a=i; b=j;
            end
        end
    end
endmodule