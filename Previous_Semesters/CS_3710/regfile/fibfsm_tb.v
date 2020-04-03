`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Stephan Stankovic
// 
// Create Date:    15:24:24 09/18/2015 
// Design Name: 
// Module Name:    fibfsm_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Module and verilog file for instantiating a Fibonacci finite state machine simulation
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fibfsm_tb ();

reg clk, reset;

wire [6:0] out0, out1, out2, out3;

fibfsm fsm(
	.clk(clk),
	.reset(reset),
	.out0(out0),
	.out1(out1),
	.out2(out2),
	.out3(out3));
	
	initial
	begin
		clk = 0;
		reset = 0;
		
		#10
		reset = 1;
		
		#10
		reset = 0;
		
	end
	
	always 
	 begin
		#5 clk = !clk;
	 end
	 
endmodule