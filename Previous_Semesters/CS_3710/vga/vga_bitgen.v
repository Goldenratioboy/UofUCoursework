module vga_bitgen(bright,
	hCount, vCount,
	red, green, blue);
inout bright;
//input [7:0] pixelData;
input [9:0] hCount, vCount;
output reg[7:0] red;
output reg[7:0] green;
output reg[7:0] blue;

parameter BLACK = 8'b00000000;
parameter WHITE = 8'b11111111;
parameter RED = 8'b11100000;
parameter GREEN = 8'b00011100;
parameter BLUE = 8'b00000000;

always@(*)
begin
//This will paint a white box with a red background
  if(~bright) 
  begin
	red  = 8'b0;
	green = 8'b0;
	blue = 8'b0;
  end
//  else if ((hCount >= 100 && hCount <= 300) && (vCount >= 150 && vCount <= 350))
//  begin
//	red = WHITE;
//	green = WHITE;
//	blue = WHITE;
//  end
  else
  begin
	red = 8'b11111111;
	green = 8'b00000000;
	blue = 8'b00000000;
  end

end

endmodule
