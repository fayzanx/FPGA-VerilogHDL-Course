module syncAdder #(parameter sAddWidth = 8)(
    output overflowBit,
    output [sAddWidth-1:0]sumFinal,
    //input  carryIn,
    input  [sAddWidth-1:0]numA, numB,
    input  adderClock, resetNeg
);
    //parameter sAddWidth = 8;

    //saving A and B in order to sync, and send output one cycle later
    wire [sAddWidth-1:0]savedA, savedB, savedSum;
    wire saveOverflow;

    // sync input
    registerNx #(sAddWidth) saveNumA(savedA, numA, adderClock, resetNeg);
    registerNx #(sAddWidth) saveNumB(savedB, numB, adderClock, resetNeg);

    // do ADD operation
    adderNx #(sAddWidth) addAandB(saveOverflow, coutX, savedSum, 1'b0, savedA, savedB);

    // sync output
    registerNx #(sAddWidth) savemySumAB(sumFinal, savedSum, adderClock, resetNeg);
    registerNx #(1) overFlowSync(overflowBit, saveOverflow, adderClock, resetNeg);
endmodule