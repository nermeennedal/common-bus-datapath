module E_FF(W,IN_E,OUT_E,reset,clock,rst);
	input W,IN_E,reset,clock,rst;
	output reg OUT_E;

	always @(negedge clock,posedge rst)begin
	  if(rst)begin
		OUT_E <= 1'b0;
	  end else
	  if(reset)  begin
		OUT_E <= 0;
	  end
	  else if(W)begin
		OUT_E <= IN_E;
	  end
	end
endmodule
