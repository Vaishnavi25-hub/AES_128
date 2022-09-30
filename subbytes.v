
module subbytes(clk,data,sb);

input clk;
input [127:0] data;
output [127:0] sb;

     sbox_inv q0( .clk(clk),.i_Seed_Data(data[127:120]),.ans(sb[127:120]) );
     sbox_inv q1( .clk(clk),.i_Seed_Data(data[119:112]),.ans(sb[119:112]) );
     sbox_inv q2( .clk(clk),.i_Seed_Data(data[111:104]),.ans(sb[111:104]) );
     sbox_inv q3( .clk(clk),.i_Seed_Data(data[103:96]),.ans(sb[103:96]) );
     
     sbox_inv q4( .clk(clk),.i_Seed_Data(data[95:88]),.ans(sb[95:88]) );
     sbox_inv q5( .clk(clk),.i_Seed_Data(data[87:80]),.ans(sb[87:80]) );
     sbox_inv q6( .clk(clk),.i_Seed_Data(data[79:72]),.ans(sb[79:72]) );
     sbox_inv q7( .clk(clk),.i_Seed_Data(data[71:64]),.ans(sb[71:64]) );
     
     sbox_inv q8( .clk(clk),.i_Seed_Data(data[63:56]),.ans(sb[63:56]) );
     sbox_inv q9( .clk(clk),.i_Seed_Data(data[55:48]),.ans(sb[55:48]) );
     sbox_inv q10(.clk(clk),.i_Seed_Data(data[47:40]),.ans(sb[47:40]) );
     sbox_inv q11(.clk(clk),.i_Seed_Data(data[39:32]),.ans(sb[39:32]) );
     
     sbox_inv q12(.clk(clk),.i_Seed_Data(data[31:24]),.ans(sb[31:24]) );
     sbox_inv q13(.clk(clk),.i_Seed_Data(data[23:16]),.ans(sb[23:16]) );
     sbox_inv q14(.clk(clk),.i_Seed_Data(data[15:8]),.ans(sb[15:8]) );
     sbox_inv q16(.clk(clk),.i_Seed_Data(data[7:0]),.ans(sb[7:0]) );
	
endmodule
