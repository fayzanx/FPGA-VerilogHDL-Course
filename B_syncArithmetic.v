// SYNChronous Adder & Subtractor [TIME: 2 CYCLES]
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
    
    // sync input
    registerNx #(sAddWidth) saveNumA(savedA, numA, adderClock, resetNeg);
    registerNx #(sAddWidth) saveNumB(savedB, numB, adderClock, resetNeg);

    // do ADD operation
    addnSubX #(sAddWidth) addAandB(saveOverflow, carryOut, savedSum, opSelect, savedA, savedB, opSelect);

    // sync output
    registerNx #(sAddWidth) savemySumAB(sumFinal, savedSum, adderClock, resetNeg);
    registerNx #(1) overFlowSync(overflowBit, saveOverflow, adderClock, resetNeg);
endmodule

// SYNChronous Multiplier. [TIME: 2 CYCLES]
module syncMultiplierNx #(parameter mulWidth=4)(
    output [((2*mulWidth)-1):0]sMUL,
    input  [(mulWidth-1):0]numA, numB,
    input  mulClock, resetN
);
    // synchronizing the inputs
    wire [(mulWidth-1):0]numAs, numBs;
    registerNx #(mulWidth) mulA(numAs, numA, mulClock, resetN);
    registerNx #(mulWidth) mulB(numBs, numB, mulClock, resetN);
    
    // doing the operation
    wire [((2*mulWidth)-1):0]MUL;
    multiplierNx #(mulWidth) mulAB(MUL, numAs, numBs);

    // synchronizing the final result
    registerNx #(2*mulWidth) syncFinal(sMUL, MUL, mulClock, resetN);
endmodule