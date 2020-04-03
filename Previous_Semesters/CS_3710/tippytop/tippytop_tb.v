`timescale 1ns / 1ps
module tippytop_tb ();
	reg clk, reset;
	reg [15:0] note = 16'h1C;
	reg [15:0] addie = 16'b0000_0000_0000_1010;
	wire [15:0] indata;
	
	cpuDatapath pathTest(
		.clk(clk),
		.reset(reset),
		.uart(note),
		.addr_b(addie),
		.q_b(indata)
	);
	
	initial begin
		clk = 1;
		reset = 1;
		#20
		reset = 0;
	end
	
	always
		#5 clk = !clk;


endmodule	