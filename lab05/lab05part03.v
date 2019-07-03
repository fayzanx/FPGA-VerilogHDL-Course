/*Part III
----------
Design and implement on the DE2 board a reaction-timer circuit. The circuit is to operate as follows:
1. The circuit is reset by pressing the pushbutton switch KEY0.
2. After an elapsed time, the red light labeled LEDR0 turns on and a four-digit BCD counter starts counting
in intervals of milliseconds. The amount of time in seconds from when the circuit is reset until LEDR 0 is
turned on is set by switches SW7Ã¢Ë†â€™0.
3. A person whose reflexes are being tested must press the pushbutton KEY 3 as quickly as possible to turn
the LED off and freeze the counter in its present state. The count which shows the reaction time will be
displayed on the 7-segment displays HEX2-0. */

module lab05part03(
    output [6:0]HEX3, HEX2, HEX1, HEX0,
    output reg [0:0]LEDR,
    input  [3:2]KEY,    //3 = Reaction, 2 = RESET
    input  [7:0]SW,
    input  CLOCK_50
);
    //notUsed
    wire [1:0]noUseCarry;
    wire [3:0]debSig[1:0];

    //Clock and Delay
    wire tickOn1ms, tickOn1sc;
    wire [15:0]timeElapsedms, timeElapsedsc;
    clock_1s getDelay1s(tickOn1sc, CLOCK_50);
    clock_1ms getDelay1ms(tickOn1ms, CLOCK_50);

    //Display
	wire c2, c1, keyF;
	reg enClkms, dsClksc; 
    reg kzero;
	reg pauseFlag;
	initial enClkms = 1'b1; 
    initial dsClksc = 1'b0;
	initial kzero = 1'b1;
	
    assign c2 = enClkms & tickOn1ms;
	assign c1 = ~dsClksc & tickOn1sc;
	assign keyF = kzero & KEY[2];
    counterBCD4d countms(timeElapsedms, noUseCarry[0], 1'b0, c2, keyF, debSig[0]);
    counterBCD4d count1s(timeElapsedsc, noUseCarry[1], 1'b0, c1, keyF, debSig[1]);
	hexDisplay4digit disp(HEX3, HEX2, HEX1, HEX0, timeElapsedms);

	//Reaction
	always@(posedge CLOCK_50) begin
		if(timeElapsedsc > SW) begin
            if(KEY[3] == 1'b0) begin
                enClkms <= 1'b0;
                LEDR[0] = 1'b0;
                LEDG[0] = 1'b1;
                dsClksc = 1'b1;
				kzero = 1'b1;
            end //if
            else begin
                enClkms <= enClkms;    //enable ms Clock
                LEDR[0] = 1'b1;
                dsClksc = 1'b0;
				kzero = 1'b1;
            end
        end
		else if (timeElapsedsc == SW) begin
				enClkms <= 1'b1;    //enable ms Clock
                LEDR[0] = 1'b1;
                dsClksc = 1'b0;
				kzero = 1'b1;
		end
        else begin //lessthan
            enClkms <= 1'b0;    //disable ms Clock
            LEDR[0] = 1'b0;
            dsClksc = 1'b0;
			kzero = 1'b1;
        end
    end //always
endmodule

//module tbl5t3;
//	wire [6:0]h3,h2,h1,h0;
//	wire lr;
//	reg [1:0]k;
//	reg [7:0]sw;
//	reg clk;
//	lab05part03 testl5p3(h3,h2,h1,h0, lr, k, sw, clk);
//	initial begin
//		#100;
//		sw = 8'b00000101;
//	end
//endmodule
