module sbox(input clk,input [7:0] i_Seed_Data,output [7:0]ans);
wire [7:0] o_LFSR_Data;
wire o_LFSR_Done_r;
wire o_LFSR_Done_f;
reg [8:1] r_LFSR_r = 8'b00000001;
reg [8:1] r_LFSR_f = 8'b00000001;
wire [7:0]a[7:0] ;
wire [7:0]b[7:0] ;
wire [7:0]c[7:0] ;
wire [7:0]data;

assign c[7] = i_Seed_Data & 8'h80;
assign c[6] = i_Seed_Data & 8'hc0; 
assign c[5] = i_Seed_Data & 8'ha0; 
assign c[4] = i_Seed_Data & 8'hf0; 
assign c[3] = i_Seed_Data & 8'h88; 
assign c[2] = i_Seed_Data & 8'hcc; 
assign c[1] = i_Seed_Data & 8'haa; 
assign c[0] = i_Seed_Data & 8'hff;

assign data[0] = c[0][0]^c[0][1]^c[0][2]^c[0][3]^c[0][4]^c[0][5]^c[0][6]^c[0][7]; 
assign data[1] = c[1][0]^c[1][1]^c[1][2]^c[1][3]^c[1][4]^c[1][5]^c[1][6]^c[1][7]; 
assign data[2] = c[2][0]^c[2][1]^c[2][2]^c[2][3]^c[2][4]^c[2][5]^c[2][6]^c[2][7]; 
assign data[3] = c[3][0]^c[3][1]^c[3][2]^c[3][3]^c[3][4]^c[3][5]^c[3][6]^c[3][7]; 
assign data[4] = c[4][0]^c[4][1]^c[4][2]^c[4][3]^c[4][4]^c[4][5]^c[4][6]^c[4][7]; 
assign data[5] = c[5][0]^c[5][1]^c[5][2]^c[5][3]^c[5][4]^c[5][5]^c[5][6]^c[5][7]; 
assign data[6] = c[6][0]^c[6][1]^c[6][2]^c[6][3]^c[6][4]^c[6][5]^c[6][6]^c[6][7]; 
assign data[7] = c[7][0]^c[7][1]^c[7][2]^c[7][3]^c[7][4]^c[7][5]^c[7][6]^c[7][7]; 

always @(posedge clk)
begin
if (o_LFSR_Done_f == 1'b0 && o_LFSR_Done_r == 1'b0)
begin
r_LFSR_f <= {r_LFSR_f[7],r_LFSR_f[6],r_LFSR_f[5],r_LFSR_f[4]^r_LFSR_f[8],r_LFSR_f[3]^r_LFSR_f[8],r_LFSR_f[2]^r_LFSR_f[8],r_LFSR_f[1],r_LFSR_f[8]};
r_LFSR_r <= {r_LFSR_r[1],r_LFSR_r[8],r_LFSR_r[7],r_LFSR_r[6],r_LFSR_r[5]^r_LFSR_r[1],r_LFSR_r[4]^r_LFSR_r[1],r_LFSR_r[3]^r_LFSR_r[1],r_LFSR_r[2]};
end
end

assign o_LFSR_Data = (o_LFSR_Done_r == 1'b1) ? r_LFSR_f[8:1]: ((o_LFSR_Done_f == 1'b1)?r_LFSR_r[8:1] : 0);

assign o_LFSR_Done_f = (r_LFSR_f[8:1] == data) ? 1'b1 : 1'b0;

assign o_LFSR_Done_r = (r_LFSR_r[8:1] == data) ? 1'b1 : 1'b0;

assign b[7] = (8'h98 & o_LFSR_Data);
assign b[6] = (8'hd4 & o_LFSR_Data);
assign b[5] = (8'hbe & o_LFSR_Data);
assign b[4] = (8'he1 & o_LFSR_Data);
assign b[3] = (8'h91 & o_LFSR_Data);
assign b[2] = (8'hd9 & o_LFSR_Data);
assign b[1] = (8'hb5 & o_LFSR_Data);
assign b[0] = (8'hef & o_LFSR_Data);

assign ans[7] = b[7][0]^b[7][1]^b[7][2]^b[7][3]^b[7][4]^b[7][5]^b[7][6]^b[7][7]^1'b0;
assign ans[6] = b[6][0]^b[6][1]^b[6][2]^b[6][3]^b[6][4]^b[6][5]^b[6][6]^b[6][7]^1'b1; 
assign ans[5] = b[5][0]^b[5][1]^b[5][2]^b[5][3]^b[5][4]^b[5][5]^b[5][6]^b[5][7]^1'b1; 
assign ans[4] = b[4][0]^b[4][1]^b[4][2]^b[4][3]^b[4][4]^b[4][5]^b[4][6]^b[4][7]^1'b0; 
assign ans[3] = b[3][0]^b[3][1]^b[3][2]^b[3][3]^b[3][4]^b[3][5]^b[3][6]^b[3][7]^1'b0; 
assign ans[2] = b[2][0]^b[2][1]^b[2][2]^b[2][3]^b[2][4]^b[2][5]^b[2][6]^b[2][7]^1'b0; 
assign ans[1] = b[1][0]^b[1][1]^b[1][2]^b[1][3]^b[1][4]^b[1][5]^b[1][6]^b[1][7]^1'b1; 
assign ans[0] = b[0][0]^b[0][1]^b[0][2]^b[0][3]^b[0][4]^b[0][5]^b[0][6]^b[0][7]^1'b1; 
//ans=2a
 
endmodule