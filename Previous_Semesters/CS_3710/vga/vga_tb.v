module vga_tb();


reg clk, reset;

wire [9:0] hCount, vCount;

wire hSync, vSync, bright;

 

//Instatiate the UUT
	vga_ctrl ctrl_test(
		.clk(clk),
		.reset(reset),
		.hSync(hSync),
		.vSync(vSync),
		.hCount(hCount),
		.vCount(vCount),
		.bright(bright)
	);
	
	vga_bitgen bit_test(
		.red(),
		.green(),
		.blue(),
		.bright(bright),
		.hCount(hCount),
		.vCount(vCount)
	);

initial 
	begin
		clk = 0;
		reset = 0;
		#10
		reset = 1;
		#10
		reset = 0;
		#500
		$finish;
	end

always@ (*)
		#5 clk <= ~clk;



endmodule