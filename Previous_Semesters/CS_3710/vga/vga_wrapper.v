module vga_wrapper (clk, reset, hSync, vSync, red, blue, green, slow_clock, bright, addie, indata);

input clk, reset;

output hSync, vSync, slow_clock;
output [7:0] red, green, blue;

wire [9:0] hCount, vCount;
inout bright;

output reg [15:0] addie = 16'b0000_0000_0000_1010;
input wire [7:0] indata;

wire [7:0] key = indata[7:0];

vga_640by480 vga_ctrl (
	.CLK(clk),
	.clr(reset),
	.hsync(hSync),
	.vsync(vSync),
	.PixelX(hCount),
	.PixelY(vCount),
	.vidon(bright),
	.slw_clk(slow_clock)
);

bitgen_piano vga_bitgen (
	.hCount(hCount),
	.vCount(vCount),
	.bright(bright),
	.red(red),
	.green(green),
	.blue(blue),
	.key(key)
);

endmodule