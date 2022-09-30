//decryption
module KeyGeneration(clk,rc,key,keyout);
//  switches,               
//   digit5,            
//   digit4,                 
//   digit3,                
//   digit2,                
//   digit1,                 
//   digit0);
	
//input    [2:0]switches;	
//output   [6:0]digit5;                 
//output   [6:0]digit4;                 
//output   [6:0]digit3;                
//output   [6:0]digit2;                
//output   [6:0]digit1;                 
//output   [6:0]digit0;

    
   input [3:0] rc;
   input [127:0]key;
   output [127:0] keyout;
   input clk;
   wire [31:0] w4,w5,w6,w7,tem;
                
       assign w4 = key[127:96];
       assign w5 = key[95:64];
       assign w6 = key[63:32];
       assign w7 = key[31:0];
	   
	   assign keyout[95:64] = w5 ^ w4;//w1
	   assign keyout[63:32] = w6 ^ w5;//w2
	   assign keyout[31:0] = w7 ^ w6;//w3
	   
	    sbox a1(.clk(clk),.i_Seed_Data(keyout[23:16]),.ans(tem[31:24]));//forward sbox
       sbox a2(.clk(clk),.i_Seed_Data(keyout[15:8]),.ans(tem[23:16]));
       sbox a3(.clk(clk),.i_Seed_Data(keyout[7:0]),.ans(tem[15:8]));
       sbox a4(.clk(clk),.i_Seed_Data(keyout[31:24]),.ans(tem[7:0]));
       
	   assign keyout[127:96] = tem ^ rcon(rc) ^ w4;//rcon(rc) same as forward
		
//		test_seven_segments seven(
//   .clk(clk),                    
//   .count_en(1'b1),               
//   .switches(switches),               
//   .digit5(digit5),                 
//   .digit4(digit4),                 
//   .digit3(digit3),                
//   .digit2(digit2),                
//   .digit1(digit1),                 
//   .digit0(digit0),                  
//	.data({16'b0,keyout})
//);
//f7 f1 cb d8     a1 1f 61 68
   
     function [31:0]	rcon;
      input	[3:0]	rc;
      case(rc)	
         4'h0: rcon=32'h01_00_00_00;
         4'h1: rcon=32'h02_00_00_00;
         4'h2: rcon=32'h04_00_00_00;
         4'h3: rcon=32'h08_00_00_00;
         4'h4: rcon=32'h10_00_00_00;
         4'h5: rcon=32'h20_00_00_00;
         4'h6: rcon=32'h40_00_00_00;
         4'h7: rcon=32'h80_00_00_00;
         4'h8: rcon=32'h1b_00_00_00;
         4'h9: rcon=32'h36_00_00_00;
         default: rcon=32'h00_00_00_00;
       endcase

     endfunction

endmodule
