/*
    .. striping down input length to 4-bit due to board constraints.

    BEHAVIOUR/USAGE: Set SW[8] to 0|1 for inputting AB|CD respectively, then
    enter their binary value through switches SW[7:0]={A, B}. After that, 
    press the KEY[3], which functions as a clock and saves input. Turn on WE
    to perform the operation in 4 cycles.

    RESET NEGATIVE: KEY[2];
    CLOCK: KEY[3];
    VARIABLE SELECT: SW[8]
    WRITE ENABLE: SW[9]
    DATA WIDTH: 8-BIT
*/

module lab06part08(
    output [6:0]HEX3, HEX2, HEX1, HEX0,
    output [8:0]resultOp, // PRODUCT(4x2) + COUT(1) = 9
    input  [9:0]SW, //SW[7:0] = {A,B} | {C,D}
    input  [3:2]KEY // = {CLK, RESET}
);
    // I'll control the clocks to save data according to switch SW[9:8] value.
    wire /*[3:0]*/[1:0]clkEn; //clock enables for variables.
    assign clkEn[0] = ((~KEY[3]) /*& ~SW[9]*/ & ~SW[8]); //0 AB
    assign clkEn[1] = ((~KEY[3]) /*& ~SW[9]*/ &  SW[8]); //1 CD
    //assign clkEn[2] = ((~KEY[3]) /*&  SW[9]*/ &  SW[8]); //1
    //assign clkEn[3] = ((~KEY[3]) /*&  SW[9]*/ &  SW[8]); //1

    genvar i;
    wire [7:0]inData/*[3:0]; //4x8-bit*/[1:0]; //2x8-bit data to store
    generate
        for(i=0; i<2; i=i+1) begin: m
            registerNx #(8) savein(.Q(inData[i]), .D(SW[7:0]), .regCLK(clkEn[i]), .regRESN(KEY[2]));
        end 
    endgenerate

    syncMulAdd2 #(4) muladdA(.resultS(resultOp), .numA(inData[0][7:4]), .numB(inData[0][3:0]),
        .numC(inData[1][7:4]), .numD(inData[1][3:0]), .clkP(~KEY[3] & SW[9]), .resN(KEY[2]));

    //Hex Display
    wire [15:0]dispData;
    //displays ABCD on WE=0 and Result on WE=1
    mux2x1 #(16) dispSelect(.M(dispData), .X({inData[0], inData[1]}), .Y({6'd0, resultOp}), .Sel(SW[9]));
    hexDisplay4digit disply(HEX3, HEX2, HEX1, HEX0, dispData);

endmodule

module tbtestl6p8;
    reg  clk, reset, writeEn, dataSel;
    reg  [3:0]dataA, dataB;
    wire [8:0]res;
    wire [6:0]h3, h2, h1, h0;
    lab06part08 testl6p8(h3, h2, h1, h0, res, {writeEn, dataSel, dataA, dataB}, {clk, reset});

    // initial settings
    initial begin
        writeEn = 1'b1;
        reset = 1'b0; #100; reset = 1'b1;
        writeEn = 1'b0;
    end
    initial begin
        clk = 1'b0;
        forever #25 clk = ~clk;
    end


    // testing the truth table
    integer i, j, k, l;
    initial begin
    #150;
        for(i=0; i<16; i=i+1) begin
            for(j=0; j<16; j=j+1) begin
                for(k=0; k<16; k=k+1) begin
                    for(l=0; l<16; l=l+1) begin
                        writeEn = 1'b0;
                        dataSel = 1'b0;
                        dataA = i;
                        dataB = j;
                        #50;
                        dataSel = 1'b1;
                        dataA = k;
                        dataB = l;
                        writeEn = 1'b1;
                        #50;
					end
				end
            end
        end
    end
endmodule

