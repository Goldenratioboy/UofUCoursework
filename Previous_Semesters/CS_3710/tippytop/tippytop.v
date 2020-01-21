module tippytop (clk, reset, hSync, vSync, slow_clock, red, green, blue, bright, SDAT, BCLK, DACLRCK, DACDAT, SCLK, AUD_XCK, data, ps2clk);

	// GLOBAL INPUTS
	input clk, reset;
	
	// VGA
	output hSync, vSync, slow_clock;
	output [7:0] red, green, blue;
	
	inout bright;
	
	wire [15:0] addie, indata;
	
	vga_wrapper vga_wrapper(
		.clk(clk),
		.reset(reset),
		.red(red),
		.green(green),
		.blue(blue),
		.hSync(hSync),
		.vSync(vSync),
		.slow_clock(slow_clock),
		.bright(bright),
		.addie(addie),
		.indata(note)
	);

	// Audio
	input BCLK, DACLRCK;
	output DACDAT, SCLK, AUD_XCK;
	
	inout SDAT;
	
	audio_gen_top audio_gen_top(
		.clk(clk),
		.reset(reset),
		.BCLK(BCLK),
		.DACLRCK(DACLRCK),
		.DACDAT(DACDAT),
		.SCLK(SCLK),
		.AUD_XCK(AUD_XCK),
		.SDAT(SDAT),
		.indata(note)
	);

	// CPU Datapath
	cpuDatapath cpuDatapath(
		.clk(clk),
		.reset(reset),
		.uart(note),
		.addr_b(addie),
		.q_b(indata)
	);
	
	// PS/2 Module
	input data;
	input ps2clk;
	wire [7:0] note;
	
	Keyboard Keyboard(
		.clk(ps2clk),
		.data(data),
		.note(note)
	);

endmodule