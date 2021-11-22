`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:28 11/19/2021 
// Design Name: 
// Module Name:    Divisor_Frec 
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
module Divisor_Frec(
    input clk_in,
	 input P1,
    input P2,
    input P3,
    output reg reset,
	 output reg clk_out
    );

	parameter frecuencia = 4000000; //Frecuencia del Clock integrado en el CPLD (4 MHz)
	parameter frec_out = 1; //Frecuencia de salida, que debe ser de 1 Hz
	parameter cont_max = frecuencia / (2*frec_out);
	parameter cant_segundos = 4'b1001;                 
	
	reg [27:0] cont;
	reg [3:0] aux;
		
	initial begin
		cont  = 28'b0;
		aux  = 4'b0;
		clk_out = 0;
		reset = 0;
	end
	
	always @ (posedge clk_in) begin
		if(cont == (cont_max))begin
			clk_out <= ~clk_out;  //Cambia el estado del contador de salida y resetea el contador
			cont <= 28'b0;
		end
		else begin
			cont <= cont+1;
		end
	end
		
	always @ (negedge clk_out) begin      
		if(aux < cant_segundos) begin     //Se coloca que sea menor a 9 ya que demora un pulso de reloj en reaccionar el sistema
			if(P1==0) begin					//Por lo tanto el reset se pone en 1 si durante 10 segundos no se presiona ningun pulsador
				if(P2==0) begin
					if(P3==0) begin
						aux <= (aux+ 4'b0001);
						reset <= 0;
					end
				end
			end
		end	
		else begin
			aux <= 4'b0000;
			reset <= 1;
		end
	end
	
endmodule
