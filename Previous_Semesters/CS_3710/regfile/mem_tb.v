/*Wrapper Testbench for the Memory*/
`timescale 1ns/1ps
module Mem_tb(
	 );

	 //Inputs
	 reg clk, reset;
	 reg we_a, we_b, clk_a, clk_b;
	 reg [15:0] addr_a, addr_b, data_a, data_b, q_a, q_b;
 
	 // Outputs
	 wire [15:0] bus_output;
	integer i;

/*Instatiate the Unit Under Test (UUT)*/
	 memory m(
		.clk_a(clk)
		.clk_b(clk)
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
		
		$display("Number at addr 0: %b", );
		#5		
		
		we_a = 1;
		addr_a = 10'b0000000001;
		data_a = 16'b0000000000000001;
	
		#10 // Wait inbetween instructions
		
		we_a = 0;

		#10

		we_b = 1;
		addr_b = 10'b0000000010;

		#10

		we_b = 0;

		#10

		we_a = 1;
		we_b = 1;



		$finish;
		end

endmodule