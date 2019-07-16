module lab07part03(
    output [0:0]LEDR, //output
    // output [3:0]memDataA, memDataB
    input  [0:0]SW,  //userInput
    input  [3:2]KEY //CLK+RESET
);
    FSM_4xSequenceDetectorC testFSM(LEDR[0], /*memDataA, memDataB,*/ SW[0], ~KEY[3], KEY[2]);
endmodule

module tbtest;
    reg in, clk, rst;
    wire out;
    // wire [3:0]memA, memB;
    lab07part03 verifyl7p2(out, /*memA, memB,*/ in, {clk, rst});

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
