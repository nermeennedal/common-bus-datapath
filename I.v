module I(Enable,reset,OUT_I,SET,IN_I,clock,rst);
	input Enable,reset,SET,IN_I,clock,rst;
	output reg OUT_I;

	always @(negedge clock,posedge rst)begin
	  if(rst)begin
		OUT_I <= 1'b0;
	  end else	  
	  if(reset)  begin
		OUT_I = 0;
	  end
	  else if(Enable)begin
		OUT_I =IN_I;
	  end
	  else if(SET)begin
		OUT_I =1'b1;
	  end
	end
endmodule
