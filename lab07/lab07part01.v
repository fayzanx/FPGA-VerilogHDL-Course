module lab07part01(
    output [0:0]LEDR, //output
    input  [0:0]SW,  //userInput
    input  [3:2]KEY //CLK+RESET
);
    FSM_4xSequenceDetectorA testFSM(LEDR[0], SW[0], ~KEY[3], KEY[2]);
endmodule

module tbtestl7p1;
    reg in, clk, rst;
    wire out;
    lab07part01 verifyl7p1(out, in, {clk, rst});

    initial begin
        rst = 1'b1; #50;
        rst = 1'b0; #50;
        rst = 1'b1;
    end
    
    initial begin

        clk = 1'b0;
        forever #25 clk = ~clk;
    end

    integer i;
    initial begin
        for(i=0; i<100; i=i+1) begin
            repeat(5) #75 in = 1'b0;
            repeat(5) #75 in = 1'b1;
        end
    end
endmodule
