`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:49 01/04/2019 
// Design Name: 
// Module Name:    login 
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
module login(clk , rst, keypad, logout , pass_out, count_out, admin_out, lock_out , pass_rw, admin_rw, lock_rw, count_rw,
 addr, pass_in, count_in, admin_in, lock_in, movement , flag);

output movement , flag;
reg movement , flag;

input clk , rst , logout;
output pass_rw, admin_rw, lock_rw, count_rw;
output [12:1]addr;
output [16:1]pass_in;
output [4:1] count_in;
output admin_in, lock_in;
input [16:1]pass_out;
input [4:1] count_out;
input admin_out, lock_out;   
input [3:0] keypad;


parameter pad1 = 4'b0001 , pad2 = 4'b0010 
			,pad3 = 4'b0011 , pad4 = 4'b0100 
			,pad5 = 4'b0101 , pad6 = 4'b0110 
			,pad7 = 4'b0111 , pad8 = 4'b1000 
			,pad9 = 4'b1001 , pad0 = 4'b0000 
			,padS = 4'b1010 , padM = 4'b1011 , padK = 4'b1111;

parameter start = 6'b000000 , userS1 =6'b000001
				,user1 = 6'b000010 , user2 =6'b000011
				,user3 = 6'b000100, userS2=6'b000101
				,validUser = 6'b000110 
				,userPassM1 = 6'b000111 ,userPassS1 = 6'b001000 // not-admin route start
				,userPass1 = 6'b001001 ,userPass2 = 6'b001010 , userPass3 = 6'b001011 , userPass4 = 6'b001100
				,userPassS2 = 6'b001101 , userPassM2 = 6'b001110 // not-admin route end
				,adminPass1 = 6'b001111,  adminPass2 = 6'b010000 , adminPass3 = 6'b010001 , adminPass4 = 6'b010010 //admin route start
				,adminPassS1 = 6'b010011 , adminPassM1 = 6'b010100
				,getUserS1 = 6'b010101 , getUser1 = 6'b010110 , getUser2 = 6'b010111 , getUser3 = 6'b011000 //getting user name for admin job! 
				,validGetUser = 6'b111100 //valid gotten user
				,delUserS1 = 6'b011001 , delUserM1 = 6'b011010 // deleting user
				,addOrNew = 6'b011011 // getting # , so it can be "add new user" or "assign new admin"
				,newAdminS1 = 6'b011100 , delPrevAdmin1 = 6'b111001 , delPrevAdmin2 = 6'b111000 // new admin
				,addUserPass1 = 6'b011101 , addUserPass2 = 6'b011110 , addUserPass3 = 6'b011111 , addUserPass4 = 6'b100000 // add user
				,addUserPassS1 = 6'b100001 , addUserPassM1 = 6'b100010 //admin route end
				,warning = 6'b111111 , lock = 6'b111110 , counter = 6'b111100;
				
reg [5:0] state = start;

reg my_clk, my_rst , cs = 1, pass_rw =0, admin_rw =0, lock_rw =0, count_rw =0;
reg [12:1] addr = 12'b000000000001 , temp1, temp2 , temp3;
reg [16:1]pass_in , tempass2 , tempass1 , tempass3;
reg [4:1] count_in;
reg admin_in =0, lock_in =0;    
wire [16:1]pass_out;
wire[4:1] count_out;
wire admin_out, lock_out;  

//ram_usage ram(clk , rst, cs , pass_rw, admin_rw, lock_rw, count_rw ,addr , pass_in , count_in, admin_in , lock_in , pass_out, count_out , admin_out , lock_out  );
		
	
	always @(posedge clk)
		if(rst==1) begin 
			state=start;
			movement = 1'b0;
		end
	else
		begin if(logout == 1'b1)
			begin
				movement = 1'b0; 
				flag = 1'b1;
			end
		case (state)
			warning:
				
				//do something
				#5
				state = start;
		
		
			start: 
					begin
					pass_rw =0; admin_rw =0; lock_rw =0; count_rw =0;
					admin_in =0; lock_in =0; pass_in = 0; count_in = 0;
					if (keypad == padS)
						begin
						state = userS1;
						end
					else
						state = start;
					end
			userS1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						temp1[12:9] = keypad;
						state = user1;
						end
					else if (keypad == padK)
						state = userS1;
					else 
						state = warning;
						
			user1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						temp1[8:5] = keypad;
						state = user2;
						end
					else if (keypad == padK)
						state = user1;
					else
						state = warning;
			user2: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						temp1[4:1] = keypad;
						addr = temp1;   
						state = user3;
						end
					else if (keypad == padK)
						state = user2;
					else
						state = warning;
			user3: if(keypad == padS)  
						begin
		//				addr = temp1; 
						if(lock_out == 0)
							state = validUser;
						else
							state = warning;
						end
					else if (keypad == padK)
						state =  user3;
					else
						state = warning;
						
/*			userS2: if(lock_out == 0) //check user validity
						begin
						state = validUser;
						end
					else if (keypad == padK)
						state = userS2;
					else
						state = warning;
	*/					
			validUser: if(keypad == padM)  
						begin
						state = userPassM1;
						count_in = count_out;
						lock_in = 1'b0;
						count_rw = 1'b1;
						lock_rw = 1'b1;
						end
					else if(keypad == padS)
						state = warning;
					else if (keypad == padK)
						state = validUser;
					else 
						begin
						tempass2 [16:13] = keypad;
						//movement = 1'b0;
						state = adminPass1;
						end
						
			userPassM1: if(keypad == padS)
						begin
						state = userPassS1;
						end
						else if (keypad == padK)
						state = userPassM1;
					else
						state = warning;
						
			userPassS1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass1 [16:13] = keypad;
						state = userPass1;
						end
						else if (keypad == padK)
						state = userPassM1;
					else
						state = warning;
						
						
			userPass1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass1 [12:9] = keypad;
						state = userPass2;
						end
						else if (keypad == padK)
						state =  userPass1;
					else
						state = warning;
			userPass2: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass1 [8:5] = keypad;
						state = userPass3;
						end
						else if (keypad == padK)
						state = userPass2;
					else
						state = warning;
			userPass3: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass1 [4:1] = keypad;
						state = userPass4;
						end
					else if (keypad == padK)
						state = userPass3;
					else
						state = warning;
						
			userPass4: if(keypad == padS)  
						begin
						state = userPassS2;
						end
					else if (keypad == padK)
						state = userPass4;
					else
						state = warning;
						
			userPassS2: if(keypad == padM)  
						begin
							if(pass_out == tempass1)
								begin
									movement = 1'b1;
									flag = 1'b0;
									state = start;
								end 
							else
								begin
								if (count_in == 4'b0000)
									count_in = 4'b0001;
								else if (count_in == 4'b0001)
									count_in = 4'b0010;
								else if (count_in == 4'b0010)
									begin
									count_in = 4'b0000;
									lock_in = 1'b1;
									end
								state = warning;
								end
						end
					else if (keypad == padK)
						state = userPassS2;
					else
						state = warning;
			
						
			adminPass1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass2 [12:9] = keypad;
						state = adminPass2;
						end
					else if (keypad == padK)
						state =  adminPass1;
					else
						state = warning;
			adminPass2: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass2 [8:5] = keypad;
						state = adminPass3;
						end
					else if (keypad == padK)
						state = adminPass2;
					else
						state = warning;
			adminPass3: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass2 [4:1] = keypad;
						state = adminPass4;
						end
					else if (keypad == padK)
						state = adminPass3;
					else
						state = warning;
						
			adminPass4: if(keypad == padS)  
						begin
						state = adminPassS1;
						end
					else if (keypad == padK)
						state = adminPass4;
					else
						state = warning;
						
			adminPassS1: if(admin_out == 1'b1 && tempass2 == pass_out && keypad == padM)  
						begin
						state = adminPassM1;
						end
					else if (keypad == padK)
						state = adminPassS1;
					else
						state = warning;	
						
			adminPassM1: if( keypad == padS)  
						begin
					//	pass_rw =1; admin_rw =1; lock_rw =1; count_rw =1;
						state = getUserS1;
						end
					else if (keypad == padK)
						state = adminPassM1;
					else
						state = warning;	


			getUserS1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						temp2 [12:9] = keypad;
						state = getUser1;
						end
					else if (keypad == padK)
						state = getUserS1;
					else
						state = warning;
						
			getUser1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						temp2 [8:5] = keypad;
						state = getUser2;
						end
					else if (keypad == padK)
						state = getUser1;
					else
						state = warning;
						
			getUser2: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						temp2 [4:1] = keypad;
						addr = temp2;
						state = validGetUser;
						end
					else if (keypad == padK)
						state = getUser2;
					else
						state = warning;
						
			getUser3: if(1)  
						begin
						state = validGetUser;
						end
					else if (keypad == padK)
						state = getUser3;
					else
						state = warning;
						
			
			validGetUser: if(keypad == padM)  
						begin
						admin_rw = 1'b1;
						state = addOrNew;
						end
					else if(keypad == padS)
						begin
						state = delUserS1;
						lock_rw = 1'b1;
						end
					else if (keypad == padK)
						state = validGetUser;
					else 
						state = warning;
						
			delUserS1: if(keypad == padM)  
						begin
						lock_in = 1'b1;
						state = start;
						end
					else if (keypad == padK)
						state = delUserS1;
					else
						state = warning;
						
			addOrNew: if(keypad == padM)  
						begin
						admin_in = 1'b1;
						state = delPrevAdmin1;
						end
					else if(keypad == padS)
						state = warning;
					else if (keypad == padK)
						state = addOrNew;
						
					else
						begin
						tempass3 [16:13] = keypad;
						state = addUserPass1;
						end
						
			delPrevAdmin1: begin admin_rw = 1'b0;
								addr = temp1;
								admin_in = 1'b0;
								state = delPrevAdmin2;
								end
								
			delPrevAdmin2: begin
								admin_rw = 1'b1;
								state = start;
								end
								
			addUserPass1: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass3 [12:9] = keypad;
						state = addUserPass2;
						end
					else if (keypad == padK)
						state = addUserPass1;
					else
						state = warning;
						
			addUserPass2: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass3 [8:5] = keypad;
						state = addUserPass3;
						end
					else if (keypad == padK)
						state = addUserPass2;
					else
						state = warning;
						
			addUserPass3: if(keypad != padS && keypad != padM && keypad != padK)
						begin
						tempass3 [4:1] = keypad;
						state = addUserPass4;
						end
					else if (keypad == padK)
						state = addUserPass3;
					else
						state = warning;
						
			addUserPass4: if(keypad == padS)  
						begin
						state = addUserPassS1;
						pass_rw = 1'b1;
						count_rw= 1'b1;
						lock_rw = 1'b1;
						end
					else if (keypad == padK)
						state = addUserPass4;
					else
						state = warning;
						
			addUserPassS1: if(keypad == padM)  
						begin
						pass_in = tempass3;
						lock_in = 1'b0;
						count_in = 4'b0000;
						state = start;
						end
					else if (keypad == padK)
						state = addUserPassS1;
					else
						state = warning;	

			
		endcase
		end
				
				
				
				
				
				
endmodule