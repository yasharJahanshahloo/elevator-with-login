`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:53 01/21/2019 
// Design Name: 
// Module Name:    testBench_final 
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
module testBench_final();

parameter pad1 = 4'b0001 , pad2 = 4'b0010 
			,pad3 = 4'b0011 , pad4 = 4'b0100 
			,pad5 = 4'b0101 , pad6 = 4'b0110 
			,pad7 = 4'b0111 , pad8 = 4'b1000 
			,pad9 = 4'b1001 , pad0 = 4'b0000 
			,padS = 4'b1010 , padM = 4'b1011, padK = 4'b1111;

reg clk , rst;
reg [2:0] reqin , reqout, pres;
reg [3:0] keypadF1 , keypadF2,  keypadF3 , keypadIn;
wire [2:0]  door ;
wire [1:0] dir;

final fnl(clk , rst, reqin, reqout, pres ,keypadF1 , keypadF2 , keypadF3 , keypadIn , door, dir);


initial
   begin
      clk = 1'b0;
      #4000 $finish; 
   end

always
   #10 clk = ~clk;

initial begin


	rst = 1'b0;
	#27
	rst = 1'b1;
	#23
	rst = 1'b0;
	#25
	 
	
	/////////////////////// admin login
	keypadF1 = pad0;
	keypadF2 = pad0;
	keypadF3 = padS;
	keypadIn = pad0;
	#20

	keypadF3 = pad0;
	#20

	keypadF3 = pad0;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	pres=3'b001;
	reqout=3'b100;
	reqin=3'b000;
	#20
	keypadF3 = padM;
	
	#20
	
	/// admin add new user
	keypadF2 = padS;
	keypadF3 = pad0;
	pres=3'b100;
	
	#20
	keypadF2 = pad0;
	reqin=3'b000;
	reqout=3'b000;
	#20
	keypadF2 = pad0;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = padS;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = padS;
	#20
	keypadF2 = padM;
	#20
	// add user
	keypadF2 = padS;
	#20
	keypadF2 = pad0;
	#20
	keypadF2 = pad0;
	#20
	keypadF2 = pad4;
	#20
	keypadF2 = padM;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = pad2;
	#20
	keypadF2 = pad0;
	#20
	keypadF2 = pad2;
	#20
	keypadF2 = padS;
	#20
	keypadF2 = padM;
	#20
	
	// new user login
	keypadF1 = padS;
	keypadF2 = pad0;
	#20
	keypadF1 = pad0;
	#20
	keypadF1 = pad0;
	#20
	keypadF1 = pad4;
	#20
	keypadF1 = padS;
	#20
	keypadF1 = padM;
	#20
	keypadF1 = padS;
	#20
	keypadF1 = pad1;
	#20
	keypadF1 = pad2;
	#20
	keypadF1 = pad0;
	#20
	keypadF1 = pad2;
	#20
	pres=3'b100;
	reqout=3'b001;
	reqin=3'b000;
	keypadF1 = padS;
	
	#20
	keypadF1 = padM;
	
	#20
	pres=3'b001;
	
	keypadF1 = pad0;
	#20
	reqout=3'b000;
	
	#20
	////// change admin
	keypadF2 = padS;
	#20
	keypadF2 = pad0;
	#20
	
	
	keypadF2 = pad0;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = padS;
	#20
	keypadF2 = pad1;
	#20
	
	
	keypadF2 = pad1;
	#20
	
	
	keypadF2 = pad1;
	#20
	
	
	keypadF2 = pad1;
	#20
	keypadF2 = padS;
	#20
	keypadF2 = padM;
	#20
	///////// changing to user 004
	keypadF2 = padS;
	#20
	keypadF2 = pad0;
	#20
	
	
	keypadF2 = pad0;
	#20
	keypadF2 = pad4;
	#20
	keypadF2 = padM;
	#20
	
	
	keypadF2 = padM;
	#60
	keypadF2 = pad0;
	
	//////// login admin 
	keypadF2 = padS;
	#20
	keypadF2 = pad0;
	#20
	
	
	keypadF2 = pad0;
	#20
	keypadF2 = pad1;
	#20
	keypadF2 = padS;
	#20
	keypadF2 = pad1;
	#20
	
	
	keypadF2 = pad1;
	#20
	
	
	keypadF2 = pad1;
	#20
	
	
	keypadF2 = pad1;
	#20
	keypadF2 = padS;
	#20
	keypadF2 = padM;
	#40
	/*
	/////////////////////////
	//check counter #1
	keypadF2 = pad0;
	keypadF3 = padS;
	#20
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad0;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	#40
	//check counter #2
	keypadF3 = padS;
	#20
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad0;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	
	#40
	// check counter #3
	keypadF3 = padS;
	#20
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad0;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = pad8;
	#20
	
	
	keypadF3 = pad8;
	#20
	
	
	keypadF3 = pad8;
	#20
	
	
	keypadF3 = pad8;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	#40
	//check counter #4
	keypadF3 = padS;
	#20
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad0;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#40
	*/
	///////////// remove 001
	keypadF2 = pad0;
	keypadF3 = padS;
	#20
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad0;
	#20
	keypadF3 = pad4;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad2;
	#20
	
	
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad2;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	#20
	///////////////// removing
	keypadF3 = padS;
	#20
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad0;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	 #20
	 //deleted user login
	 keypadF3 = padS;
	#20
	keypadF3 = pad0;
	#20
	
	
	keypadF3 = pad0;
	#20
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#40
	keypadF3 = pad0;

	
	/* 
	#20
	#20 
	keypadF3 = padM;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad1;
	#20
	
	
	keypadF3 = pad1;
	#20
	keypadF3 = padS;
	#20
	keypadF3 = padM;
	*/
end


endmodule
