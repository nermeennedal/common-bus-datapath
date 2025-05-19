
module FGO(SET,OUT_FGO,reset,clock,rst);
	input SET,reset,clock,rst;
	output reg OUT_FGO;

	always @(negedge clock,posedge rst)begin
	  if(rst)begin
		OUT_FGO <= 1'b0;
	  end else
	  if(reset)  begin
		OUT_FGO <= 1'b0;
	  end
	  else if(SET)begin
		OUT_FGO <= 1'b1;	
	  end
	end
endmodule