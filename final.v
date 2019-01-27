`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:39 01/20/2019 
// Design Name: 
// Module Name:    final 
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
module final(clk , rst, reqin, reqout, pres ,keypadF1 , keypadF2 , keypadF3 , keypadIn , door, dir);

input clk , rst;
input[2:0] reqin , reqout, pres;
input [3:0] keypadF1,keypadF2,keypadF3, keypadIn;

output door , dir;
wire [2:0] door;
wire[1:0] dir;

reg cs = 1'b1;

wire movement;
wire logout,flag;
wire [3:0] keypad;


wire pass_rw , admin_rw , lock_rw , count_rw ;
wire[12:1] addr ;
wire [16:1]pass_in;
wire [4:1] count_in;
wire admin_in , lock_in ;    
wire [16:1]pass_out;
wire[4:1] count_out;
wire admin_out, lock_out;  

keypadCombine kpc(keypadF1 , keypadF2 , keypadF3 , keypadIn , keypad);


ram_usage ram(clk , rst, cs , pass_rw, admin_rw, lock_rw, count_rw ,addr , pass_in , count_in, admin_in , lock_in , pass_out, count_out , admin_out , lock_out  );

login lg(clk , rst, keypad, logout , pass_out, count_out, admin_out, lock_out , pass_rw, admin_rw, lock_rw, count_rw,
 addr, pass_in, count_in, admin_in, lock_in, movement , flag);
 
elevator elv(clk , rst ,movement,flag , reqin , reqout, pres , logout,  dir , door);
 

endmodule
