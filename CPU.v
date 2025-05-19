module CPU_Team6(clock,reset,AC_OUT,IR_OUT,DR_OUT);
	input clock,reset;
	wire [6:0]LD;
	wire [5:0]INC,CLR,RESET_FF,SET;
	wire [2:0]SEL;
	wire [3:0]aluop;
	wire Write_memory,Read_memory, OUT_E,OUT_FGI,OUT_FGO,OUT_INE;
	wire [1:0]Enable;
	//wire [15:0]AC_OUT,DR_OUT,IR_OUT;
	output [15:0]AC_OUT,IR_OUT,DR_OUT;
DataPath Datapath_team6(.clock(clock),.reset(reset),
		 .LD_AR(LD[6]),.LD_PC(LD[5]),.LD_DR(LD[4]),.LD_IR(LD[3]),.LD_TR(LD[2]),.LD_OUTR(LD[1]),.LD_AC(LD[0]),
		 .INC_AR(INC[4]),.INC_PC(INC[3]),.INC_DR(INC[2]),.INC_TR(INC[1]),.INC_AC(INC[0]),
		 .CLR_AR(CLR[4]),.CLR_PC(CLR[3]),.CLR_DR(CLR[2]),.CLR_TR(CLR[1]),.CLR_AC(CLR[0]),
		 .Write_memory(Write_memory),.Read_memory(Read_memory),
		 .Sel(SEL),.aluop(aluop), 
		 .Write_E(Enable[0]),.OUT_E(OUT_E),
		 .SET_FGI(SET[2]),.SET_FGO(SET[3]),.reset_FGO(RESET_FF[4]),.reset_FGI(RESET_FF[3]),.OUT_FGO(OUT_FGO),.OUT_FGI(OUT_FGI),//EDIT
		 .SET_INE(SET[0]),.reset_INE(RESET_FF[0]),.OUT_INE(OUT_INE),
		 .DR_OUT(DR_OUT),.AC_OUT(AC_OUT),.IR_OUT(IR_OUT));

Control_Unit CU_Team6(.clock(clock),.reset(reset) , .FGO(OUT_FGO) ,.FGI(OUT_FGI) ,.E(OUT_E) ,.S() ,.IEN(OUT_INE),.AC(AC_OUT) ,.DR(DR_OUT),
		      .IR(IR_OUT),.INC(INC),.CLR(CLR),.LD(LD),.ALU_OP(aluop),.SEL(SEL),
		      .MEM_Write(Write_memory),.MEM_Read(Read_memory),.Enable(Enable),.RESET_FF(RESET_FF),.SET(SET));

endmodule