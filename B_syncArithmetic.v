module syncAdder(
    output [sAddWidth-1:0]sumFinal,
    output overflowBit,
    input  carryIn,
    input  [sAddWidth-1:0]numA, numB,
    input  adderClock, resetNeg
);
    parameter sAddWidth = 8;

    //saving A and B in order to sync, and send output one cycle later
    wire [sAddWidth-1:0]savedA, savedB;
    registerNx #(sAddWidth) saveNumA(savedA, numA, adderClock, resetNeg);
    registerNx #(sAddWidth) saveNumB(savedB, numB, adderClock, resetNeg);


endmodule