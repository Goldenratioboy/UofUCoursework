`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Jonathan Pilling, Steen Sia, Stephan Stankovic, Jeremy Wu 
//
// Create Date:    12:41 11/13/2018
// Design Name:
// Module Names:   mux, pc, cpuDatapath 
// Project Name:   cpuDatapath
// Target Devices:
// Tool versions:
// Description:	Top Level Main Module/File
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

/*2 to 1 Mux for data path*//////////////////////////////
module mux(
  a,
  b,
  sel,
  out
);

//input a, b, sel;
//output reg [15:0] out;
//assign out = (sel) ? a : b;

	output reg[15:0] out;
	input [15:0] a, b;
	input sel;

	always @(a or b or sel)
		if (sel == 1'b0) out = a;
		else out = b;

endmodule
//////////////////////////////////////////////////////////

module pc (clk, reset, PC_en, LD_pc_out, PC_out, LD_PC);

input clk, reset, PC_en, LD_PC;
input [15:0] LD_pc_out;

output reg [15:0] PC_out;

always @ ( posedge clk)
  begin
    if (reset) 
	 begin
	 PC_out <= 16'b0000_0000_0000_0000;
    // PC is fed input
	 end
	 
	 
	 if(PC_en)
	 begin
	  // Allow data to be set from MUX_A instead of incrementing
	  if(LD_PC)
		 begin
			PC_out <= LD_pc_out;
		 end
	  else 
		 // Simply increment the Program Counter at current address
		 begin
			PC_out <= PC_out + 1'b1;
		 end
      end
	end
endmodule


/*THE BIG DATAPATH*///////////////////////////////////////
module cpuDatapath(clk, reset, q_b, addr_b, uart);

input clk, reset;

input [7:0] uart;

/*FSM Wires*/
wire [15:0] DOUT, regEnable, PC_out;
wire LD_mux, PC_mux, we_a, PC_en;
wire [7:0]  opcode_out;
wire [4:0] Flag_en;

/*MuxWires*/ //LDMUX PCMUX etc.
wire LD_PC;
wire [15:0] LD_pc_out;
wire[15:0] memAddr;

/* ALU Wires */
wire [15:0] aluOut, regFileInput;
wire [4:0] ALUtoFlags, flags_output;

/*REG BANK Wires*/
wire [15:0]r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0]muxtoALUA, muxtoALUB;
wire [3:0] ctrlA, ctrlB;
wire Cin;

input [15:0] addr_b;
wire [15:0] data_b = 16'b0;
wire we_b = 1'b0;
output[15:0] q_b;

wire uartSel;
wire [15:0] uarttoALU;
wire [15:0] trueUart = {8'b0, uart[7:0]};

mux ld_mux (
  .b(DOUT),
  .a(aluOut),
  .sel(LD_mux),
  .out(regFileInput)
);

mux pc_mux (
  .b(PC_out),
  .a(muxtoALUA),
  .sel(PC_mux),
  .out(memAddr)
);

mux ld_pc_mux (
  .b(muxtoALUA),
  .a(PC_out),
  .sel(LD_PC),
  .out(LD_pc_out)
);

pc programcounter (
    .clk(clk),
    .reset(reset),
    .PC_en(PC_en),
    .LD_pc_out(LD_pc_out),
    .PC_out(PC_out),
    .LD_PC(LD_PC)
  );

/* Instantiation of cpuDatapathFSM */
FSM mainFsm(
  .clk(clk),
  .reset(reset),
  .DOUT(DOUT),
  .LD_mux(LD_mux),
  .PC_mux(PC_mux),
  .PC_en(PC_en),
  .wen(we_a), //Need a or b here
  .Mux_A(ctrlA),
  .Mux_B(ctrlB),
  .Reg_en(regEnable),
  .opcode_out(opcode_out),
  .Flag_en(Flag_en),
  .LD_PC(LD_PC),
  .uartSel(uartSel)
);

/*Instatiation of REG BANK*/
RegBank reg_bank(
  .ALUBus(regFileInput),
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

mux uartMux (
	.a(muxtoALUB),
	.b(trueUart),
	.sel(uartSel),
	.out(uarttoALU)
);

/* Instantiation of the ALU created in Lab 1 *////////////////////////////
_3710alu alu(
	.A(muxtoALUA),
	.B(uarttoALU),
	.Cin(Cin),
	.inst(DOUT),
	.C(aluOut), //this might need to change to a wire that loops back to reg bank, goes through ld_mux i think
	.Flags(ALUtoFlags)
);

/*FLAG REGISTER*/
flagsUpdate flags(
	.flagsIn(ALUtoFlags),
	.flagsOut(flags_output),
	.clk(clk)
);

	// Memory
	memory cpuDataMem(
		.we_a(we_a),
		.data_a(uarttoALU),
		.addr_a(memAddr),
		.q_a(DOUT),
		.we_b(we_b),
		.data_b(data_b),
		.addr_b(addr_b),
		.q_b(q_b),
		.clk(clk)
	);

endmodule
