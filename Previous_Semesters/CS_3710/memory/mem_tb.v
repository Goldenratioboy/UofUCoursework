//timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Jeremy Wu
//
// Create Date:    12:41 09/27/2018
// Design Name:
// Module Name:    mem_tb
// Project Name:
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

/*Wrapper Testbench for the Memory*/
`timescale 1ns/1ps
module Mem_tb(
	 );

	 //Inputs
	 reg clk, reset;
	 reg we_a, we_b;
	 reg [15:0] addr_a, addr_b, data_a, data_b, q_a, q_b;
 
	 // Outputs
	 wire [15:0] bus_output;
	integer i;

/*Instatiate the Unit Under Test (UUT)*/
	 memory m(
		.clk(clk)
		.we_a(we_a)
		.we_b(we_b)
		.addr_a(addr_a),
		.addr_b(addr_b),
		.adat_a(data_a),
		.data_b(data_b),
		.q_a(q_a),
		.q_b(q_b)
	 );

	 
	 
	 initial begin

	 //Initiatlize inputs
	 clk = 0;
	 reset = 0;
	 #20 reset = 1;
	 #10 reset = 0;
	 addr_a = 0;
	 addr_b = 0;
	 data_a = 0;
	 data_b = 0;
	 q_a = 0;
	 q_b = 0;
	 we_a = 0;
	 we_b = 0;

	 end
	 
	 always 
	 begin
		#5 clk = !clk;
	 end
		
		initial begin		
		/*More Stimulus*/
		#100
		
		$display("q_a in beginning: %b", q_a);
		$display("q_b in beginning: %b", q_b);	


		#5		
		
		we_a = 1;
		addr_a = 10'b0000000001;
		data_a = 16'b0000000000000001;
		
		#10 // Wait inbetween instructions
		$display("q_a should be 1: %b", q_a);	
		we_a = 0;

		#10

		we_b = 1;
		addr_b = 10'b0000000010;

		#10
		$display("q_b should be 2: %b", q_b);	
		we_b = 0;

		#10

		we_a = 1;
		we_b = 1;
		addr_a = 10'b0000000001;
		data_a = 16'b0000000000000011;
		addr_b = 10'b0000000010;
		data_b = 16'b0000000000000011;

		#10
		$display("q_a should be 3: %b", q_a);	
		$display("q_b should be 3: %b", q_b);	
		we_a = 0;
		we_b = 0;

		#10

		we_a = 1;
		we_b = 1;
		addr_a = 10'b0000000001;
		data_a = 16'b0000000000000100;
		addr_b = 10'b0000000001;
		data_b = 16'b0000000000000100;

		#10
		$display("q_a should be 4: %b", q_a);	
		$display("q_b should be 4: %b", q_b);	
		$finish;
		end

endmodule
