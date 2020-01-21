`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Jonathan Pilling
//
// Create Date:    12:41 09/11/2018
// Design Name:
// Module Name:   tb_alu_cc 
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

module tb_alu_cc;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg signed [15:0] Asigned;
	reg signed [15:0] Bsigned;
	reg [15:0] inst;
	reg Cin; //Added Carry in bit

	// Outputs
	wire [15:0] C;
	wire [4:0] Flags;

	integer i;
	// Instantiate the Unit Under Test (UUT)
	_3710alu uut (
		.A(A), 
		.B(B), 
		.C(C),
		.inst(inst),
		.Cin(Cin), 
		.Flags(Flags)
	);

	initial begin
//			$monitor("A: %0d, B: %0d, C: %0d, Flags[1:0]:%b, time:%0d", A, B, C, Flags[1:0], $time );

//Instead of the $display stmt in the loop, you could use just this
//monitor statement which is executed everytime there is an event on any
//signal in the argument list.

		// Initialize Inputs
		A = 0;
		B = 0;
		inst = 0;
		Cin = 0;

		// Wait 100 ns for global reset to finish
/*****
		// One vector-by-vector case simulation
		#10;
	        Opcode = 2'b11;
		A = 4'b0010; B = 4'b0011;
		#10
		A = 4'b1111; B = 4'b 1110;
		//$display("A: %b, B: %b, C:%b, Flags[1:0]: %b, time:%d", A, B, C, Flags[1:0], $time);
****/
		
					// Add stimulus here
					//Written by Jonathan P

							/*ADD OP CODE*/
					#10; 
					inst[15:12] = 4'b0000; inst[7:4]=4'b0101; //Adding two positive numbers
					A = 16'd122; B=16'd100;
					#10
					$display("ADD:");
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10;
					A = -16'd500; B=16'd100; //Adding one pos, one neg
					#10
					$display("A: %b, B: %d, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = -16'd122; B=-16'd100; //Adding two neg
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*ADDI OP CODE*/
					#10; 
					//Opcode = 8'b0101_xxxx;
					inst[15:12] = 4'b0101; inst[7:4]=4'bxxxx;
					
					
					A = 16'd50; inst[7:0] = 8'd122; //Adding two positive numbers
					#10
					$display("ADDI:");
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10;
					A = -16'd500; inst[7:0] = 8'd100; //Adding one pos, one neg
					#10
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10
					A = -16'd122; inst[7:0] = -8'd122; //Adding two neg
					#10
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);

					
					/*ADDU OPCODE*/
					#10; 
					//Opcode = 8'b0000_0110; //Add unsigned so we don't want to have negative numbers
					inst[15:12] = 4'b0000; inst[7:4]=4'b0110;
					A = 16'd122; B=16'd100;
					#10
					$display("ADDU:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10;
					A = -16'd43; B=16'd100; //Adding one pos, one neg
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = -16'd180; B=-16'd180; //Adding two neg
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*ADDUI OPCODE*/
					#10; 
					//Opcode = 8'b0110_xxxx; //ADDU so we don't want to have negative numbers
					
					inst[15:12] = 4'b0110; inst[7:4]=4'bxxxx;
					A = 16'd1001; inst[7:0] = 8'd122;
					#10
					$display("ADDUI:");
					$display("A: %d, Imm: %d, C:%d, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10;
					A = -16'd500; inst[7:0] = 8'd122; //Adding one pos, one neg
					#10
					$display("A: %d, Imm: %d, C:%d, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10
					A = -16'd122; inst[7:0] = 8'd122; //Adding two neg
					#10
					$display("A: %d, Imm: %d, C:%d, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);

					
					/*ADDC OP CODE*/
					#10; 
					//Opcode = 8'b0000_0111;
					inst[15:12] = 4'b0000; inst[7:4]=4'b0111;
					A = 16'b1000_0000_0000_0000; B=16'b1000_0000_0000_0000;
					#10
					$display("ADDC:");
					$display("CarryIn: %b", Cin);
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd1001; B=16'd1001;
					#10
					$display("ADDUI:");
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10;
					A = -16'd500; B=16'd100; //Adding one pos, one neg
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = -16'd122; B=-16'd100; //Adding two neg
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					

					
					/*ADDCU OP CODE*/
					#10; 
					//Opcode = 8'b0000_0100;
					inst[15:12] = 4'b0000; inst[7:4]=4'b0100;
					A = 16'b1000_0000_0000_0000; B=16'b1000_0000_0000_0000;
					#10
					$display("ADDCU:");
					$display("CarryIn: %b", Cin);
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					A = 16'd1001; B=16'd1001;
					#10
					$display("ADDCU:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10;
					A = -16'd500; B=16'd100; //Adding one pos, one neg
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = -16'd122; B=-16'd100; //Adding two neg
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*ADDCUI OP CODE*/
					#10; 
					//Opcode = 8'b0000_1000; 
					inst[15:12] = 4'b0000; inst[7:4]=4'b1000;
					A = 16'b1000_0000_0000_0000; B=16'b1000_0000_0000_0000;
					#10
					$display("ADDCUI:");
					$display("CarryIn: %b", Cin);
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					A = 16'd1001; B=16'd1001;
					#10
					$display("ADDCUI:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10;
					A = -16'd500; B=16'd100; //Adding one pos, one neg
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = -16'd122; B=-16'd100; //Adding two neg
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*ADDCI OP CODE*/
					#10; 
					//Opcode = 8'b0111_xxxx;
					inst[15:12] = 4'b0111; inst[7:4]=4'bxxxx;
					A = 16'b1000_0000_0000_0000; inst[7:0] = 8'b1000_0000;
					#10
					$display("ADDCI:");
					$display("CarryIn: %b", Cin);
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					A = 16'd1001; inst[7:0]=8'd1001;
					#10
					$display("ADDCI:");
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10;
					A = -16'd500; inst[7:0]=8'd100; //Adding one pos, one neg
					#10
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10
					A = -16'd122; inst[7:0]=-8'd100; //Adding two neg
					#10
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);

					
					/*SUB OP CODE*/
					#10; 
					//Opcode = 8'b0000_1001;
					inst[15:12] = 4'b0000; inst[7:4]=4'b1001;
					A = 16'd122; B=16'd100; //Sub two pos, result is pos
					#10
					$display("SUB:");
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10;
					A = 16'd500; B= -16'd50; //Subbing negative number from pos
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd50; B=16'd100; //Sub two pos numbers, result is neg
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = -16'd122; B=-16'd100; //Subbing two neg
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*SUBI OPCODE*/
					#10; 
					//Opcode = 8'b1001_xxxx;
					inst[15:12] = 4'b1001; inst[7:4]=4'bxxxx;
					A = 16'd122; inst[7:0] = 8'd122; //Sub two positive #'s, result is pos
					#10
					$display("SUBI:");
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10;
					A = 16'd500; inst[7:0]= -8'd50; //Subbing negative number from pos
					#10
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10
					A = 16'd50; inst[7:0]=8'd100; //Sub two pos numbers, result is neg
					#10
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);
					#10
					A = -16'd122; inst[7:0]=-8'd100; //Subbing two neg
					#10
					$display("A: %b, Imm: %b, C:%b, Flags[4:0]: %b, time: %d", A, inst[7:0], C, Flags[4:0], $time);

					
					/*CMP OPCODE*/
					#10; 
					//Opcode = 8'b0000_1011;
					inst[15:12] = 4'b0000; inst[7:4]=4'b1011;
					A = 16'd1; B=-16'd2; //Comparing one pos, one neg
					#10
					$display("CMP:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd122; B=16'd100; //Comparing two pos
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd100; B=16'd122; //Comparing two pos, registers switched
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd50; B=16'd50; //Comparing two pos, equal result
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = -16'd45; B=-16'd45; //Comparing two neg, equal result
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10

					
					/*AND OP CODE*/
					#10; 
					//Opcode = 8'b0000_0001;
					inst[15:12] = 4'b0000; inst[7:4]=4'b0001;
					A = 16'b1001001; B=16'b1001001; //Testing equal ANDs
					#10
					$display("AND:");
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10; 
					A = 16'b101; B=16'b010; //result should be 0, no ANDS
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10; 
					A = 16'b1100_1110_0110_1011; B=16'b1011_0101_0101_0010; //long AND
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10; 
					A = 16'b1; B=16'b1; //short AND
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*OR OP CODE*/
					#10; 
					//Opcode = 8'b0000_0010;
					inst[15:12] = 4'b0000; inst[7:4]=4'b0010;
					A = 16'b101; B=16'b010; //oppositte OR
					#10
					$display("OR:");
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10; 
					A = 16'b1011; B=16'b1011; //equivalent OR
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10; 
					A = 16'b1001_0110_1101_0110; B=16'b1001_0010_0101_1011; //long OR
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					

					/*XOR OP CODE*/
					#10; 
					//Opcode = 8'b0000_0011;
					inst[15:12] = 4'b0000; inst[7:4]=4'b0011;
					A = 16'b101; B=16'b010; //oppositte XOR
					#10
					$display("XOR:");
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10; 
					A = 16'b1011; B=16'b1011; //equivalent XOR
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10; 
					A = 16'b1001_0110_1101_0110; B=16'b1001_0010_0101_1011; //long XOR
					#10
					$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*NOT OPCODE ??NOT sure about this on ??*/
					#10; 
					//Opcode = 8'b0000_1111;
					inst[15:12] = 4'b0000; inst[7:4]=4'b1111;
					A = 16'd122; B=16'd100;
					#10
					$display("NOT:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					/*LSH OP CODE*/
					#10; 
					//Opcode = 8'b1000_0100; 
					inst[15:12] = 4'b1000; inst[7:4]=4'b0100;
					A = 16'b1; B=16'b0111001;
					#10
					$display("LSH:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					A = 16'b111; B=16'b0000_00001;
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);

					
					/*RSH OP CODE*/
					#10; 
					//Opcode = 8'b1000_1111; 
					inst[15:12] = 4'b1000; inst[7:4]=4'b1111;
					A = 16'b1; B=16'd100;
					#10
					$display("RSH:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd7; B = 16'b1000_0000;
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd5; B = 16'b1000_0000;
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					#10
					A = 16'd3; B = 16'b1000_0000;
					#10
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
					
					
					/*NO OP/WAIT OP CODE*/ 
					#10; 
					//Opcode = 8'b0000_0000;
					inst[15:12] = 4'b0000; inst[7:4]=4'b0000;
					A = 16'd122; B=16'd100;
					#10
					$display("NOP/WAIT:");
					$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
				end

endmodule
