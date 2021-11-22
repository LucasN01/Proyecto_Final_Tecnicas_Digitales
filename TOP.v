`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:50:14 11/19/2021 
// Design Name: 
// Module Name:    TOP 
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
module TOP_Montacargas(
    input Clock,
    input Reset,
    input P1,
    input P2,
    input P3,
    input FC1,
    input FC2,
    input FC3,
    output Disp_Enable,
    output [1:0] Motor,
    output [6:0] Display
    );
	 
wire [1:0] BCD_interno;
wire RESET_interno;

	Montacarga u1(
      .CLK(Clock),
		.RESET_aux(RESET_interno),
		.RESET(Reset),
		.P1(P1),
		.P2(P2),
		.P3(P3),
		.FC1(FC1),
		.FC2(FC2),
		.FC3(FC3),
		.DISPLAY_ENABLE(Disp_Enable),
		.MOTOR(Motor),
		.BCD(BCD_interno)
		);
		
	Decoder7Seg u2(
	   .BCD(BCD_interno),
		.DISPLAY(Display)
		);
		
	Divisor_Frec u3(
	.clk_in(Clock),
	.P1(P1),
	.P2(P2),
	.P3(P3),
	.reset(RESET_interno)
	);
	
	

endmodule




