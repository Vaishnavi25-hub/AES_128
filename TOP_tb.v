module TOP_tb;
reg clk;
reg [127:0]datain;
reg [127:0]key;
wire [127:0]dataout;
wire [127:0]keyout;

aescipher a1(.clk(clk),.datain(datain),.key(key),.dataout(dataout),
.keyout(keyout));

always #5 clk=~clk;
initial
begin
clk<=1;
#10;
key=128'h5468617473206D79204B756E67204675;
//datain=128'h54776f204f6e65204e696e652054776f;  
datain=128'h48656c6c6f20576f726c642120202020;  

#10;
$display("0x%0h",datain);
$display("0x%0h",dataout);

end
endmodule

