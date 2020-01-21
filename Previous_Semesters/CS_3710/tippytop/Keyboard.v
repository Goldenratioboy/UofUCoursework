module Keyboard (clk, data, note);

input clk, data;
output reg [7:0] note;
reg flag;
reg noteKill;
reg [3:0] b;
reg [7:0] data_pre, data_curr, killedData;


initial
begin
  b <= 4'h1;
  flag <= 1'b0;
  data_curr <= 8'hf0;
  data_pre <= 8'hf0;
  note <= 8'hf0;
  noteKill <= 1'b0;
end

always@(negedge clk)
begin
  
  case(b)
  1:;
  2:data_curr[0] <= data;
  3:data_curr[1] <= data;
  4:data_curr[2] <= data;
  5:data_curr[3] <= data;
  6:data_curr[4] <= data;
  7:data_curr[5] <= data;
  8:data_curr[6] <= data;
  9:data_curr[7] <= data;
  10:flag<=1'b1; //Parity bit
  11:flag<=1'b0; //End bit

  endcase

    if(b<=10)
    begin
      b<=b+1;
    end
    else if(b==11)
    begin
      b<=1;
    end

end

always@(posedge flag) //Printing data
begin
  if(data_curr==8'hf0)
  begin
    note <= 8'hf0;
	 killedData <= data_pre;
  end
  else
  begin
    data_pre<=data_curr;
	 if(data_curr == killedData)
	 begin
		note <= 8'hf0;
	 end
	 else 
	 begin
		note <= data_curr;
	 end
	 
  end
end

endmodule