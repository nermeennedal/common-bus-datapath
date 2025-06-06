module Control_Unit(clock,reset , FGO , FGI , E , S , IEN,AC , DR,IR,INC,CLR,LD,ALU_OP,SEL,MEM_Write,MEM_Read,Enable,RESET_FF,SET);
	input clock,reset;
	input  FGO , FGI , E , S , IEN ;
	input [15:0] AC , DR,IR;
	output [5:0]INC,CLR;
	output [6:0]LD;
	output [3:0]ALU_OP;
	output [2:0]SEL;
	output MEM_Write,MEM_Read;
	output [1:0]Enable;
	output [5:0]RESET_FF,SET;
	wire [15:0] T;
	wire [7:0] D;
	wire [3:0]COUNT;
	wire OUT_I;
	wire OUT_R;

	Decoder_3x8 DEC_Team6(.decoded_input(IR[14:12]),.decoded_output(D));

	Decoder_4x16 DEC2_Team6(.decoded_input(COUNT),.decoded_output(T));

	Sequence_Counter SC_Team6(.CLK(clock) ,.CLR(CLR[5]) ,.INC(INC[5]) ,.COUNT(COUNT),.reset(reset));
	
	I I_Team6(.Enable(Enable[1]),.reset(RESET_FF[5]),.OUT_I(OUT_I),.SET(SET[4]),.IN_I(IR[15]),.clock(clock),.rst(reset));

	R R_FF(.SET(SET[1]),.OUT_R(OUT_R),.reset(RESET_FF[1]),.clock(clock),.rst(reset));

	Control_Logic_Gate CLG_Team6(.I(OUT_I),.R(OUT_R),.FGO(FGO) ,.FGI(FGI),.E(E),.S(S),.IEN(IEN),.AC(AC),.DR(DR),.D(D),    
   	.T(T),.IR(IR[11:0]),.LD(LD),.INC(INC),.CLR(CLR),.MEM_Read(MEM_Read) ,.MEM_Write(MEM_Write),  
        .SET(SET),.RESET_FF(RESET_FF),.Enable(Enable),.SEL(SEL),.ALU_OPCODE(ALU_OP));

endmodule
