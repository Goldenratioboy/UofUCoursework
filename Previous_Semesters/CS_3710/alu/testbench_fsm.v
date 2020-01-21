
module testbench_fsm(
clk,
reset,
C
);

parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6, s7 = 7; s8 = 8; s9 = 9; s10 = 10; s11 = 11; s12 = 12; s13 = 13; s14 = 14; s15 = 15;
input clk, reset;
reg [3:0] state, nextState;
wire [15:0] regEnable, inst;
output [15:0] C;
wire [3:0] ctrlA, ctrlB;

assign state = s0;

always @(posedge clk, posedge reset)
begin
case(reset)
if (reset)
	state <= s0;
else
 state <= nextState;
end //end clk

always @(state)
begin
case(state)

s0: begin
regEnable <= 16'b0000000000000001;
ctrlA <= 4'b0000;
ctrlB <= 4'b0001;
inst <= 16'b0000000010010000; //sub
nextState <= s1;
end

s1: begin
regEnable <= 16'b0000000000000010;
ctrlA <= 4'b0001;
ctrlB <= 4'b0010;
inst <= 16'b0000000010010000; //sub
nextState <= s2;
end

s2: begin
regEnable <= 16'b0000000000000100;
ctrlA <= 4'b0010;
ctrlB <= 4'b0011;
inst <= 16'b0000000010010000; //sub
nextState <= s23
end

s3: begin
regEnable <= 16'b0000000000001000;
ctrlA <= 4'b0011;
ctrlB <= 4'b0100;
inst <= 16'b0000000010010000; //sub
nextState <= s4;
end
begin
regEnable <= 16'b0000000000010000;
ctrlA <= 4'b0100;
ctrlB <= 4'b0101;
inst <= 16'b0000000010010000; //sub
nextState <= s5;
end

s5: begin
regEnable <= 16'b0000000000100000;
ctrlA <= 4'b0101;
ctrlB <= 4'b0110;
inst <= 16'b0000000010010000; //sub
nextState <= s6;
end

s6: begin
regEnable <= 16'b0000000001000000;
ctrlA <= 4'b0110;
ctrlB <= 4'b0111;
inst <= 16'b0000000010010000; //sub
nextState <= s7;
end

s7: begin
regEnable <= 16'b0000000010000000;
ctrlA <= 4'b0111;
ctrlB <= 4'b1000;
inst <= 16'b0000000010010000; //sub
nextState <= s8;
end

s8: begin
regEnable <= 16'b0000000100000000;
ctrlA <= 4'b1000;
ctrlB <= 4'b1001;
inst <= 16'b0000000010010000; //sub
nextState <= s9;
end
begin
regEnable <= 16'b0000001000000000;
ctrlA <= 4'b1001;
ctrlB <= 4'b1011;
inst <= 16'b0000000010010000; //sub
nextState <= s10;
end

s10: begin
regEnable <= 16'b0000010000000000;
ctrlA <= 4'b1010;
ctrlB <= 4'b1100;
inst <= 16'b0000000010010000; //sub
nextState <= s11;
end

s11: begin
regEnable <= 16'b0000100000000000;
ctrlA <= 4'b1011;
ctrlB <= 4'b1101;
inst <= 16'b0000000010010000; //sub
nextState <= s12;
end

s12: begin
regEnable <= 16'b0001000000000000;
ctrlA <= 4'b1100;
ctrlB <= 4'b1101;
inst <= 16'b0000000010010000; //sub
nextState <= s13;
end

s13:begin
regEnable <= 16'b0010000000000000;
ctrlA <= 4'b1101;
ctrlB <= 4'b1110;
inst <= 16'b0000000010010000; //sub
nextState <= s14;
end

s14: begin
regEnable <= 16'b0100000000000000;
ctrlA <= 4'b1110;
ctrlB <= 4'b1111;
inst <= 16'b0000000010010000; //sub
nextState <= s15;
end

s15: begin
regEnable <= 16'b1000000000000000;
ctrlA <= 4'b1111;
ctrlB <= 4'b1111;
inst <= 16'b0000000010010000; //sub
end


end //end state