
module INE(SET,OUT_INE,reset,clock,rst);
	input SET,reset,clock,rst;
	output reg OUT_INE;

	always @(negedge clock,posedge rst)begin
	  if(rst)begin
		OUT_INE = 1'b0;
	  end else
	  if(reset)  begin
		OUT_INE = 1'b0;
	  end
	  else if(SET)begin
		OUT_INE = 1'b1;
	  end
	end
endmodule
