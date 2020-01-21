// audio_sample_audio_pll_0.v

// This file was auto-generated from altera_up_avalon_audio_pll_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module audio_sample_audio_pll_0 (
		input  wire  ref_clk_clk,        //      ref_clk.clk
		input  wire  ref_reset_reset,    //    ref_reset.reset
		output wire  audio_clk_clk,      //    audio_clk.clk
		output wire  reset_source_reset  // reset_source.reset
	);

	wire    audio_pll_locked_export; // audio_pll:locked -> reset_from_locked:locked

	audio_sample_audio_pll_0_audio_pll audio_pll (
		.refclk   (ref_clk_clk),             //  refclk.clk
		.rst      (ref_reset_reset),         //   reset.reset
		.outclk_0 (audio_clk_clk),           // outclk0.clk
		.locked   (audio_pll_locked_export)  //  locked.export
	);

	altera_up_avalon_reset_from_locked_signal reset_from_locked (
		.reset  (reset_source_reset),      // reset_source.reset
		.locked (audio_pll_locked_export)  //       locked.export
	);

endmodule
