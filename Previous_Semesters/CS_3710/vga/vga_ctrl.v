module vga_ctrl(clk, reset,
	hSync, vSync, bright,
	hCount, vCount,
	slow_out);
	
	
input clk, reset;
reg q,slw_clk;
//reg clear = 0;

output reg hSync, vSync, bright;


output reg[9:0] hCount = 0;
output reg[9:0] vCount = 0;
output reg slow_out;

/*This section is a 50 MHz / 2 = 25 MHz clock*/	
always@(posedge clk)
begin
	if (reset)
	begin
		q <= 1'b0;
	end
	else
	begin
		q <= ~q;
		slw_clk <= q;
		slow_out <= q;
	end
end

always@(posedge slw_clk)
begin
		if(reset)
		begin
			hCount <= 0;
			vCount <= 0;
		end
		
		//Increment vCount during pulse width
		if(hCount == 799)
		begin
			vCount <= vCount + 1'b1;
			
			if(vCount == 520)
			begin
				vCount <= 0;
			end
		end

		//Resets hCount
		if(hCount == 799)
		begin
			hCount <= 0;
		end


		/*Either in PulseWidth, BP, FP, or Display*/
		/*Pulse Width*/
		if(hCount >= 656 && hCount <= 751) //657 -> 751 (96 clocks)
		begin
			hSync <= 0;
			bright <= 0;
		end
		/*Back Porch*/
		else if(hCount >= 752 && hCount <= 799) //754 -> 800 (48 clocks)
		begin
			hSync <= 1;
			bright <= 0;
		end
		/*Display*/
		else if(hCount <= 639) //hCount will count 0 - 639
		begin
			hSync <= 1;
			
			if (vSync == 0)
			begin
				bright <= 0;
			end
			else
			begin
				bright <= 1;
			end
		end
		/*Front Porch*/
		else if(hCount >= 640 && hCount <= 655) //640 -> 656 (16 clocks)
		begin
			hSync <= 1;
			bright <= 0;
		end

		hCount <= hCount + 1'b1;
		
	end




/*We'll use the line count to manipulate vSync based on vCount*/
always @(posedge slw_clk)
begin			
			
			/*Either in Pulse Width, BP, FP, or Display*/
			/*Pulse Width*/
			if(vCount >= 490 && vCount <= 491) //vCount will count 490 -> 491 (2 lines)
			begin
				vSync <= 0;
			end
			/*Back Porch*/
			else if(vCount >= 492 && vCount <= 520) //vCount will count 492 -> 520
			begin
				vSync <= 1;
			end
			/*Display*/
			else if(vCount <= 479) //vCount will count 0 - 479 (480 lines)
			begin
				vSync <= 1;
			end
			/*Front Porch*/
			else if (vCount >= 480 && vCount <= 489) //vCount will count 480 -> 489 (10 lines)
			begin
				vSync <= 1;
			end
end
	
endmodule

