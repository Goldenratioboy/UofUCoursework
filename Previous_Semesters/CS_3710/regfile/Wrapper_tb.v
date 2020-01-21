/*Wrapper Testbench for the CPU ALU Datapath*/
`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jonathan Pilling & Steen Sia
// 
// Create Date:    15:24:24 09/18/2015 
// Design Name: 
// Module Name:    Wrapper_tb 
// Project Name:   regfile
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
module Wrapper_tb();

	 //Inputs
	 reg clk, reset, Cin;
	 reg [15:0] regEnable, inst;
	 reg [3:0] ctrlA, ctrlB;
	 //reg [7:0] opcode;

	 // Outputs
	 wire [15:0] bus_output;
	 wire [4:0] flags_output;
	integer i;

/*Instatiate the Unit Under Test (UUT)*/
	 cpu_alu_datapath uut(
		  .clk(clk),
		  .regEnable(regEnable),
		  .reset(reset),
		  .ctrlA(ctrlA),
		  .ctrlB(ctrlB),
		  .Cin(Cin),
		  .inst(inst),
		  .bus_output(bus_output),
		  .flags_output(flags_output)
	 );

	 
	 
	 initial begin

	 //Initiatlize inputs
	 clk = 0;
	 Cin = 0;
	 reset = 0;
	 #20 reset =1;
	 #10 reset =0;
	 regEnable = 0;
	 inst = 0;
	 ctrlA = 0;
	 ctrlB = 0;
	 //opcode = 0;

	 end
	 
	 always 
	 begin
		#5 clk = !clk;
	 end
		
		initial begin		
		/*More Stimulus*/
		#100
		/*Allow the registers to be written to*/
		regEnable[0] = 1'b1;
		
		// Testing reg 0 & 1
		//ADDI Instruction
		inst[15:0] = 16'b0101_0000_0000_0010;
		ctrlA = 4'b0000;		
		
		$display("Output before #5: %b", bus_output);
		#5		
		$display("Output: %b", bus_output);
		
		regEnable[0] = 1'b0;
		regEnable[1] = 1'b1;
	
		#10 // Wait inbetween instructions
		
		// ADD Instruction
		inst[15:0] = 16'b0000_0000_0101_0000;

		ctrlA = 4'b0000;
		ctrlB = 4'b0001; // Allows regs r0 and r1 to be passed into the ALU

		//Hopefully value will be written into r1.
		#5	
		$display("Output: %b", bus_output);	
		
		// OR Instruction
		inst[15:0] = 16'b0000_0000_0010_0000;

		ctrlA = 4'b0000;
		ctrlB = 4'b0001; // Allows regs r0 and r1 to be passed into the ALU
		
		#5	
		$display("Output: %b", bus_output);	
		
		// Testing reg 2 & 3
		// ADDI Instruction reg2 = 4
		inst[15:0] = 16'b0101_0000_0000_0100;
		ctrlA = 4'b0010;	
		#5
		
		// ADDI Instruction reg3 = 5;
		inst[15:0] = 16'b0101_0000_0000_0100;
		ctrlA = 4'b0011;	
		#5	
		

		$finish;
		end

endmodule