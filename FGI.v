
module FGI(SET,OUT_FGI,reset,clock,rst);
	input SET,reset,clock,rst;
	output reg OUT_FGI;

	always @(negedge clock,posedge rst)begin
	  if(rst)begin
		OUT_FGI <= 1'b0;
	  end else
	  if(reset)  begin
		OUT_FGI <= 1'b0;
	  end
	  else if(SET)begin
		OUT_FGI <= 1'b1;	
	  end
	end
endmodule