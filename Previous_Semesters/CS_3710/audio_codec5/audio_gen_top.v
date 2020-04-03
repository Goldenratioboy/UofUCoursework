module audio_gen_top(clk, reset, BCLK, DACDAT, DACLRCK, SDAT, SCLK, AUD_XCK, indata);        

input clk, reset;

input wire BCLK, DACLRCK;

output wire DACDAT, SCLK, AUD_XCK;

inout wire SDAT;

input wire [7:0] indata;

wire [7:0] key = indata[7:0];
wire [15:0] sample;

tonegen tg1(.clk(clk), 
            .reset(reset),  
            .left_chan_ready(left_ready), 
            .right_chan_ready(right_ready), 
            .data_out(sample), 
            .sample_valid(sample_valid),
				.key(key)
           );

audio_sample aud_sample(.clk_clk(clk), 
            .reset_reset_n(reset), 
			   .audio_0_avalon_left_channel_sink_data(sample), 
			   .audio_0_avalon_left_channel_sink_valid(sample_valid), 
			   .audio_0_avalon_left_channel_sink_ready(left_ready),
			   .audio_0_avalon_right_channel_sink_data(sample),
			   .audio_0_avalon_right_channel_sink_valid(sample_valid),
			   .audio_0_avalon_right_channel_sink_ready(right_ready),
			   .audio_0_external_interface_BCLK(BCLK),
			   .audio_0_external_interface_DACDAT(DACDAT),
			   .audio_0_external_interface_DACLRCK(DACLRCK),
			   .audio_and_video_config_0_external_interface_SDAT(SDAT),
			   .audio_and_video_config_0_external_interface_SCLK(SCLK),
			   .audio_pll_0_audio_clk_clk(AUD_XCK)
			  );

endmodule
