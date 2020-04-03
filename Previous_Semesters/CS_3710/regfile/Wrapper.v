`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Jonathan Pilling & Steen Sia
//
// Create Date:    15:24:24 09/18/2015
// Design Name:
// Module Name:    cpu_alu_datapath
// Project Name: 	 regfile
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
module cpu_alu_datapath(
	clk, regEnable, reset, bus_output, inst, flags_output, ctrlA, ctrlB, Cin
);

input clk, reset, Cin;
input [15:0] regEnable, inst;
input [3:0] ctrlA, ctrlB;

/*Wires that connect the reg bank to regs*/
wire [15:0]r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;

/*Wires that connect Mux output to ALU*/
wire [15:0]muxtoALUA, muxtoALUB;

/*Wires that connect ALU to flags*/
wire [4:0] ALUtoFlags;

/*Output on the bus that we want to read on the board*/

output [15:0] bus_output; // Also this value is fed back into the reg bank
output [4:0] flags_output;

/* Instantiation of our register bank and wiring it up */
RegBank reg_bank(
	 .ALUBus(bus_output),
	 .regEnable(regEnable),
	 .clk(clk),
	 .reset(reset),
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r4(r4),
    .r5(r5),
    .r6(r6),
    .r7(r7),
    .r8(r8),
    .r9(r9),
    .r10(r10),
    .r11(r11),
    .r12(r12),
    .r13(r13),
    .r14(r14),
    .r15(r15)

);

/* Instantiation of the first Multiplexor or A Multiplexor */
Mux16to1 muxA(
	.r0(r0),
	.r1(r1),
	.r2(r2),
	.r3(r3),
	.r4(r4),
	.r5(r5),
	.r6(r6),
	.r7(r7),
	.r8(r8),
	.r9(r9),
	.r10(r10),
	.r11(r11),
	.r12(r12),
	.r13(r13),
	.r14(r14),
	.r15(r15),
   .ctrl(ctrlA),
	.Bus_out(muxtoALUA)
);

/* Instantiation of the second Multiplexor or B Multiplexor */
Mux16to1 muxB(
	.r0(r0),
	.r1(r1),
	.r2(r2),
	.r3(r3),
	.r4(r4),
	.r5(r5),
	.r6(r6),
	.r7(r7),
	.r8(r8),
	.r9(r9),
	.r10(r10),
	.r11(r11),
	.r12(r12),
	.r13(r13),
	.r14(r14),
	.r15(r15),
   .ctrl(ctrlB),
	.Bus_out(muxtoALUB)
);

/* Instantiation of the ALU created in Lab 1 */
_3710alu alu(
	.A(muxtoALUA),
	.B(muxtoALUB),
	.Cin(Cin),
	.inst(inst),
	.C(bus_output),
	.Flags(ALUtoFlags)
);

/* Instatiation of our flags output */
flagsUpdate flags(
	.flagsIn(ALUtoFlags),
	.flagsOut(flags_output),
	.clk(clk)
);


endmodule
