module tonegen (
		input clk,
		input reset,
		input left_chan_ready,
		input right_chan_ready,
		input [7:0] key,
		output reg sample_valid,
		output reg [15:0] data_out
	);

//declare the sine ROM - 30 registers each 16 bit wide.  
    reg [15:0] sine [0:29];
	 
	 reg slwclk = 0;
	 reg [10:0] count = 0;
	 reg [24:0] freq = 0;

//Internal signals  
    integer i;
	 
//Parameters
	parameter A4 = 8'h33;
	parameter B4 = 8'h3B;
	parameter C4 = 8'h1C;
	parameter D4 = 8'h1B;
	parameter E4 = 8'h23;
	parameter F4 = 8'h2B;
	parameter G4 = 8'h34;
	parameter C5 = 8'h42;
	
	parameter CS = 8'h1D;
	parameter DS = 8'h24;
	parameter FS = 8'h2C;
	parameter GS = 8'h35;
	parameter AS = 8'h3C;
	
	parameter ctrl = 8'h14;

//Initialize the sine rom with samples. 
    initial begin
        i = 0;
        sine[0] = 0;
        sine[1] = 16;
        sine[2] = 31;
        sine[3] = 45;
        sine[4] = 58;
        sine[5] = 67;
        sine[6] = 74;
        sine[7] = 77;
        sine[8] = 77;
        sine[9] = 74;
        sine[10] = 67;
        sine[11] = 58;
        sine[12] = 45;
        sine[13] = 31;
        sine[14] = 16;
        sine[15] = 0;
        sine[16] = -16;
        sine[17] = -31;
        sine[18] = -45;
        sine[19] = -58;
        sine[20] = -67;
        sine[21] = -74;
        sine[22] = -77;
        sine[23] = -77;
        sine[24] = -74;
        sine[25] = -67;
        sine[26] = -58;
        sine[27] = -45;
        sine[28] = -30;
        sine[29] = -16;
    end
	 
	 always@ (posedge(clk))
	 begin
		if (count == freq)
		begin
			slwclk <= ~slwclk;
			count <= 0;
		end
		else
		begin
			count <= count + 1;
		end
	 end
	 
	 always@ (posedge(clk))
	 begin
		case(key)
			A4: freq <= 950;
			B4: freq <= 850;
			C4: freq <= 1600;
			D4: freq <= 1400;
			E4: freq <= 1300;
			F4: freq <= 1200;
			G4: freq <= 1100;
			C5: freq <= 800;
			
			CS: freq <= 1500;
			DS: freq <= 1350;
			FS: freq <= 1150;
			GS: freq <= 1024;
			AS: freq <= 900;

			default: freq <= 100000; 
		endcase
	end
    
    //At every positive edge of the clock, output a sine wave sample.
    always@ (posedge(slwclk))
    begin
    	if (~reset || (key == ctrl)) 
    	begin
    		data_out <= 0;
			sample_valid <= 0;
    	end
    	else
    	begin
    		if(left_chan_ready && right_chan_ready)
    		begin
				sample_valid <= 1;
        		data_out <= sine[i]*15;
        		i <= i + 1;
        		if(i == 29)
            		i <= 0;
         end
			else
			begin
				sample_valid <= 0;
				data_out <= 0;
		   end
      end
	end

endmodule 