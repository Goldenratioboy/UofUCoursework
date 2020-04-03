`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Stephan Stankovic
// 
// Create Date:    15:24:24 09/18/2015 
// Design Name: 
// Module Name:    fibfsm 
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
module fibfsm(clk, reset, out0, out1, out2, out3);

input clk, reset;

output wire [6:0] out0, out1, out2, out3;

wire [15:0] C;
wire Cin = 0;

reg [15:0] regEnable, inst;
reg [3:0] ctrlA, ctrlB;

reg [3:0] state;

parameter first = 4'b0000;
parameter second = 4'b0001;
parameter third = 4'b0010;
parameter fourth = 4'b0011;
parameter fifth = 4'b0100;
parameter sixth = 4'b0101;
parameter seventh = 4'b0110;
parameter eighth = 4'b0111;
parameter ninth = 4'b1000;
parameter tenth = 4'b1001;
parameter eleventh = 4'b1010;
parameter twelveth = 4'b1100;
parameter thirteenth = 4'b1101;
parameter fourteenth = 4'b1110;
parameter reset1 = 4'b1111;

cpu_alu_datapath datapath(
	.clk(clk), 
	.regEnable(regEnable), 
	.reset(reset), 
	.bus_output(C), 
	.inst(inst), 
	.ctrlA(ctrlA), 
	.ctrlB(ctrlB),
	.Cin(Cin)
);

always@ (posedge clk)
begin
	state <= reset1;
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
			state <= second;
			
	second:
		if (reset)
			state <= reset1;
		else
			state <= third;
			
	third:
		if (reset)
			state <= reset1;
		else
			state <= fourth;
			
	fourth:
		if (reset)
			state <= reset1;
		else
			state <= fifth;
			
	fifth:
		if (reset)
			state <= reset1;
		else
			state <= sixth;
			
	sixth:
		if (reset)
			state <= reset1;
		else
			state <= seventh;
			
	seventh:
		if (reset)
			state <= reset1;
		else
			state <= eighth;
			
	eighth:
		if (reset)
			state <= reset1;
		else
			state <= ninth;
			
	ninth:
		if (reset)
			state <= reset1;
		else
			state <= tenth;
			
	tenth:
		if (reset)
			state <= reset1;
		else
			state <= eleventh;
			
	eleventh:
		if (reset)
			state <= reset1;
		else
			state <= twelveth;
			
	twelveth:
		if (reset)
			state <= reset1;
		else
			state <= thirteenth;
			
	thirteenth:
		if (reset)
			state <= reset1;
		else
			state <= fourteenth;
			
	fourteenth:
		if (reset)
			state <= reset1;
		else
			state <= fourteenth;
			
	default:
		state <= reset1;
		
	endcase	
end

always@ (state)
begin
	case(state)
	reset1:
		begin
		regEnable = 16'b0000_0000_0000_0011;
		ctrlA = 4'b0000;
		ctrlB = 4'b0000;
		inst = 16'b0;
		
		end
		
	first:
		begin
		regEnable = 16'b0000_0000_0000_0100;
		ctrlA = 4'b0000;
		ctrlB = 4'b0001;
		inst = 16'b0000_0000_0110_0000;
		
		end

	second:
		begin
		regEnable = 16'b0000_0000_0000_1000;
		ctrlA = 4'b0001;
		ctrlB = 4'b0010;
		inst = 16'b0000_0000_0110_0000;
		
		end

	third:
		begin
		regEnable = 16'b0000_0000_0001_0000;
		ctrlA = 4'b0010;
		ctrlB = 4'b0011;
		inst = 16'b0000_0000_0110_0000;
		
		end
		
	fourth:
		begin
		regEnable = 16'b0000_0000_0010_0000;
		ctrlA = 4'b0011;
		ctrlB = 4'b0100;
		inst = 16'b0000_0000_0110_0000;
		
		end

	fifth:
		begin
		regEnable = 16'b0000_0000_0100_0000;
		ctrlA = 4'b0100;
		ctrlB = 4'b0101;
		inst = 16'b0000_0000_0110_0000;
		
		end

	sixth:
		begin
		regEnable = 16'b0000_0000_1000_0000;
		ctrlA = 4'b0101;
		ctrlB = 4'b0110;
		inst = 16'b0000_0000_0110_0000;
		
		end

	seventh:
		begin
		regEnable = 16'b0000_0001_0000_0000;
		ctrlA = 4'b0110;
		ctrlB = 4'b0111;
		inst = 16'b0000_0000_0110_0000;
		
		end

	eighth:
		begin
		regEnable = 16'b0000_0010_0000_0000;
		ctrlA = 4'b0111;
		ctrlB = 4'b1000;
		inst = 16'b0000_0000_0110_0000;
		
		end

	ninth:
		begin
		regEnable = 16'b0000_0100_0000_0000;
		ctrlA = 4'b1000;
		ctrlB = 4'b1001;
		inst = 16'b0000_0000_0110_0000;
		
		end
		
	tenth:
		begin
		regEnable = 16'b0000_1000_0000_0000;
		ctrlA = 4'b1001;
		ctrlB = 4'b1010;
		inst = 16'b0000_0000_0110_0000;
		
		end

	eleventh:
		begin
		regEnable = 16'b0001_0000_0000_0000;
		ctrlA = 4'b1010;
		ctrlB = 4'b1011;
		inst = 16'b0000_0000_0110_0000;
		
		end

	twelveth:
		begin
		regEnable = 16'b0010_0000_0000_0000;
		ctrlA = 4'b1011;
		ctrlB = 4'b1100;
		inst = 16'b0000_0000_0110_0000;
		
		end

	thirteenth:
		begin
		regEnable = 16'b0100_0000_0000_0000;
		ctrlA = 4'b1100;
		ctrlB = 4'b1101;
		inst = 16'b0000_0000_0110_0000;
		
		end
	
	fourteenth:
		begin
		regEnable = 16'b1000_0000_0000_0000;
		ctrlA = 4'b1101;
		ctrlB = 4'b1110;
		inst = 16'b0000_0000_0110_0000;
		
		end
	
	default:
		begin
		regEnable = 16'b0000_0000_0000_0000;
		ctrlA = 4'b0000;
		ctrlB = 4'b0001;
		inst = 16'b0000_0000_0000_0000;
		
		end
	
endcase
end

 hexTo7Seg firstO(C[3:0],out0);
 hexTo7Seg secondO(C[7:4],out1);
 hexTo7Seg thirdO(C[11:8],out2);
 hexTo7Seg fourthO(C[15:12],out3);

endmodule
