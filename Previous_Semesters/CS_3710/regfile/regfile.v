`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jonathan Pilling & Steen Sia
// 
// Create Date:    15:24:24 09/18/2015 
// Design Name: 
// Module Name:    Mux16to1, regfile, Regbank, flagsUpdate 
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

/*[15-0] MUX that gives us a regfile for A*/
module Mux16to1(r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, ctrl, Bus_out); /*Mux module*/

input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15; 
input [3:0]ctrl;
output reg [15:0]Bus_out;

	always @ (ctrl or r0 or r1 or r2 or r3 or r4 or r5 or r6 or r7 or r8 or r9 or r10 or r11 or r12 or r13 or r14 or r15)
	begin
		case(ctrl)
			4'b0000: Bus_out = r0;
			4'b0001: Bus_out = r1;
			4'b0010: Bus_out = r2;
			4'b0011: Bus_out = r3;
			4'b0100: Bus_out = r4;
			4'b0101: Bus_out = r5;
			4'b0110: Bus_out = r6;
			4'b0111: Bus_out = r7;
			4'b1000: Bus_out = r8;
			4'b1001: Bus_out = r9;
			4'b1010: Bus_out = r10;
			4'b1011: Bus_out = r11;
			4'b1100: Bus_out = r12;
			4'b1101: Bus_out = r13;
			4'b1110: Bus_out = r14;
			4'b1111: Bus_out = r15;	
		endcase
	end

endmodule

/* Register file which instantiates each register and its values */
module regfile(D_in, wEnable, reset, clk, r);
	 input [15:0] D_in;
	 input clk, wEnable, reset;
	 output reg [15:0] r;
	 
 always @( posedge clk )
	begin
	if (reset) r <= 4'b0000;
	else
		begin			
			if (wEnable)
			begin
				r <= D_in;
			end
			else
			begin
				r <= r;
			end
		end
	end
endmodule


// Shown below is one way to implement the regfile file
// This is a bottom-up, structural instantiation
// Another module is described in another file...
// .... which shows two dimensional construct for regfile

// Structural Implementation of RegBank
/********/
module RegBank(ALUBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, regEnable, clk, reset);
	input clk, reset;
	input [15:0] ALUBus;
	input [15:0] regEnable;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	wire [15:0] in1 = 16'b0;							// REMOVE THIS BEFORE NEXT STAGE
	wire [15:0] in2 = 16'b0000_0000_0000_0001;	// REMOVE THIS BEFORE NEXT STAGE
	
regfile Inst0(
	.D_in(ALUBus),						//Hard Coded Value goes here
	.wEnable(regEnable[0]),
	.reset(reset), 
	.clk(clk),
	.r(r0));

regfile Inst1(
	.D_in(ALUBus),						//Hard Coded Value goes here
	.wEnable(regEnable[1]),
	.reset(reset), 
	.clk(clk),
	.r(r1));

regfile Inst2(
	.D_in(ALUBus),
	.wEnable(regEnable[2]),
	.reset(reset), 
	.clk(clk),
	.r(r2));

regfile Inst3(
	.D_in(ALUBus),
	.wEnable(regEnable[3]),
	.reset(reset), 
	.clk(clk),
	.r(r3));

regfile Inst4(
	.D_in(ALUBus),
	.wEnable(regEnable[4]),
	.reset(reset), 
	.clk(clk),
	.r(r4));

regfile Inst5(
	.D_in(ALUBus),
	.wEnable(regEnable[5]),
	.reset(reset), 
	.clk(clk),
	.r(r5));

regfile Inst6(
	.D_in(ALUBus),
	.wEnable(regEnable[6]),
	.reset(reset), 
	.clk(clk),
	.r(r6));

regfile Inst7(
	.D_in(ALUBus),
	.wEnable(regEnable[7]),
	.reset(reset), 
	.clk(clk),
	.r(r7));

regfile Inst8(
	.D_in(ALUBus),
	.wEnable(regEnable[8]),
	.reset(reset), 
	.clk(clk),
	.r(r8));

regfile Inst9(
	.D_in(ALUBus),
	.wEnable(regEnable[9]),
	.reset(reset), 
	.clk(clk),
	.r(r9));

regfile Inst10(
	.D_in(ALUBus),
	.wEnable(regEnable[10]),
	.reset(reset), 
	.clk(clk),
	.r(r10));

regfile Inst11(
	.D_in(ALUBus),
	.wEnable(regEnable[11]),
	.reset(reset), 
	.clk(clk),
	.r(r11));

regfile Inst12(
	.D_in(ALUBus),
	.wEnable(regEnable[12]),
	.reset(reset), 
	.clk(clk),
	.r(r12));

regfile Inst13(
	.D_in(ALUBus),
	.wEnable(regEnable[13]),
	.reset(reset), 
	.clk(clk),
	.r(r13));

regfile Inst14(
	.D_in(ALUBus),
	.wEnable(regEnable[14]),
	.reset(reset), 
	.clk(clk),
	.r(r14));

regfile Inst15(
	.D_in(ALUBus),
	.wEnable(regEnable[15]),
	.reset(reset), 
	.clk(clk),
	.r(r15));

endmodule
/**************/

/* Module for updating flags on each positive edge of the clock */
module flagsUpdate(clk, flagsOut, flagsIn);
	input [4:0] flagsIn;
	input clk;
	output reg [4:0] flagsOut;
	
	always @(posedge clk)
	begin
		flagsOut <= flagsIn;
	end
endmodule


	