`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Stephan Stankovic
// 
// Create Date:    15:24:24 09/27/2018
// Design Name: 
// Module Name:    memory_fsm 
// Project Name:   memory
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
module memory_fsm(clk, reset, out0, out1, out2, out3, out4, out5);

input clk, reset;

output wire [6:0] out0, out1, out2, out3, out4, out5;

reg we_a, we_b;
reg [15:0] data_a, data_b;
reg [9:0] addr_a, addr_b;
reg [2:0] state;

wire [15:0] q_a, q_b;

parameter resets = 3'b000;
parameter first = 3'b001;
parameter second = 3'b010;
parameter third = 3'b011;
parameter fourth = 3'b100;

memory m(
	.clk(clk),
	.we_a(we_a),
	.we_b(we_b),
	.addr_a(addr_a),
	.addr_b(addr_b),
	.data_a(data_a),
	.data_b(data_b),
	.q_a(q_a),
	.q_b(q_b)
);

always@ (posedge clk)
begin
	state <= resets;
	case(state)
		resets:
			if (reset)
				state <= resets;
			else
			begin
				state <= first;
			end
		first:
			if (reset)
				state <= resets;
			else
			begin
				state <= second;
			end
		second:
			if (reset)
				state <= resets;
			else
			begin
				state <= third;
			end
		third:
			if (reset)
				state <= resets;
			else
			begin
				state <= fourth;
			end
		fourth:
			if (reset)
				state <= resets;
			else
			begin
				state <= fourth;
			end
				
		default:
			state <= resets;
	endcase
	
end

always@ (state)
begin
	case(state)
		resets:
			begin
				we_a = 0;
				we_b = 0;
				addr_a = 10'b0;
				addr_b = 10'b0;
				data_a = 16'b0;
				data_b = 16'b0;
				
			end
			
		first:
			begin
				we_a = 1;
				we_b = 0;
				addr_a = 10'b0;
				addr_b = 10'b0;
				data_a = 16'b0000_0000_0000_0001;
				data_b = 16'b0;
				
			end
		
		second:
			begin
				we_a = 0;
				we_b = 1;
				addr_a = 10'b0;
				addr_b = 10'b00000_00001;
				data_a = 16'b0;
				data_b = 16'b0000_0000_0000_0010;
			
			end
		
		third:
			begin
				we_a = 1;
				we_b = 1;
				addr_a = 10'b00000_00000;
				addr_b = 10'b00000_00001;
				data_a = 16'b0000_0000_0000_0111;
				data_b = 16'b0000_0000_0000_1111;
			
			end
		
		fourth:
			begin
				we_a = 1;
				we_b = 1;
				addr_a = 10'b00000_00000;
				addr_b = 10'b00000_00000;
				data_a = 16'b0000_0000_0000_0001;
				data_b = 16'b0000_0000_0000_1111;
				
			end
		
		default:
			begin
				we_a = 0;
				we_b = 0;
				addr_a = 16'b0;
				addr_b = 16'b0;
				data_a = 16'b0;
				data_b = 16'b0;
				
			end
			
	endcase
end
	
// hexTo7Seg firstO(q_a[3:0],out0);
// hexTo7Seg secondO(q_a[7:4],out1);
// hexTo7Seg thirdO(q_a[11:8],out2);
// hexTo7Seg fourthO(q_b[3:0],out3);
// hexTo7Seg fifthO(q_b[7:4],out4);
// hexTo7Seg sixthO(q_b[11:8],out5);

endmodule
