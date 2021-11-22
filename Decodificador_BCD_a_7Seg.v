`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:49 11/18/2021 
// Design Name: 
// Module Name:    Decodificador_BCD_a_7Seg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Decoder7Seg(
    input [1:0] BCD,
    output reg [6:0] DISPLAY
    );
	 
	 always @ (BCD)
		case(BCD)
			2'b01 : DISPLAY <= 7'b0110000;
			2'b10 : DISPLAY <= 7'b1101101;
			2'b11 : DISPLAY <= 7'b1111001;
			default: DISPLAY <= 7'b1001111;  //Mensaje de error
		endcase

endmodule
