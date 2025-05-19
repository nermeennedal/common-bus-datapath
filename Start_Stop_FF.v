module Start_Stop_FF(SET,OUT_Start_Stop_FF,reset,clock);
	input SET,reset,clock;
	output reg OUT_Start_Stop_FF;

	always @(negedge clock)begin
	  if(reset)  begin
		OUT_Start_Stop_FF <= 1'b0;
	  end
	  else if(SET)begin
		OUT_Start_Stop_FF <= 1'b1;	
	  end
	end
endmodule
