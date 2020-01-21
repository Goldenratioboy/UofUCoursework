// audio_sample.v

// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module audio_sample (
		input  wire [15:0] audio_0_avalon_left_channel_sink_data,            //            audio_0_avalon_left_channel_sink.data
		input  wire        audio_0_avalon_left_channel_sink_valid,           //                                            .valid
		output wire        audio_0_avalon_left_channel_sink_ready,           //                                            .ready
		input  wire [15:0] audio_0_avalon_right_channel_sink_data,           //           audio_0_avalon_right_channel_sink.data
		input  wire        audio_0_avalon_right_channel_sink_valid,          //                                            .valid
		output wire        audio_0_avalon_right_channel_sink_ready,          //                                            .ready
		input  wire        audio_0_external_interface_BCLK,                  //                  audio_0_external_interface.BCLK
		output wire        audio_0_external_interface_DACDAT,                //                                            .DACDAT
		input  wire        audio_0_external_interface_DACLRCK,               //                                            .DACLRCK
		inout  wire        audio_and_video_config_0_external_interface_SDAT, // audio_and_video_config_0_external_interface.SDAT
		output wire        audio_and_video_config_0_external_interface_SCLK, //                                            .SCLK
		output wire        audio_pll_0_audio_clk_clk,                        //                       audio_pll_0_audio_clk.clk
		input  wire        clk_clk,                                          //                                         clk.clk
		input  wire        reset_reset_n                                     //                                       reset.reset_n
	);

	wire    rst_controller_reset_out_reset; // rst_controller:reset_out -> [audio_0:reset, audio_and_video_config_0:reset]

	audio_sample_audio_0 audio_0 (
		.clk                          (clk_clk),                                 //                         clk.clk
		.reset                        (rst_controller_reset_out_reset),          //                       reset.reset
		.from_adc_left_channel_ready  (),                                        //  avalon_left_channel_source.ready
		.from_adc_left_channel_data   (),                                        //                            .data
		.from_adc_left_channel_valid  (),                                        //                            .valid
		.from_adc_right_channel_ready (),                                        // avalon_right_channel_source.ready
		.from_adc_right_channel_data  (),                                        //                            .data
		.from_adc_right_channel_valid (),                                        //                            .valid
		.to_dac_left_channel_data     (audio_0_avalon_left_channel_sink_data),   //    avalon_left_channel_sink.data
		.to_dac_left_channel_valid    (audio_0_avalon_left_channel_sink_valid),  //                            .valid
		.to_dac_left_channel_ready    (audio_0_avalon_left_channel_sink_ready),  //                            .ready
		.to_dac_right_channel_data    (audio_0_avalon_right_channel_sink_data),  //   avalon_right_channel_sink.data
		.to_dac_right_channel_valid   (audio_0_avalon_right_channel_sink_valid), //                            .valid
		.to_dac_right_channel_ready   (audio_0_avalon_right_channel_sink_ready), //                            .ready
		.AUD_BCLK                     (audio_0_external_interface_BCLK),         //          external_interface.export
		.AUD_DACDAT                   (audio_0_external_interface_DACDAT),       //                            .export
		.AUD_DACLRCK                  (audio_0_external_interface_DACLRCK)       //                            .export
	);

	audio_sample_audio_and_video_config_0 audio_and_video_config_0 (
		.clk         (clk_clk),                                          //                    clk.clk
		.reset       (rst_controller_reset_out_reset),                   //                  reset.reset
		.address     (),                                                 // avalon_av_config_slave.address
		.byteenable  (),                                                 //                       .byteenable
		.read        (),                                                 //                       .read
		.write       (),                                                 //                       .write
		.writedata   (),                                                 //                       .writedata
		.readdata    (),                                                 //                       .readdata
		.waitrequest (),                                                 //                       .waitrequest
		.I2C_SDAT    (audio_and_video_config_0_external_interface_SDAT), //     external_interface.export
		.I2C_SCLK    (audio_and_video_config_0_external_interface_SCLK)  //                       .export
	);

	audio_sample_audio_pll_0 audio_pll_0 (
		.ref_clk_clk        (clk_clk),                   //      ref_clk.clk
		.ref_reset_reset    (~reset_reset_n),            //    ref_reset.reset
		.audio_clk_clk      (audio_pll_0_audio_clk_clk), //    audio_clk.clk
		.reset_source_reset ()                           // reset_source.reset
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
