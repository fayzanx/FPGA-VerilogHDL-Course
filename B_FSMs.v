/*
    .FILEINFO
    FSMs (Finite State Machines)

*/

/* [L7P1] 4-bit sequence Detector [0000 or 1111]
    Instantiation: FSM_4xSequenceIdenticalDetect name(.fOut(), .W(), .pCLK(), .nREST()); */
module FSM_4xSequenceIdenticalDetect(
    output fOut, 
    output reg [8:0]Q,
    input W/*input*/, pCLK, nREST
);
	 //reg [8:0]Q;
    always@(posedge pCLK or negedge nREST) begin
        if(~nREST) begin
            Q[8:0] <= 9'd0;
        end//if
        else begin
            Q[0] <= 0;  
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