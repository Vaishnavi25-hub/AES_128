//`timescale 1ns / 1ps

module aescipher(clk,datain,key,dataout,keyout,
switches,switches_tx,
digit5,digit4,digit3,digit2,digit1,digit0,rden);

input clk;
input [127:0] datain;
input [127:0] key;
output[127:0] dataout;
output[127:0] keyout;
input    [2:0]switches;
input    [3:0]switches_tx;		
output   [6:0]digit5;                 
output   [6:0]digit4;                 
output   [6:0]digit3;                
output   [6:0]digit2;                
output   [6:0]digit1;                 
output   [6:0]digit0;

reg [127:0]    TxData1;
wire [127:0]    datain;
wire [127:0]    TxData2; 
reg    [4:0]add;
input rden;
wire wren;
reg [127:0]datain1;

wire [127:0] r0_out;
wire [127:0] r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out;
    
wire [127:0] keyout1,keyout2,keyout3,keyout4,keyout5,keyout6,keyout7,keyout8,keyout9;
assign r0_out = datain^key;
	 
	
rounds r1(.clk(clk),.rc(4'b1001),.data(r0_out),.keyin(key),.keyout(keyout1),.rndout(r1_out));
rounds r2(.clk(clk),.rc(4'b1000),.data(r1_out),.keyin(keyout1),.keyout(keyout2),.rndout(r2_out));
rounds r3(.clk(clk),.rc(4'b0111),.data(r2_out),.keyin(keyout2),.keyout(keyout3),.rndout(r3_out));
rounds r4(.clk(clk),.rc(4'b0110),.data(r3_out),.keyin(keyout3),.keyout(keyout4),.rndout(r4_out));
rounds r5(.clk(clk),.rc(4'b0101),.data(r4_out),.keyin(keyout4),.keyout(keyout5),.rndout(r5_out));
rounds r6(.clk(clk),.rc(4'b0100),.data(r5_out),.keyin(keyout5),.keyout(keyout6),.rndout(r6_out));
rounds r7(.clk(clk),.rc(4'b0011),.data(r6_out),.keyin(keyout6),.keyout(keyout7),.rndout(r7_out));
rounds r8(.clk(clk),.rc(4'b0010),.data(r7_out),.keyin(keyout7),.keyout(keyout8),.rndout(r8_out));
rounds r9(.clk(clk),.rc(4'b0001),.data(r8_out),.keyin(keyout8),.keyout(keyout9),.rndout(r9_out));
rounndlast r10(.clk(clk),.rc(4'b0000),.rin(r9_out),.keylastin(keyout9),.fout(dataout),.keyout(keyout));

	 test_seven_segments seven(
   .clk(clk),                    
   .count_en(1'b1),               
   .switches(switches),               
   .digit5(digit5),                 
   .digit4(digit4),                 
   .digit3(digit3),                
   .digit2(digit2),                
   .digit1(digit1),                 
   .digit0(digit0),                  
	.data({16'b0,TxData1})
);			
			
always @(posedge clk)
begin
case (switches_tx)
         4'h0   : begin 
			   		TxData1 <= r0_out;
						end
			4'h1   : begin
			  			TxData1 <= r1_out;
						end
         4'h2   : begin 
			  			TxData1 <= r2_out;
						end
         4'h3   : begin 
			  			TxData1 <= r3_out;
						end
         4'h4   : begin 
			  			TxData1 <= r4_out;
						end
         4'h5   : begin 
			     		TxData1 <= r5_out;
						end
			4'h6   : begin 
			      	TxData1 <= r6_out;
						end
			4'h7   : begin 
			      	TxData1 <= r7_out;
						end
			4'h8   : begin 
			      	TxData1 <= r8_out;
						end
			4'h9   : begin 
			      	TxData1 <= r9_out;
						end
			4'ha   : begin 
			      	TxData1 <= dataout;
						end
			4'hb   : begin 
			      	TxData1 <= datain;
						end
			4'hc   : begin 
			      	TxData1 <= key;
						end
			4'hd   : begin 
			      	TxData1 <= keyout;
						end
         endcase
end  
endmodule
