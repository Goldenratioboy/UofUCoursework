module bitgen_piano(bright, key,
	hCount, vCount,
	red, blue, green);

inout bright;
input [9:0] hCount, vCount;
input [7:0] key;

output reg[7:0] red;
output reg[7:0] green;
output reg[7:0] blue;

reg[3:0] i;

always@(*)
begin
//This will paint a piano
  if(~bright)
  begin
        /*BLACK*/
          red = 8'b0000_0000;
          blue = 8'b0000_0000;
          green = 8'b0000_0000;
  end

  else
  begin
    for(i = 1; i <= 8; i = i+1)
    begin
      if(vCount >= 239) //This means we're in bottom half of display, this is where piano will be
        begin
        if((hCount >= 78) && (hCount <= 80)) //This will draw the black lines in-between the white keys
        begin
        /*BLACK*/
				if(key == 8'h1D && vCount <= 400)
				begin
					red = 8'd160;
					blue = 8'd160;
					green = 8'd160;
				end	
				else
				begin
          			red = 8'b0000_0000;
          			blue = 8'b0000_0000;
          			green = 8'b0000_0000;
				end
        end

		else if((hCount >= 156) && (hCount <= 158))
        begin
        /*BLACK*/
					if(key == 8'h1D && vCount <= 400)
					begin
						red = 8'd160;
						blue = 8'd160;
						green = 8'd160;
					end
					else
					begin
						red = 8'b0000_0000;
						blue = 8'b0000_0000;
						green = 8'b0000_0000;
					end
			end
		  else if((hCount >= 234) && (hCount <= 236))
        begin
        /*BLACK*/
          red = 8'b0000_0000;
          blue = 8'b0000_0000;
          green = 8'b0000_0000;
			end
		  else if((hCount >= 312) && (hCount <= 314))
        begin
        /*BLACK*/
					if(key == 8'h24 && vCount <= 400)
					begin
						red = 8'd160;
						blue = 8'd160;
						green = 8'd160;
					end
					else
					begin
						red = 8'b0000_0000;
						blue = 8'b0000_0000;
						green = 8'b0000_0000;
					end
			end
		  else if((hCount >= 390) && (hCount <= 392))
        begin
        /*BLACK*/
					if(key == 8'h2C && vCount <= 400)
					begin
						red = 8'd160;
						blue = 8'd160;
						green = 8'd160;
					end
					else
					begin
						red = 8'b0000_0000;
						blue = 8'b0000_0000;
						green = 8'b0000_0000;
					end
			end
		  else if((hCount >= 468) && (hCount <= 470))
        begin
        /*BLACK*/
					if(key == 8'h1D && vCount <= 400)
					begin
						red = 8'd160;
						blue = 8'd160;
						green = 8'd160;
						end
					else
					begin
						red = 8'b0000_0000;
						blue = 8'b0000_0000;
						green = 8'b0000_0000;
						end
				end
		  else if((hCount >= 546) && (hCount <= 548))
        begin
        /*BLACK*/
          red = 8'b0000_0000;
          blue = 8'b0000_0000;
          green = 8'b0000_0000;
			end

			/*This section draws sharps and flats*/
		  else if((hCount >= 48) && (hCount <= 108) && (vCount <= 400))
        begin
			if(key == 8'h1D)
			begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			end
		  else
			begin
				/*BLACK*/
            red = 8'b0000_0000;
            blue = 8'b0000_0000;
            green = 8'b0000_0000;

			end
		  end

		  else if((hCount >= 126) && (hCount <= 186) && (vCount <= 400))
        begin
			if(key == 8'h24)
			begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			end
			else
			begin
				/*BLACK*/
            red = 8'b0000_0000;
            blue = 8'b0000_0000;
            green = 8'b0000_0000;

			end
		  end

			else if((hCount >= 282) && (hCount <= 342) && (vCount <= 400))
        begin
		  if(key == 8'h2C)
		  begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
		  end
		  else
		  begin
				/*BLACK*/
            red = 8'b0000_0000;
            blue = 8'b0000_0000;
            green = 8'b0000_0000;

		  end
			end
		  else if((hCount >= 360) && (hCount <= 420) && (vCount <= 400))
        begin
		  if(key == 8'h35)
		  begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
		  end
		  else
		  begin
				/*BLACK*/
            red = 8'b0000_0000;
            blue = 8'b0000_0000;
            green = 8'b0000_0000;

		  end
			end
		  else if((hCount >= 438) && (hCount <= 498) && (vCount <= 400))
        begin
		  if(key == 8'h3C)
		  begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
		  end
		  else
		  begin
				/*BLACK*/
            red = 8'b0000_0000;
            blue = 8'b0000_0000;
            green = 8'b0000_0000;

		  end
			end
			else if((hCount >= 594) && (vCount <= 400))
			begin
			 red = 8'b0000_0000;
          blue = 8'b0000_0000;
          green = 8'b0000_0000;
			end

        else
		  begin
          /*WHITE*/
          red = 8'b1111_1111;
          blue = 8'b1111_1111;
          green = 8'b1111_1111;

			 //Major Keys
			 if(key == 8'h1C && hCount <=77) //Highlight Music note C4
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
			 else if (key == 8'h1b && (hCount >= 78 && hCount <= 155))
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
			 else if (key == 8'h23 && (hCount >= 156 && hCount <= 233))
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
			 else if (key == 8'h2b && (hCount >= 234 && hCount <= 311))
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
			 else if (key == 8'h34 && (hCount >= 312 && hCount <= 389))
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
			 else if (key == 8'h33 && (hCount >= 390 && hCount <= 468))
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
			 else if (key == 8'h3b && (hCount >= 469 && hCount <= 545))
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
			 else if (key == 8'h42 && (hCount >= 546 && hCount <= 639))
			 begin
				red = 8'd160;
				blue = 8'd160;
				green = 8'd160;
			 end
        end
      end

      else //if vCount is in top half of display
      begin
        /*RED*/
        red = 8'd153;
        blue = 8'b0000_0000;
        green = 8'b0000_0000;
      end
	 end
	end

end

endmodule
