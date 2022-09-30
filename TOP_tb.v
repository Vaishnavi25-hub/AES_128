module TOP_tb;
reg clk;
reg [7:0]datain;
//reg [127:0]key;
wire [7:0]dataout;
//wire [127:0]keyout;


//aescipher a3(.clk(clk),.datain(datain),.key(key),.dataout(dataout),.keyout(keyout));
sbox a1(.clk(clk),.i_Seed_Data(datain),.ans(dataout));
always #10 clk=~clk;
initial
begin
clk<=1;
#10;
//key=128'h28fddef86da4244accc0a4fe3b316f26;
//datain=128'h2bbcde4e3637df929bbd44d6a61b8294;
datain <= 8'h00;
#10;

end
endmodule

