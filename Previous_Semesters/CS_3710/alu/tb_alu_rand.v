`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Steen Sia 
//
// Create Date:    12:41 09/11/2018
// Design Name:
// Module Name:   tb_alu_rand 
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

module tb_alu_rand;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] inst;
	reg Cin;

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
	
//$monitor("A: %0d, B: %0d, C: %0d, Flags[1:0]: %b, time:%0d", A, B, C, Flags[1:0], $time );
//Instead of the $display stmt in the loop, you could use just this
//monitor statement which is executed everytime there is an event on any
//signal in the argument list.

		// Initialize Inputs
		A = 16'b0000_0000_0000_0000;
		B = 16'b0000_0000_0000_0000;
		inst = 16'b0000_0000_0000_0000;
		Cin = 1'b0;

		// Wait 100 ns for global reset to finish
		
/****
		// One vector-by-vector case simulation
		
	        Opcode = 2'b11;
		A = 4'b0010; B = 4'b0011;
		
		A = 4'b1111; B = 4'b 1110;
		//$display("A: %b, B: %b, C:%b, Flags[1:0]: %b, time:%d", A, B, C, Flags[1:0], $time);
****/

/****
		//Random simulation
		for( i = 0; i< 10; i = i+ 1)
		begin
			
			A = $random % 16;
			B = $random % 16;
			$display("A: %0d, B: %0d, C: %0d, Flags[1:0]: %b, time:%0d", A, B, C, Flags[1:0], $time );
		end
		//$finish(2);
****/
		
			//Random Simulations for All OpCodes

// Non-Immediate Test Simulations		
			// ADD OPCODE
			inst[15:12] = 4'b0000; inst[7:4] = 4'b0101; 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("ADD:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
				#10;
			end
	
			// ADDU OPCODE 
			inst[15:12] = 4'b0000; inst[7:4] = 4'b0110; 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("ADDU:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
			// ADDC OPCODE
			inst[15:12] = 4'b0000; inst[7:4] = 4'b0111; 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				Cin = 1'b1;
				#25
				$display("ADDC:");
				$display("A: %b, B: %b, Cin: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, Cin, C, Flags[4:0], $time);
			end
			
			// ADDCU OPCODE
			inst[15:12] = 4'b0000; inst[7:4] = 4'b0100; // unused opcode 1
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				Cin = 1'b1;
				#25
				$display("ADDCU:");
				$display("A: %d, B: %d, Cin: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, Cin, C, Flags[4:0], $time);
			end
						
			// SUB OPCODE 
			inst[15:12] = 4'b0000; inst[7:4] = 4'b1001; 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("SUB:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
						
			// CMP OPCODE
			inst[15:12] = 4'b0000; inst[7:4] = 4'b1011; 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("CMP:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
						
			// AND OPCODE
			inst[15:12] = 4'b0000; inst[7:4] = 4'b0001; 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("AND:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end			
			
			// OR OPCODE			 
			inst[15:12] = 4'b0000; inst[7:4] = 4'b0010; 
			for( i = 0; i < 10; i = i + 1)
			begin
				
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("OR:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
					
			// XOR OPCODE			 
			inst[15:12] = 4'b0000; inst[7:4] = 4'b0011; 
			for( i = 0; i < 10; i = i + 1)
			begin			
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("XOR:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
					
			// NOT OPCODE			 
			inst[15:12] = 4'b0000; inst[7:4] = 4'b1111; // unused opcode 4
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = 16'b0;
				//B = $random % 1024;
				#25
				$display("NOT:");
				$display("A: %b, C:%b, Flags[4:0]: %b, time: %d", A, C, Flags[4:0], $time);
				//$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
			// LSH OPCODE			 
			inst[15:12] = 4'b1000; inst[7:4] = 4'b0100; 
			for( i = 0; i < 10; i = i + 1)
			begin			
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("LSH:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
						
			// RSH OPCODE			 
			inst[15:12] = 4'b1000; inst[7:4] = 4'b1111; // unused opcode 5
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				B = $random % 1024;
				#25
				$display("RSH:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			

 // Immediate Tests
		
			// ADDI OPCODE		
			inst[15:12] = 4'b0101; inst[7:4] = 4'bxxxx; 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("ADDI:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
				
			// ADDUI OPCODE			
			inst[15:12] = 4'b0110; inst[7:4] = 4'bxxxx; 
			for( i = 0; i < 10; i = i + 1)
			begin	
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("ADDUI:");
				$display("A: %d, B: %d, Cin: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, Cin, C, Flags[4:0], $time);
			end
	
			// ADDCUI OPCODE
			inst[15:12] = 4'b0000; inst[7:4] = 4'b1000; // unused opcode 2
			for( i = 0; i < 10; i = i + 1)
			begin		
				A = $random % 1024;
				inst[7:0] = $random % 256;
				Cin = 1'b1;
				#25
				$display("ADDCUI:");
				$display("A: %d, b: %d, Cin: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, Cin, C, Flags[4:0], $time);
			end
	
			// ADDCI OPCODE
			inst[15:12] = 4'b0111; inst[7:4] = 4'bxxxx;
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				Cin = 1'b1;
				#25
				$display("ADDCI:");
				$display("A: %b, B: %b, Cin: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, Cin, C, Flags[4:0], $time);
			end
			
				
			// SUBI OPCODE
			inst[15:12] = 4'b1001; inst[7:4] = 4'bxxxx;
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("SUBI:");
				$display("A: %b, B: %b, C:%b, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
	
/* WILL TEST THE FOLLOWING OPERATIONS LATER ON

			// CMPI OPCODE		
			Opcode = 8'b1011_xxxx;
			for( i = 0; i < 10; i = i + 1)
			begin			
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("CMPI:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
			
			// CMPU/I OPCODE		
			Opcode = 8'b0000_1100; // unused opcode 3
			for( i = 0; i < 10; i = i + 1)
			begin				
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("CMPU/I:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			

			// LSHI OPCODE POS		 
			Opcode = 8'b1000_0000; // unsure about the s at the end 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("LSHI:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			

			// LSHI OPCODE NEG		 
			Opcode = 8'b1000_0001; // unsure about the s at the end 
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("LSHI:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
			// RSHI OPCODE
			Opcode = 8'b1000_0101; // unused opcode 6
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("RSHI:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
	
			// ALSH OPCODE		 
			Opcode = 8'b1000_0111; // unused opcode 7
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("ALSH:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
	
			// ARSH OPCODE
			Opcode = 8'b1000_1xxx; // unused opcode 7
			for( i = 0; i < 10; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("ARSH:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
	
			// OP/WAIT OPCODE
			Opcode = 8'b0000_0000; 
			for( i = 0; i < 100; i = i + 1)
			begin
				A = $random % 1024;
				inst[7:0] = $random % 256;
				#25
				$display("NOP/WAIT:");
				$display("A: %d, B: %d, C:%d, Flags[4:0]: %b, time: %d", A, B, C, Flags[4:0], $time);
			end
			
*/
	end


      
endmodule
