module TB_CPU_Team6;

	reg clock,reset;
	CPU_Team6 UUT(.clock(clock),.reset(reset));

	initial begin
		clock = 0;
		reset = 1;
		#4 reset = 0;
		#1000 $stop;
	end
	
	always #5 clock = ~clock;

endmodule
