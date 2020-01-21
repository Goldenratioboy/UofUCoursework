	component audio_sample is
		port (
			clk_clk                                          : in    std_logic                     := 'X';             -- clk
			reset_reset_n                                    : in    std_logic                     := 'X';             -- reset_n
			audio_pll_0_audio_clk_clk                        : out   std_logic;                                        -- clk
			audio_and_video_config_0_external_interface_SDAT : inout std_logic                     := 'X';             -- SDAT
			audio_and_video_config_0_external_interface_SCLK : out   std_logic;                                        -- SCLK
			audio_0_external_interface_BCLK                  : in    std_logic                     := 'X';             -- BCLK
			audio_0_external_interface_DACDAT                : out   std_logic;                                        -- DACDAT
			audio_0_external_interface_DACLRCK               : in    std_logic                     := 'X';             -- DACLRCK
			audio_0_avalon_right_channel_sink_data           : in    std_logic_vector(15 downto 0) := (others => 'X'); -- data
			audio_0_avalon_right_channel_sink_valid          : in    std_logic                     := 'X';             -- valid
			audio_0_avalon_right_channel_sink_ready          : out   std_logic;                                        -- ready
			audio_0_avalon_left_channel_sink_data            : in    std_logic_vector(15 downto 0) := (others => 'X'); -- data
			audio_0_avalon_left_channel_sink_valid           : in    std_logic                     := 'X';             -- valid
			audio_0_avalon_left_channel_sink_ready           : out   std_logic                                         -- ready
		);
	end component audio_sample;

	u0 : component audio_sample
		port map (
			clk_clk                                          => CONNECTED_TO_clk_clk,                                          --                                         clk.clk
			reset_reset_n                                    => CONNECTED_TO_reset_reset_n,                                    --                                       reset.reset_n
			audio_pll_0_audio_clk_clk                        => CONNECTED_TO_audio_pll_0_audio_clk_clk,                        --                       audio_pll_0_audio_clk.clk
			audio_and_video_config_0_external_interface_SDAT => CONNECTED_TO_audio_and_video_config_0_external_interface_SDAT, -- audio_and_video_config_0_external_interface.SDAT
			audio_and_video_config_0_external_interface_SCLK => CONNECTED_TO_audio_and_video_config_0_external_interface_SCLK, --                                            .SCLK
			audio_0_external_interface_BCLK                  => CONNECTED_TO_audio_0_external_interface_BCLK,                  --                  audio_0_external_interface.BCLK
			audio_0_external_interface_DACDAT                => CONNECTED_TO_audio_0_external_interface_DACDAT,                --                                            .DACDAT
			audio_0_external_interface_DACLRCK               => CONNECTED_TO_audio_0_external_interface_DACLRCK,               --                                            .DACLRCK
			audio_0_avalon_right_channel_sink_data           => CONNECTED_TO_audio_0_avalon_right_channel_sink_data,           --           audio_0_avalon_right_channel_sink.data
			audio_0_avalon_right_channel_sink_valid          => CONNECTED_TO_audio_0_avalon_right_channel_sink_valid,          --                                            .valid
			audio_0_avalon_right_channel_sink_ready          => CONNECTED_TO_audio_0_avalon_right_channel_sink_ready,          --                                            .ready
			audio_0_avalon_left_channel_sink_data            => CONNECTED_TO_audio_0_avalon_left_channel_sink_data,            --            audio_0_avalon_left_channel_sink.data
			audio_0_avalon_left_channel_sink_valid           => CONNECTED_TO_audio_0_avalon_left_channel_sink_valid,           --                                            .valid
			audio_0_avalon_left_channel_sink_ready           => CONNECTED_TO_audio_0_avalon_left_channel_sink_ready            --                                            .ready
		);

