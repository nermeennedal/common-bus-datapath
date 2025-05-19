module Archi_CPU_Team6(clock,reset,out1,out2,out3,out4,AC_Switch,IR_Switch,DR_Switch);
	input clock,reset;
	wire [15:0]AC_OUT,IR_OUT,DR_OUT,OUT;
	output [6:0] out1,out2,out3,out4;
	wire clock_out;
	output AC_Switch,IR_Switch,DR_Switch;
	wire [1:0]SEL;
	assign SEL = (AC_Switch)?2'b00:(DR_Switch)?2'b10:(IR_Switch)?2'b01:2'b11;
	CPU_Team6 UUT(.clock(clock),.reset(reset),.AC_OUT(AC_OUT),.IR_OUT(IR_OUT),.DR_OUT(DR_OUT));
	Clock_divider(.clock_in(clock),.clock_out(clock_out),.reset(reset),.enable(0));
	
	Mux4_1 #(16) MUX1(.IN0(AC_OUT), .IN1(IR_OUT), .IN2(DR_OUT), .IN3(16'hFFFE), .S0(SEL[0]), .S1(SEL[1]), .OUT(OUT));
	
	decoder_4_16 D1(.in(OUT[3:0]),.out(out1));
	
	decoder_4_16 D2(.in(OUT[7:4]),.out(out2));
	
	decoder_4_16 D3(.in(OUT[11:8]),.out(out3));

	decoder_4_16 D4(.in(OUT[15:12]),.out(out4));
	
endmodule