//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Stephan Stankovic, Jeremy Wu
//
// Create Date:    12:41 09/11/2018
// Design Name:
// Module Name:    wrap
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

module wrap (A, B, out0, out1, out2, out3, Cin, inst, Flags);

input [3:0] A, B, inst;
input Cin;

output wire [4:0] Flags;
output wire [6:0] out0, out1, out2, out3;

wire [15:0] C;
reg [15:0] A_tmp, B_tmp, inst_tmp;

always@ (A, B, Cin, inst)
begin	
		
		A_tmp = {A,12'b0};
		B_tmp = {B, 12'b0};
		inst_tmp = {8'b0, inst, 4'b0};

end

 _3710alu alu1 (
	.A(A_tmp),
	.B(B_tmp),
	.C(C),
	.Cin(Cin),
	.inst(inst_tmp),
	.Flags(Flags)
 );
 
 hexTo7Seg first(C[3:0],out0);
 hexTo7Seg second(C[7:4],out1);
 hexTo7Seg third(C[11:8],out2);
 hexTo7Seg fourth(C[15:12],out3);

endmodule
