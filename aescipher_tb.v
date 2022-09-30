module aescipher_tb;
reg clk;
reg [127:0]datain;
reg [127:0]key;
wire [127:0]dataout;

aescipher a1(.clk(clk),.datain(datain),.key(key),.dataout(dataout));

always #10 clk=~clk;
initial
begin
clk<=1;
#10;
key=128'h28fddef86da4244accc0a4fe3b316f26;
datain=128'h2bbcde4e3637df929bbd44d6a61b8294;
#10;

end
endmodule

