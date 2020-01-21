	audio_sample u0 (
		.clk_clk                                          (<connected-to-clk_clk>),                                          //                                         clk.clk
		.reset_reset_n                                    (<connected-to-reset_reset_n>),                                    //                                       reset.reset_n
		.audio_pll_0_audio_clk_clk                        (<connected-to-audio_pll_0_audio_clk_clk>),                        //                       audio_pll_0_audio_clk.clk
		.audio_and_video_config_0_external_interface_SDAT (<connected-to-audio_and_video_config_0_external_interface_SDAT>), // audio_and_video_config_0_external_interface.SDAT
		.audio_and_video_config_0_external_interface_SCLK (<connected-to-audio_and_video_config_0_external_interface_SCLK>), //                                            .SCLK
		.audio_0_external_interface_BCLK                  (<connected-to-audio_0_external_interface_BCLK>),                  //                  audio_0_external_interface.BCLK
		.audio_0_external_interface_DACDAT                (<connected-to-audio_0_external_interface_DACDAT>),                //                                            .DACDAT
		.audio_0_external_interface_DACLRCK               (<connected-to-audio_0_external_interface_DACLRCK>),               //                                            .DACLRCK
		.audio_0_avalon_right_channel_sink_data           (<connected-to-audio_0_avalon_right_channel_sink_data>),           //           audio_0_avalon_right_channel_sink.data
		.audio_0_avalon_right_channel_sink_valid          (<connected-to-audio_0_avalon_right_channel_sink_valid>),          //                                            .valid
		.audio_0_avalon_right_channel_sink_ready          (<connected-to-audio_0_avalon_right_channel_sink_ready>),          //                                            .ready
		.audio_0_avalon_left_channel_sink_data            (<connected-to-audio_0_avalon_left_channel_sink_data>),            //            audio_0_avalon_left_channel_sink.data
		.audio_0_avalon_left_channel_sink_valid           (<connected-to-audio_0_avalon_left_channel_sink_valid>),           //                                            .valid
		.audio_0_avalon_left_channel_sink_ready           (<connected-to-audio_0_avalon_left_channel_sink_ready>)            //                                            .ready
	);

