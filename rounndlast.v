//`timescale 1ns / 1ps

module rounndlast(clk,rc,rin,keylastin,fout,keyout);
input clk;
input [3:0]rc;
input [127:0]rin;
input [127:0]keylastin;
output [127:0]fout;
output [127:0]keyout;

wire [127:0] sb,sr,mcl,keyout;

KeyGeneration t0(clk,rc,keylastin,keyout);
subbytes t1(clk,rin,sb);
shiftrow t2(sb,sr);
assign fout= keyout^sr;

endmodule
