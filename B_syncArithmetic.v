/*  SYNChronous Adder & Subtractor [TIME: 2 CYCLES]
    Instantiation: syncAddnSub #(width) name(.overflowBit(), .carryOut(), .sumFinal(),
    .numA(), .numB(), .adderClock(), .resetNeg(), .opSelect(); */
module syncAddnSub #(parameter sAddWidth = 8)(
    output overflowBit,
    output carryOut,
    output [sAddWidth-1:0]sumFinal,
    //input  carryIn,
    input  [sAddWidth-1:0]numA, numB,
    input  adderClock, resetNeg,
    input  opSelect
); //parameter sAddWidth = 8;

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
// Instantiation: syncMultiplierNx #(width) name(.mulResult(), .numA(), .numB(), .mulClock(), .resetN());
module syncMultiplierNx #(parameter mulWidth=4)(
    output [((2*mulWidth)-1):0]mulResult,
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
    registerNx #(2*mulWidth) syncFinal(mulResult, MUL, mulClock, resetN);
endmodule


/*  2x Multiplier and 2x Adder
    S = (A x B) + (C x D) 
    CLOCK CYCLES: 4 in Total {1: store in addReg, 2: result from Adder,
     3: stored in MulReg, 4: result from mul}

I   Instantiation: syncMulAdd2 #(width) name(.resultS(), .numA(), .numB(),
         .numC(), .numD(), .clkP(), .resN());    */
module syncMulAdd2 #(parameter mulAddWidth=4)(
    output [(2*mulAddWidth):0] resultS, // { CarryOUT , RESULT }
    input  [(mulAddWidth-1):0] numA, numB, numC, numD,
    input  clkP, resN
);
    wire noUse; //not used overflow bit
    wire [((2*mulAddWidth)-1):0] mulRes [1:0];

    // generating AxB and CxD
    syncMultiplierNx #(mulAddWidth) ma0(mulRes[0], numA, numB, clkP, resN);
    syncMultiplierNx #(mulAddWidth) ma1(mulRes[1], numC, numD, clkP, resN);

    // adding the multiplied terms AB + CD
    syncAddnSub #(2*mulAddWidth) name(.overflowBit(noUse), .carryOut(resultS[2*mulAddWidth]),
        .sumFinal(resultS[((2*mulAddWidth)-1):0]), .numA(mulRes[0]), .numB(mulRes[1]),
        .adderClock(clkP), .resetNeg(resN), .opSelect(1'b0));
endmodule
