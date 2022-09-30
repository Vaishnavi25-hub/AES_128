
module rounds(clk,rc,data,keyin,keyout,rndout);
input clk;
input [3:0]rc;
input [127:0]data;
input [127:0]keyin;
output [127:0]keyout;
output [127:0]rndout;

wire [127:0] sb,sr,mcl;

KeyGeneration t0(clk,rc,keyin,keyout);
shift_rows_inv t2(data,sb);
subbytes t1(clk,sb,sr);
assign mcl= keyout^sr;

mixcolumn_inv t3(mcl,rndout);
//assign rndout= keyout^mcl;
//mixcolumn_inv t3(rndout,mcl);
endmodule
