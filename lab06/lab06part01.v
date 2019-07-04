module lab06part01(
    output [3:0]s,
    output [6:0]HEX3, HEX2, HEX1, HEX0,
    output [0:0]LEDG,
    input  [8:0]SW,
    input  [3:3]KEY
);
    wire [3:0]y;
    assign y = 4'b1010;
    syncAdder #(4) adderTest(LEDG[0], s, SW[7:4], SW[3:0], SW[8], KEY[3]);
    hexDisplay4digit dispTest(HEX3, HEX2, HEX1, HEX0, {SW[7:0], y[3:0], s[3:0]});
endmodule



// TESTBENCH
/*module tbl6p1;
    reg clk;
    reg [7:0]sw;
    reg k;
    wire [6:0]h3, h2, h1, h0;
    wire lg;
    wire [3:0]sum;
    lab06part01 testl6p1(sum, h3, h2, h1, h0, lg, {clk, sw}, k);
    initial begin
        sw = 8'h00;
        clk = 1'b0;
        forever #50 clk = ~clk;
    end

    initial begin
        k = 1'b1; #100; k = 1'b0; #100; k = 1'b1;
    end

    initial begin 
        sw[7:0] = 8'h11; #200;
        sw[7:0] = 8'h15; #100;
        sw[7:0] = 8'h52; #100;
        sw[7:0] = 8'hfd; #100;
        sw[7:0] = 8'hf1; #100;
        sw[7:0] = 8'h81; #100;
        sw[7:0] = 8'h99; #100;
    end
endmodule*/
