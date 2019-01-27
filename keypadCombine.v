`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:35 01/21/2019 
// Design Name: 
// Module Name:    keypadCombine 
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
module keypadCombine(keypadF1 , keypadF2 , keypadF3 , keypadIn , keypad);

input [3:0] keypadF1 , keypadF2,  keypadF3 , keypadIn;
output [3:0] keypad;
wire [3:0] keypad;


or g1(keypad[0] , keypadF1[0] , keypadF2[0] , keypadF3[0] , keypadIn[0]);
or g2(keypad[1] , keypadF1[1] , keypadF2[1] , keypadF3[1] , keypadIn[1]);
or g3(keypad[2] , keypadF1[2] , keypadF2[2] , keypadF3[2] , keypadIn[2]);
or g4(keypad[3] , keypadF1[3] , keypadF2[3] , keypadF3[3] , keypadIn[3]);


endmodule
