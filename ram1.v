module ram1(clk, address,data, wren,rden,dataout);
  
  parameter D_WIDTH = 128;
  parameter A_WIDTH = 4;
  parameter A_MAX = 16; // 2^A_WIDTH

  // Write port
  input                clk;
  input  [A_WIDTH-1:0] address;
  input  [D_WIDTH-1:0] data;
  input                wren;
  input                rden;

  // Read port
  output [D_WIDTH-1:0] dataout;
  
  reg    [D_WIDTH-1:0] dataout;
  
  // Memory as multi-dimensional array
  reg [D_WIDTH-1:0] memory [A_MAX-1:0];

  // Write data to memory
  always @(posedge clk) begin
    if (wren) begin
      memory[address] <= data;
    end
  end

  // Read data from memory
  always @(posedge clk) begin
  if (rden) begin
    dataout <= memory[address];
	 end
  end

endmodule