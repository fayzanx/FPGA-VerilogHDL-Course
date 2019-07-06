
module lab06part07(
    output [6:0]HEX3, HEX2, HEX1, HEX0,
    output [4:0]resultOp,
    input  [9:0]SW, //SW[7:0] = {A,B,C,D}
    input  [3:2]KEY // = {CLK, RESET}
);

    //wire [4:0]resultOp;
    // .. changing A,B,C,D to 2-bit to meet DE1 board constraints
    syncMulAdd2 #(2) name(.resultS(resultOp), .numA(SW[7:6]), .numB(SW[5:4]),
         .numC(SW[3:2]), .numD(SW[1:0]), .clkP(KEY[3]), .resN(KEY[2]));
    hexDecoder7Seg h1(HEX1, {3'b0, resultOp[4]});
    hexDecoder7Seg h0(HEX0, resultOp[3:0]);
endmodule

module tbtest;
    reg clk, reset;
    reg [1:0]a,b,c,d;
   // reg  [7:0]sw;
    //reg  [1:0]ky;
    wire [4:0]res;
    wire [6:0]h3, h2, h1, h0;
    lab06part07 testl6p7(h3, h2, h1, h0, res, {a,b,c,d}, {clk, reset});

    initial begin
        reset = 1'b0; #100; reset = 1'b1;
        clk = 1'b0;
        forever #25 clk = ~clk;
    end
    
    integer i, j, k, l;
    initial begin
    #150;
        for(i=0; i<4; i=i+1) begin
            for(j=0; j<4; j=j+1) begin
                for(k=0; k<4; k=k+1) begin
                    for(l=0; l<4; l=l+1) begin
                        a=i; b=j; c=k; d=l; #150; 
					end
				end
            end
        end
    end
endmodule

