/*

    FSMs (Finite State Machines)

*/

/*  [L7P1] 4-bit sequence Detector [0000 or 1111]
    Instantiation: FSM_4xSequenceIdenticalDetect name(.fOut(), .W(), .pCLK(), .nREST());
----------------------------------------------------------------------------------------
    + Updated for part b:
    ......STATE.TABLE..........
    ..PRSNTSTATE...NXTSTATE....
    .............W=0.....W=1...
    .....A........B.......F....
    .....B........C.......F....
    .....C........D.......F....
    .....D........E.......F....
    .....E........E.......F....
    .....F........B.......G....
    .....G........B.......H....
    .....H........B.......I....
    .....I........B.......I....

    -+---+---states----++---+------w=0----++---+------w=1----+
    ][ A | 0 0000 0000 || B | 0 0000 0011 || F | 0 0010 0001 ][
    ][ B | 0 0000 0011 || C | 0 0000 0101 || F | 0 0010 0001 ][
    ][ C | 0 0000 0101 || D | 0 0000 1001 || F | 0 0010 0001 ][
    ][ D | 0 0000 1001 || E | 0 0001 0001 || F | 0 0010 0001 ][
    ][ E | 0 0001 0001 || E | 0 0001 0001 || F | 0 0010 0001 ][
    ][ F | 0 0010 0001 || B | 0 0000 0011 || G | 0 0100 0001 ][
    ][ G | 0 0100 0001 || B | 0 0000 0011 || H | 0 1000 0001 ][
    ][ H | 0 1000 0001 || B | 0 0000 0011 || I | 1 0000 0001 ][
    ][ I | 1 0000 0001 || B | 0 0000 0011 || I | 1 0000 0001 ][
    -+---+-------------++---+-------------++---+-------------+                */
module FSM_4xSequenceIdenticalDetect(
    output fOut, 
    //output reg [8:0]Q,
    input W/*input*/, pCLK, nREST
);
	reg [8:0]Q;
    always@(posedge pCLK or negedge nREST) begin
        if(~nREST) begin
            //RESET state = A [0 0000 0000]
            Q[8:0] <= 9'b000000000;
        end//if
        else begin
            Q[0] <= 1;  
            Q[1] <= (Q[0]|Q[5]|Q[6]|Q[7]|Q[8])&(~W);
            Q[2] <= (Q[1])&(~W);
            Q[3] <= (Q[2])&(~W);
            Q[4] <= (Q[3]|Q[4])&(~W);
            Q[5] <= (Q[0]|Q[1]|Q[2]|Q[3]|Q[4])&(W);
            Q[6] <= (Q[5])&(W);
            Q[7] <= (Q[6])&(W);
            Q[8] <= (Q[7]|Q[8])&(W);
        end //ifelse
    end //always
	 assign fOut = Q[4]|Q[8];
endmodule


/* --------------------------------------------------------------------------
A modified style coding of the above module
Instantiation: FSM_4xSequenceDetectorB name(.fOut(), .W(), .pCLK(), .nREST());
*/
module FSM_4xSequenceDetectorB(
    output reg fOut, 
    //output [3:0]fQ,
    input W/*input*/, pCLK, nREST
);
    // STATE ASSIGNMENT LIST as parameters
    parameter A = 4'b0000;
    parameter B = 4'b0001;
    parameter C = 4'b0010;
    parameter D = 4'b0011;
    parameter E = 4'b0100;
    parameter F = 4'b0101;
    parameter G = 4'b0110;
    parameter H = 4'b0111;
    parameter I = 4'b1000;
    // ----------------------------------

    wire [3:0]fQ;
    reg  [3:0]fD;

    always@(*) begin
        case({fQ[3:0],W})
            5'b00000: fD = B;
            5'b00001: fD = F;
            5'b00010: fD = C;
            5'b00011: fD = F;
            5'b00100: fD = D;
            5'b00101: fD = F;
            5'b00110: fD = E;
            5'b00111: fD = F;
            5'b01000: fD = E;
            5'b01001: fD = F;
            5'b01010: fD = B;
            5'b01011: fD = G;
            5'b01100: fD = B;
            5'b01101: fD = H;
            5'b01110: fD = B;
            5'b01111: fD = I;
            5'b10000: fD = B;
            5'b10001: fD = I;
            default:  fD = A; 
        endcase
    end //always

    // set aside 4 positive edge triggered low async reset flip flops
    registerNx #(4) ffx4(.Q(fQ[3:0]), .D(fD[3:0]), .regCLK(pCLK), .regRESN(nREST)); 

    // output control
    always@(*) begin
        case(fQ[3:0])
            4'd4: fOut = 1'b1;
            4'd8: fOut = 1'b1;
            default: fOut = 1'b0;
        endcase
    end

endmodule