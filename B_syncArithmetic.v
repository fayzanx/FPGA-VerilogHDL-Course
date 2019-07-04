module syncAddnSub #(parameter sAddWidth = 8)(
    output overflowBit,
    output carryOut,
    output [sAddWidth-1:0]sumFinal,
    //input  carryIn,
    input  [sAddWidth-1:0]numA, numB,
    input  adderClock, resetNeg,
    input  opSelect
);
    //parameter sAddWidth = 8;

    //saving A and B in order to sync, and send output one cycle later
    wire [sAddWidth-1:0]savedA, savedB, savedSum;
    wire saveOverflow;
    
    wire [sAddWidth-1:0]numBx;
    
    genvar i;
    generate for (i=0; i<sAddWidth; i=i+1) begin: m
        assign numBx[i] = opSelect ^ numB[i];
    end endgenerate

    // sync input
    registerNx #(sAddWidth) saveNumA(savedA, numA, adderClock, resetNeg);
    registerNx #(sAddWidth) saveNumB(savedB, numBx, adderClock, resetNeg);

    // do ADD operation
    adderNx #(sAddWidth) addAandB(saveOverflow, carryOut, savedSum, opSelect, savedA, savedB);

    // sync output
    registerNx #(sAddWidth) savemySumAB(sumFinal, savedSum, adderClock, resetNeg);
    registerNx #(1) overFlowSync(overflowBit, saveOverflow, adderClock, resetNeg);
endmodule