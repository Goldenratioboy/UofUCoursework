/*Written by Jonathan Pilling for the ECE3710 Group "The Boyz"*/

//I do not account for R_IMM type instructions but I think our ALU handles this already if we give it that Imm-type op codes, will have to test this further.
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Jonathan Pilling
//
// Create Date:    12:41 11/13/2018
// Design Name:
// Module Name:    FSM
// Project Name:   cpuDatapath
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Helped by the entire team to solve issues.
//
//////////////////////////////////////////////////////////////////////////////////

module FSM (
	DOUT,
	clk,
	reset,
	LD_mux,
	LD_PC,
	PC_mux,
	opcode_out,
	Reg_en,
	Mux_A,
	Mux_B,
	Flag_en,
	PC_en,
	wen,
	uartSel
);

input clk, reset;
input [15:0] DOUT;

output reg LD_mux, PC_mux, PC_en, wen, LD_PC, uartSel;
output reg [15:0] Reg_en;
output reg [7:0] opcode_out;
output reg [4:0] Flag_en;
output reg [3:0] Mux_A, Mux_B;


reg [3:0] state;
reg [3:0] DOUT1;

parameter reset1 = 4'b1111; /*This will be the first state, reset switch always zeroes out everything except for pc_mux*/


parameter first = 4'b0000; //This is the state where we decide where to go, decoding the instruction determines this

/*R-type intruction states*/
parameter r1 = 4'b0001;
parameter r2 = 4'b0010;

/*Store instruction states*/
parameter store1 = 4'b0011;
parameter store2 = 4'b0100;
parameter store1int = 4'b1110;

/*Load instruction states*/
parameter load1 = 4'b0101;
parameter load2 = 4'b0110;

/*Jump instruction states*/
parameter jump1 = 4'b0111;
parameter jump2 = 4'b1000;

parameter jal1 = 4'b1010;
parameter jal2 = 4'b1011;
parameter jal3 = 4'b1100;

parameter stop = 4'b1001;

/*Logic for flowing through the states*/
always@ (posedge clk)
begin
	//state <= reset1;
	case(state)
	reset1:
		if (reset)
			state <= reset1;
		else
			state <= first;

	first:
		if (reset)
			state <= reset1;
		else
		begin
		/////////////////////////////////////////////////////////////
        /*This is the big decoding section*/
		////////////////////////////////////////////////////////////

			/*This indicates a load/store/jump op*/
			if(DOUT[15:12] == 4'b0100)
			begin

				//LOAD
				if(DOUT[7:4] == 4'b0000)
				begin
				  state <= load1;
				end

				//STORE
				else if(DOUT[7:4] == 4'b0100)
				begin
				  state <= store1;
				end

				//JUMPS
				else if(DOUT[7:4] == 4'b1100)
				begin
				  state <= jump1;
				end
				else if(DOUT[7:4] == 4'b1000)
				begin
				  state <= jal1;
				end
			end

			else /*R-type Instruction, accounts for R_Imm type insts*/
			begin
				state <= r1;
			end
		end
			/////////////////////////////////////////////////////////////

	r1:
		if (reset)
			state <= reset1;
		else
			state <= r2;

	r2:
		if (reset)
			state <= reset1;
		else
			state <= reset1;

	store1:
		if (reset)
			state <= reset1;
		else
			state <= store1int;
	store1int:
		if (reset)
			state <= reset1;
		else
			state <= store2;
	store2:
		if (reset)
			state <= reset1;
		else
			state <= reset1; //Change this back to Start after debugging

	load1:
		if (reset)
			state <= reset1;
		else
			state <= load2;

	load2:
		if (reset)
			state <= reset1;
		else
			state <= stop;

	jump1:
		if (reset)
			state <= reset1;
		else
			state <= jump2;

	jump2:
		if (reset)
			state <= reset1;
		else
			state <= first;

	jal1:
		if (reset)
			state <= reset1;
		else
			state <= jal2;

	jal2:
		if (reset)
			state <= reset1;
		else
			state <= jal3;
	jal3:
		if (reset)
			state <= reset1;
		else
			state <= first;

	stop:
		if(reset)
			state <= reset1;
		else
			state <= stop;
	default:
		state <= reset1;

	endcase
end

/*Combinational Logic for the different states, control signals*/
always@(state)
begin
	case(state)

	reset1: begin
		PC_en = 1'b0;
		LD_mux = 1'b0;
		LD_PC = 1'b0;
		Reg_en = 16'b0000_0000_0000_0000;
		Flag_en = 5'b00000;
		PC_mux = 1'b1;
		wen = 1'b0;
		Mux_A = 4'b000;
		Mux_B = 4'b000;
		opcode_out = 8'b0000_0000;
		uartSel = 1'b0;
		end

    first: begin
	   PC_en = 1'b0;
	   Reg_en = 16'b0000_0000_0000_0000;
	   Flag_en = 4'b0000;
	   PC_mux = 1'b1;
		LD_mux = 1'b0;
		LD_PC = 1'b0;
		wen = 1'b0;
		Mux_A = 4'b000;
		Mux_B = 4'b000;
		opcode_out = 8'b0000_0000;
		uartSel = 1'b0;
	   end

    r1: begin
        Mux_A = 4'b000;
		  Mux_B = 4'b000;
		  
		  Reg_en = 16'b0;
		  
		 //Passes in destination bit to turn on for 16 bit hot coded reg enable
        opcode_out = {DOUT[15:12], DOUT[7:4]}; //Assigns op code to ALU
		  PC_en = 1'b0;
		  LD_mux = 1'b0;
		  LD_PC = 1'b0;
		  Flag_en = 5'b00000;
		  PC_mux = 1'b1;
		  wen = 1'b0;
		  uartSel = 1'b0;
		  end

    r2: begin
		PC_en = 1'b1; //I think this is just an extra buffer state for computing
		LD_mux = 1'b0;
		LD_PC = 1'b0;
		Mux_A = DOUT[11:8]; //SRC 
      Mux_B = DOUT [3:0];
		/*Reg enable*/
		  case(Mux_A)
			4'b0000: Reg_en = 16'b0000_0000_0000_0001;
			4'b0001: Reg_en = 16'b0000_0000_0000_0010;
			4'b0010: Reg_en = 16'b0000_0000_0000_0100;
			4'b0011: Reg_en = 16'b0000_0000_0000_1000;
			4'b0100: Reg_en = 16'b0000_0000_0001_0000;
			4'b0101: Reg_en = 16'b0000_0000_0010_0000;
			4'b0110: Reg_en = 16'b0000_0000_0100_0000;
			4'b0111: Reg_en = 16'b0000_0000_1000_0000;
			4'b1000: Reg_en = 16'b0000_0001_0000_0000;
			4'b1001: Reg_en = 16'b0000_0010_0000_0000;
			4'b1010: Reg_en = 16'b0000_0100_0000_0000;
			4'b1011: Reg_en = 16'b0000_1000_0000_0000;
			4'b1100: Reg_en = 16'b0001_0000_0000_0000;
			4'b1101: Reg_en = 16'b0010_0000_0000_0000;
			4'b1110: Reg_en = 16'b0100_0000_0000_0000;
			4'b1111: Reg_en = 16'b1000_0000_0000_0000;
			default: Reg_en = 16'b0000_0000_0000_0000;
			endcase
		Flag_en = 5'b00000;
		PC_mux = 1'b1;
		wen = 1'b0;
		opcode_out = 8'b0000_0000;
		uartSel = 1'b0;
		end

    store1: begin
        PC_mux = 1'b0;
        Mux_A = DOUT[3:0]; //R Address
        Mux_B = DOUT[11:8]; //Data/SRC
		  uartSel = 1'b1;
        wen = 1'b1;
        Reg_en = 16'b0000_0000_0000_0000;
        PC_en = 1'b0;
		  LD_mux = 1'b0;
		  LD_PC = 1'b0;
		  Flag_en = 5'b00000;
		  opcode_out = 8'b0000_0000;
 		  end
		  
	 store1int: begin
        PC_mux = 1'b0;
        Mux_A = DOUT[3:0]; //R Address
        Mux_B = DOUT[11:8]; //Data/SRC
		  uartSel = 1'b1;
        wen = 1'b1;
        Reg_en = 16'b0000_0000_0000_0000;
        PC_en = 1'b0;
		  LD_mux = 1'b0;
		  LD_PC = 1'b0;
		  Flag_en = 5'b00000;
		  opcode_out = 8'b0000_0000;
 		  end

    store2: begin
        PC_en = 1'b1;
        PC_mux = 1'b1;
		  uartSel = 1'b0;
        wen = 1'b0;
		  LD_mux = 1'b0;
		  LD_PC = 1'b0;
		  Reg_en = 16'b0000_0000_0000_0000;
		  Flag_en = 5'b00000;
		  Mux_A = 4'b000;
		  Mux_B = 4'b000;
		  opcode_out = 8'b0000_0000;
		  end

    load1: begin
        PC_en = 1'b0;
        Mux_A = DOUT[3:0];
		  DOUT1 = DOUT[11:8];
        Mux_B = 4'bxxxx; //Don't Care
        wen = 1'b0;
        LD_mux = 1'b1;
        PC_mux = 1'b0;
        Reg_en = 16'b0000_0000_0000_0000;
		  LD_PC = 1'b0;
	     Flag_en = 5'b00000;
		  opcode_out = 8'b0000_0000;
		  uartSel = 1'b0;
		  end

    load2: begin
		  LD_PC = 1'b0;
		  /*Hot Codes for Reg Enable*/
		  case(DOUT1[3:0])
		  4'b0000: Reg_en = 16'b0000_0000_0000_0001;
		  4'b0001: Reg_en = 16'b0000_0000_0000_0010;
		  4'b0010: Reg_en = 16'b0000_0000_0000_0100;
		  4'b0011: Reg_en = 16'b0000_0000_0000_1000;
		  4'b0100: Reg_en = 16'b0000_0000_0001_0000;
		  4'b0101: Reg_en = 16'b0000_0000_0010_0000;
	  	  4'b0110: Reg_en = 16'b0000_0000_0100_0000;
		  4'b0111: Reg_en = 16'b0000_0000_1000_0000;
		  4'b1000: Reg_en = 16'b0000_0001_0000_0000;
		  4'b1001: Reg_en = 16'b0000_0010_0000_0000;
		  4'b1010: Reg_en = 16'b0000_0100_0000_0000;
		  4'b1011: Reg_en = 16'b0000_1000_0000_0000;
		  4'b1100: Reg_en = 16'b0001_0000_0000_0000;
		  4'b1101: Reg_en = 16'b0010_0000_0000_0000;
		  4'b1110: Reg_en = 16'b0100_0000_0000_0000;
		  4'b1111: Reg_en = 16'b1000_0000_0000_0000;
		  default: Reg_en = 16'b0000_0000_0000_0000;
		  endcase
				
        PC_en = 1'b1;
        PC_mux = 1'b1;
		  LD_mux = 1'b1;
		  Flag_en = 5'b00000;
		  wen = 1'b0;
		  Mux_A = 4'b000;
		  Mux_B = 4'b000;
		  opcode_out = 8'b0000_0000;
		  uartSel = 1'b0;
	     end

    jump1: begin
		LD_mux = 1'b1;
      PC_en = 1'b1;
      PC_mux = 1'b1;
      Reg_en = 16'b0000_0000_0000_0000;
      Flag_en = 4'b0000;
      Mux_A = DOUT[3:0];
		LD_PC = 1'b1;
		wen = 1'b0;
		Mux_B = 4'b0;
		opcode_out = 8'b0000_0000;
		uartSel = 1'b0;
		end

		// Might need modifications on ctrl signals
    jump2: begin
        PC_en = 1'b0;
        PC_mux = 1'b1;
		  LD_PC = 1'b0;
		  LD_mux = 1'b0;
		  Reg_en = 16'b0000_0000_0000_0000;
		  Flag_en = 5'b00000;
		  wen = 1'b0;
		  Mux_A = 4'b000;
		  Mux_B = 4'b000;
		  opcode_out = 8'b0000_0000;
		  uartSel = 1'b0;
		  end

		// Store addr of next instr into R15
		jal1: 
		begin
		LD_mux = 1'b1;
        PC_en = 1'b1;
        PC_mux = 1'b1;
        Reg_en = 16'b1000_0000_0000_0000;
        Flag_en = 4'b0000;
        Mux_A = 4'b0000;
		Mux_B = 4'b0000;
		LD_PC = 1'b0;
		wen = 1'b0;
		opcode_out = 8'b0000_0000;
		uartSel = 1'b0;
		end

		// jal2 & jal3 do regular jump to Rsrc
	    jal2: begin
        LD_mux = 1'b1;
        PC_en = 1'b1;
        PC_mux = 1'b1;
        Reg_en = 16'b0000_0000_0000_0000;
        Flag_en = 4'b0000;
        Mux_A = DOUT[3:0];
				LD_PC = 1'b0;
				wen = 1'b0;
		Mux_B = 4'b000;
				opcode_out = 8'b0000_0000;
				uartSel = 1'b0;
		  end

    	jal3: begin
        PC_en = 1'b0;
        PC_mux = 1'b1;
				LD_PC = 1'b0;
				LD_mux = 1'b0;
				Reg_en = 16'b0000_0000_0000_0000;
				Flag_en = 5'b00000;
				wen = 1'b0;
		Mux_A = 4'b0000;
		Mux_B = 4'b0000;
				opcode_out = 8'b0000_0000;
				uartSel = 1'b0;
		  end

		
		stop: begin
			PC_en = 1'b0;
			LD_mux = 1'b0;
			LD_PC = 1'b0;
			Reg_en = 16'b0000_0000_0000_0000;
			Flag_en = 5'b00000;
			PC_mux = 1'b1;
			wen = 1'b0;
			Mux_A = 4'b000;
			Mux_B = 4'b000;
			opcode_out = 8'b0000_0000;
			uartSel = 1'b0;
		end
		
		  
		default: begin
		PC_en = 1'b0;
		LD_mux = 1'b0;
		LD_PC = 1'b0;
		Reg_en = 16'b0000_0000_0000_0000;
		Flag_en = 5'b00000;
		PC_mux = 1'b0;
		wen = 1'b0;
		Mux_A = 4'b000;
		Mux_B = 4'b000;
		opcode_out = 8'b0000_0000;
		uartSel = 1'b0;
		end

endcase
end

endmodule
