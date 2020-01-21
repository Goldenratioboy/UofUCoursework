`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Jonathan Pilling, Steen Sia
//
// Create Date:    12:41 11/13/2018
// Design Name:
// Module Name:    cpu_tb
// Project Name:   cpuDatapath
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module cpu_tb();

	//Inputs
	reg clk, reset;
		
	//Instatiate the UUT
	cpuDatapath uut(
		.clk(clk),
		.reset(reset)
	);

initial 
	begin
		clk = 1;
		reset = 1;
		#20
		reset = 0;
		#200
		$finish;
	end

always@ (*)
		#5 clk <= ~clk;

endmodule
