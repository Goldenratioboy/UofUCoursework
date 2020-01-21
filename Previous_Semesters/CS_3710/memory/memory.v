//timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Stephan Stankovic
//
// Create Date:    12:41 09/27/2018
// Design Name:
// Module Name:    memory
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

// Quartus Prime Verilog Template
// True Dual Port RAM with dual clocks
module memory// true_dual_port_ram_single_clock
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16)
(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	initial 
	begin
		$readmemb("finalAssignment.txt", ram);
	end
//	
//	always @ (posedge clk)
//	begin
//		if (we_a && we_b)
//			begin
//				if (addr_a == addr_b)
//					begin
//						ram[addr_a] <= data_a;
//						q_a <= data_a;
//					end
//				else
//					begin
//						ram[addr_a] <= data_a;
//						ram[addr_b] <= data_b;
//						q_a <= data_a;
//						q_b <= data_b;
//					end
//			end
//		else if (we_a)
//			begin
//				ram[addr_a] <= data_a;
//				q_a <= data_a;
//			end
//		else if (we_b)
//			begin
//				ram[addr_b] <= data_b;
//				q_b <= data_b;
//			end
//		else 
//		begin
//			q_a <= ram[addr_a];
//			q_b <= ram[addr_b];
//		end 
//	end


	// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] <= data_a;
			q_a <= data_a;
		end
		else 
		begin
			q_a <= ram[addr_a];
		end 
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[addr_b] <= data_b;
			q_b <= data_b;
		end
		else 
		begin
			q_b <= ram[addr_b];
		end 
	end



endmodule




