module lab06part02(
    output [3:0]sum,
    output [6:0]HEX3, HEX2, HEX1, HEX0,
    output [0:0]LEDG,
    input  [8:0]SW,
    //input  [3:3]KEY
    input  CLOCK_50,
    input  opsel
);
    wire xcarry;    
    wire [2:0]y;
    assign y = 3'b000;

    syncAddnSub #(4) addSubTest(LEDG[0], xcarry, sum, SW[7:4], SW[3:0], SW[8], CLOCK_50, opsel);
    hexDisplay4digit dispTest(HEX3, HEX2, HEX1, HEX0, {SW, y, xcarry, sum});
endmodule


// TESTBENCH
module tbl6p2;
    reg  clk, k, ops;
    reg  [7:0]sw;
    wire [6:0]h3, h2, h1, h0;
    wire lg;
    wire [3:0]sum;
    lab06part02 testl6p2(sum, h3, h2, h1, h0, lg, {clk, sw}, k, ops);
    initial begin
        sw = 9'h00;
        clk = 1'b0;
        ops = 1'b0;
        forever #50 clk = ~clk;
    end

    initial begin
        #200;
        repeat(2) #700 ops = ~ops;
    end

    initial begin
        k = 1'b1; #100; k = 1'b0; #100; k = 1'b1;
    end

    initial begin 
        #200;
        sw[7:0] = 8'h11; #100;
        sw[7:0] = 8'h15; #100;
        sw[7:0] = 8'h52; #100;
        sw[7:0] = 8'hfd; #100;
        sw[7:0] = 8'hf1; #100;
        sw[7:0] = 8'h81; #100;
        sw[7:0] = 8'h99; #100;

        sw[7:0] = 8'h11; #100;
        sw[7:0] = 8'h15; #100;
        sw[7:0] = 8'h52; #100;
        sw[7:0] = 8'hfd; #100;
        sw[7:0] = 8'hf1; #100;
        sw[7:0] = 8'h81; #100;
        sw[7:0] = 8'h99; #100;
    end
endmodule
