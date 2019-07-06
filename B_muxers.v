
// [../B_1xMUX2to1.v]
module B_1xMUX2to1(
	input S, X, Y,
	output M
);
	assign M = ((~S & X) | (S & Y));
endmodule

// [../B_4xMUX2to1.v]
module B_4xMUX2to1(
	input S,
	input [3:0]numA, numB,
	output [3:0]M
);
	B_1xMUX2to1 m3(S, numA[3], numB[3], M[3]);
	B_1xMUX2to1 m2(S, numA[2], numB[2], M[2]);
	B_1xMUX2to1 m1(S, numA[1], numB[1], M[1]);
	B_1xMUX2to1 m0(S, numA[0], numB[0], M[0]);
endmodule

// A Generalized 2x1 MUX
// Instantiation: mux2x1 #(width) name(.M(), .X(), .Y(), .Sel());
module mux2x1 #(parameter dataW=8)(
    output reg [(dataW-1):0]M,
    input  [(dataW-1):0]X,
    input  [(dataW-1):0]Y,
    input  Sel
);
    always@(*) begin
        if (Sel) begin
            M = Y;
        end
        else begin
            M = X;
        end
    end
endmodule
