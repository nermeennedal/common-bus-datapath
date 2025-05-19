module BUS(Sel,INP_1,INP_2,INP_3,INP_4,INP_5,INP_6,INP_7,OUT);

	input [15:0]INP_3,INP_4,INP_5,INP_6,INP_7;
	input [11:0]INP_1,INP_2; 
	
	output reg[15:0]OUT;

	input [2:0]Sel;
	

	always @(*) begin //MUX bus
		case(Sel)
		  3'b001 : OUT = {4'b0,INP_1};// INP1 for AR
		  3'b010 : OUT = {4'b0,INP_2};// INP2 for PC
		  3'b011 : OUT = INP_3;	      //INP3 for DR
		  3'b100 : OUT = INP_4;       //INP4 for AC
		  3'b101 : OUT = INP_5;       //INP5 for IR
		  3'b110 : OUT = INP_6;	      //INP6 for TR
		  3'b111 : OUT = INP_7;       //INP7 for MEMORY
		  default OUT =0;
		endcase
	end
endmodule