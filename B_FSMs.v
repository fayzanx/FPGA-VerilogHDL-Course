/*
    .FILEINFO
    FSMs (Finite State Machines)

*/

/* [L7P1] 4-bit sequence Detector [0000 or 1111]
    Instantiation: FSM_4xSequenceIdenticalDetect name(.fOut(), .W(), .pCLK(), .nREST());
    
    + Updated for part b:
     +---+---states----++---+------w=0----++---+------w=1----+
    ][ A | 0 0000 0000 || B | 0 0000 0011 || F | 0 0010 0001 ][
    ][ B | 0 0000 0011 || C | 0 0000 0101 || F | 0 0010 0001 ][
    ][ C | 0 0000 0101 || D | 0 0000 1001 || F | 0 0010 0001 ][
    ][ D | 0 0000 1001 || E | 0 0001 0001 || F | 0 0010 0001 ][
    ][ E | 0 0001 0001 || E | 0 0001 0001 || F | 0 0010 0001 ][
    ][ F | 0 0010 0001 || B | 0 0000 0011 || G | 0 0100 0001 ][
    ][ G | 0 0100 0001 || B | 0 0000 0011 || H | 0 1000 0001 ][
    ][ H | 0 1000 0001 || B | 0 0000 0011 || I | 1 0000 0001 ][
    ][ I | 1 0000 0001 || B | 0 0000 0011 || I | 1 0000 0001 ][
     +---+-------------++---+-------------++---+-------------+                */
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