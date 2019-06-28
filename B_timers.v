
// generate a tick after 1s using clock of 50MHz
module clock_1s(
	output reg [25:0]countVal,
	output reg flagEnable,
	input CLKcount
);
	always@(posedge CLKcount) begin
		if(countVal == 26'd50000000) begin
			flagEnable = 1'b1;
			countVal <= 26'd0000000;
		end //if
		else if(countVal < 26'd50000000) begin
			flagEnable = 1'b0;
			countVal <= countVal + 1'b1;
		end //else if
		else begin
			countVal <= 26'd5000000;
		end
	end //always
endmodule



/*module clock_50Mto1s(
    output reg clk, 
	output reg [31:0]countVal,
    input  SYSCLK, EN, CLR
);
	reg cclr, cen;
	assign cclr = 1'b0;
	assign cen  = 1'b1;
	lpmcount32 timCount(SYSCLK, cen, cclr, countVal);
	always@(*) begin
		if(countVal == 26'h2FAF080) begin
			assign cclr = 1'b1;
		end //if
	end //always
		
    always@(posedge SYSCLK) begin
        if(countVal == 26'h2FAF080) begin	//reset on 50M
            clk = 1'b0;
            countVal <= 26'h0000000;
        end //if
        else if(countVal < 26'h17D7840) begin
            clk = 1'b0;
        end //else if
        else if(countVal > 26'h17D7840) begin
            clk = 1'b1;
        end //else if
		else begin
			countVal <= 26'h0000000;
		end //else
            countVal <= countVal + 1;
    end //always
endmodule*/


