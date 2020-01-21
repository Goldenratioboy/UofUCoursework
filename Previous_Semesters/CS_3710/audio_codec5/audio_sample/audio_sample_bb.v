
module audio_sample (
	clk_clk,
	reset_reset_n,
	audio_pll_0_audio_clk_clk,
	audio_and_video_config_0_external_interface_SDAT,
	audio_and_video_config_0_external_interface_SCLK,
	audio_0_external_interface_BCLK,
	audio_0_external_interface_DACDAT,
	audio_0_external_interface_DACLRCK,
	audio_0_avalon_right_channel_sink_data,
	audio_0_avalon_right_channel_sink_valid,
	audio_0_avalon_right_channel_sink_ready,
	audio_0_avalon_left_channel_sink_data,
	audio_0_avalon_left_channel_sink_valid,
	audio_0_avalon_left_channel_sink_ready);	

	input		clk_clk;
	input		reset_reset_n;
	output		audio_pll_0_audio_clk_clk;
	inout		audio_and_video_config_0_external_interface_SDAT;
	output		audio_and_video_config_0_external_interface_SCLK;
	input		audio_0_external_interface_BCLK;
	output		audio_0_external_interface_DACDAT;
	input		audio_0_external_interface_DACLRCK;
	input	[15:0]	audio_0_avalon_right_channel_sink_data;
	input		audio_0_avalon_right_channel_sink_valid;
	output		audio_0_avalon_right_channel_sink_ready;
	input	[15:0]	audio_0_avalon_left_channel_sink_data;
	input		audio_0_avalon_left_channel_sink_valid;
	output		audio_0_avalon_left_channel_sink_ready;
endmodule
