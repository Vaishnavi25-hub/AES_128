module TOP(Clk,Rst_n,Rx,Tx,key_in,Tx_En,key_out,switches,switches_tx,
digit5,digit4,digit3,digit2,digit1,digit0,RxDone0,TxDone0,led);
		
input    [2:0]switches;   //transmission
input    [3:0]switches_tx;		  //display_data
output   [6:0]digit5;           //seven_seg_display    
output   [6:0]digit4;                
output   [6:0]digit3;                
output   [6:0]digit2;                
output   [6:0]digit1;                 
output   [6:0]digit0;
output  reg[7:0]led;     
input Clk; 
input Rst_n;
input Tx_En;
input key_in;
input key_out;
input Rx; 
output Tx;
wire [7:0] RxData1; 
reg [7:0]    TxData1; 
reg [127:0]    key1;
reg [127:0]    	TxData;  
wire [127:0] TxDatafinal; 
wire [127:0] key0;    
output          	RxDone0          ;
output          	TxDone0          ;
wire          	TxDone0          ;
wire            tick		;
wire          	TxEn            ;
wire 		RxEn		;
wire [3:0]      NBits    	;
wire [15:0]    	BaudRate        ; 
wire [127:0]dataout1;
wire [127:0]keyout1;
assign 		RxEn = 1'b1	;
assign 		BaudRate = 16'd325; 
assign 		NBits = 4'b1000	;	
 
UART_BaudRate_generator I_BAUDGEN(
    	.Clk(Clk)               ,
    	.Rst_n(Rst_n)           ,
    	.Tick(tick)             ,
    	.BaudRate(BaudRate)
    );

UART_rs232_rx I_RS232RX0(
    	.Clk(Clk)             	,
   	.Rst_n(Rst_n)         	,
    	.RxEn(RxEn)           	,
    	.RxData(RxData1)       	,
    	.RxDone(RxDone0)       	,
    	.Rx(Rx)               	,
    	.Tick(tick)           	,
    	.NBits(NBits)
    );
	 
always @(posedge RxDone0)
begin
led<=RxData1;
if(key_in == 1'b1)
begin
key1[127:0] = key1<<8;
key1[127:0] = {key1[127:8],RxData1};
end
else
begin
TxData[127:0] = TxData<<8;
TxData[127:0] = {TxData[127:8],RxData1};
end
end 

assign TxDatafinal = TxData;

aescipher a1(.clk(tick),.datain(TxDatafinal),
.key(key1),.dataout(dataout1),.keyout(keyout1),
.switches(switches),.switches_tx(switches_tx),.digit5(digit5),.digit4(digit4),
.digit3(digit3),.digit2(digit2),.digit1(digit1),.digit0(digit0),.rden(1'b1));


UART_rs232_tx I_RS232TX(
   	.Clk(Clk)            	,
		.Rst_n(Rst_n)           ,
    	.TxEn(1'b1)           	,
    	.TxData(TxData1)      	,
   	.TxDone(TxDone0)      	,
   	.Tx(Tx)               	,
   	.Tick(tick)           	,
   	.NBits(NBits)
    );

always @(posedge Clk) begin
   if (Tx_En) begin
	    if(!key_out)
		   begin
			case (switches_tx)
         4'h0   : TxData1 <= dataout1[127:120];
			4'h1   : TxData1 <= dataout1[119:112];
         4'h2   : TxData1 <= dataout1[111:104];
         4'h3   : TxData1 <= dataout1[103:96];
         4'h4   : TxData1 <= dataout1[95:88];
         4'h5   : TxData1 <= dataout1[87:80];
			4'h6   : TxData1 <= dataout1[79:72];
			4'h7   : TxData1 <= dataout1[71:64];
			4'h8   : TxData1 <= dataout1[63:56];
			4'h9   : TxData1 <= dataout1[55:48];
			4'ha   : TxData1 <= dataout1[47:40];
			4'hb   : TxData1 <= dataout1[39:32];
			4'hc   : TxData1 <= dataout1[31:24];
			4'hd   : TxData1 <= dataout1[23:16];
			4'he   : TxData1 <= dataout1[15:8];
			4'hf   : TxData1 <= dataout1[7:0];
			default: TxData1 <= 8'b0;
			endcase
	      end	
       else
		 begin
			case (switches_tx)
         4'h0   : TxData1 <= keyout1[127:120];
			4'h1   : TxData1 <= keyout1[119:112];
         4'h2   : TxData1 <= keyout1[111:104];
         4'h3   : TxData1 <= keyout1[103:96];
         4'h4   : TxData1 <= keyout1[95:88];
         4'h5   : TxData1 <= keyout1[87:80];
			4'h6   : TxData1 <= keyout1[79:72];
			4'h7   : TxData1 <= keyout1[71:64];
			4'h8   : TxData1 <= keyout1[63:56];
			4'h9   : TxData1 <= keyout1[55:48];
			4'ha   : TxData1 <= keyout1[47:40];
			4'hb   : TxData1 <= keyout1[39:32];
			4'hc   : TxData1 <= keyout1[31:24];
			4'hd   : TxData1 <= keyout1[23:16];
			4'he   : TxData1 <= keyout1[15:8];
			4'hf   : TxData1 <= keyout1[7:0];
			default: TxData1 <= 8'b0;
			endcase
	      end	
   end
end
endmodule