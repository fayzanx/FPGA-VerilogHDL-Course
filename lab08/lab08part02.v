module lab08part02(
    output [6:0]HEX3, HEX2, HEX1, HEX0,
    output [0:0]LEDG,
    input  [13:0]SW,
    input  [3:3]KEY
);
    /*  BOARD CONNECTIONS:
        RAM Data IN:  display at -> HEX3, HEX2
                      input from -> SW[7:0]
        RAM Data OUT: display at -> HEX1, HEX0
        Write Enable: input from -> SW[13]
                      display at -> LEDG[0]
        Clock: input from -> KEY[3]
    */
    wire [7:0]dataRAMout;
    assign LEDG[0] = SW[13];
    lpmRAM1port	myRAM(SW[12:8], KEY[3], SW[7:0], SW[13], dataRAMout);
    hexDisplay4digit disp(HEX3, HEX2, HEX1, HEX0, {SW[7:0], dataRAMout[7:0]});
endmodule