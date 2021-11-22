`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:41 11/18/2021 
// Design Name: 
// Module Name:    Montacargas 
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
module Montacarga(
    input CLK,
    input RESET,
	 input RESET_aux,
    input P1,
    input P2,
    input P3,
    input FC1,
    input FC2,
    input FC3,
	 output reg DISPLAY_ENABLE,
    output reg [1:0] MOTOR,
    output reg [1:0] BCD
    );

	//SE DEFINEN LAS CONSTANTES QUE REPRESENTAN LOS ESTADOS DE LA MAQUINA DE MOORE
	parameter Piso1 = 3'b000;
   parameter Sube_1 = 3'b001;
   parameter Piso2 = 3'b010;
   parameter Sube_2 = 3'b011;
   parameter Piso3 = 3'b100;
   parameter Baja_1 = 3'b101;
   parameter Baja_2 = 3'b110;

   reg [2:0] state = Piso1;

	//SE DESCRIBE EL MONTACARGA CON UN RESET SÍNCRONO
   always@(posedge CLK)
      if (RESET | RESET_aux) begin    //Cunado se presiona el RESET el montacargas se dirige al Piso1
         case(state)
				Piso1 : begin
					state <= Piso1;				 //Se mantiene en le Piso1
					DISPLAY_ENABLE <= 1;			 //Activa el Display
					MOTOR <= 2'b00;             //Apaga el Motor
					BCD <= 2'b01;					 //Muestra por el Display el numero 1
				end
				Piso2 : begin
					state <= Baja_1;				//Se dirige al Piso1
					DISPLAY_ENABLE <= 1;			//Activa el Display
					MOTOR <= 2'b00;				//Apaga el Motor
					BCD <= 2'b10;					//Muestra por el Display el numero 2
				end
				Piso3 : begin
					state <= Baja_1;				//Se dirige al Piso1
					DISPLAY_ENABLE <= 1;			//Activa el Display
					MOTOR <= 2'b00;				//Apaga el Motor
					BCD <= 2'b11;					//Muestra por el Display el numero 3
				end
			endcase
      end
      else
         case (state)
            Piso1 : begin
               if (P2)
                  state <= Sube_1;
               else if (P3)
                  state <= Sube_2;
               else
                  state <= Piso1;
					DISPLAY_ENABLE <= 1;			 //Activa el Display
					MOTOR <= 2'b00;             //Apaga el Motor
					BCD <= 2'b01;					 //Muestra por el Display el numero 1
            end
            Sube_1 : begin
               if (FC2)
                  state <= Piso2;
               else
                  state <= Sube_1;
					DISPLAY_ENABLE <= 0;   //Apaga el display de 7 Segmentos
					MOTOR <= 2'b01;        //El motor se activa para que el montacarga suba hasta el Piso2
					BCD <= 2'bXX;
            end
            Piso2 : begin
               if (P3)
                  state <= Sube_2;
               else if (P1)
                  state <= Baja_1;
               else
                  state <= Piso2;
					DISPLAY_ENABLE <= 1;			//Activa el Display
					MOTOR <= 2'b00;				//Apaga el Motor
					BCD <= 2'b10;					//Muestra por el Display el numero 2
            end
            Sube_2 : begin
               if (FC3)
                  state <= Piso3;
               else
                  state <= Sube_2;
					DISPLAY_ENABLE <= 0;   //Apaga el display de 7 Segmentos
					MOTOR <= 2'b01;        //El motor se activa para que el montacarga suba hasta el Piso3
					BCD <= 2'bXX;
            end
            Piso3 : begin
               if (P2)
                  state <= Baja_2;
               else if (P1)
                  state <= Baja_1;
               else
                  state <= Piso3;
					DISPLAY_ENABLE <= 1;			//Activa el Display
					MOTOR <= 2'b00;				//Apaga el Motor
					BCD <= 2'b11;					//Muestra por el Display el numero 3
            end
            Baja_1 : begin
               if (FC1)
                  state <= Piso1;
               else
                  state <= Baja_1;
					DISPLAY_ENABLE <= 0;   //Apaga el display de 7 Segmentos
					MOTOR <= 2'b10;        //El motor se activa para que el montacarga baje hasta el Piso1
					BCD <= 2'bXX;
            end
            Baja_2 : begin
               if (FC2)
                  state <= Piso2;
               else
                  state <= Baja_2;
					DISPLAY_ENABLE <= 0;   //Apaga el display de 7 Segmentos
					MOTOR <= 2'b10;        //El motor se activa para que el montacarga baje hasta el Piso2
					BCD <= 2'bXX;
            end
				default: begin				  //En caso de que la maquina entre en un estado no conocido, se comporta como un RESET
               state <= Piso1;
					DISPLAY_ENABLE <= 1;
					MOTOR <= 2'b00;
					BCD <= 2'b01;
            end
           
         endcase
							

endmodule
