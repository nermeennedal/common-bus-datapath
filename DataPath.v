module DataPath (clock,reset,
		 LD_AR,LD_PC,LD_DR,LD_IR,LD_TR,LD_OUTR,LD_AC,
		 INC_AR,INC_PC,INC_DR,INC_TR,INC_AC,
		 CLR_AR,CLR_PC,CLR_DR,CLR_TR,CLR_AC,
		 Write_memory,Read_memory,
		 Sel,aluop, 
		 Write_E,OUT_E,
		 SET_FGI,SET_FGO,reset_FGO,reset_FGI,OUT_FGO,OUT_FGI,
		 SET_INE,reset_INE,OUT_INE,
		 DR_OUT,AC_OUT,IR_OUT);
 input clock,reset;
 
 input LD_AR,LD_PC,LD_DR,LD_IR,LD_TR,LD_OUTR,LD_AC;

 input INC_AR,INC_PC,INC_DR,INC_TR,INC_AC;

 input CLR_AR,CLR_PC,CLR_DR,CLR_TR,CLR_AC;

 input Write_memory,Read_memory;

 input Write_E;
 input [2:0] Sel;

 input [3:0] aluop;
 input SET_FGI,SET_FGO,reset_FGO,reset_FGI ,SET_INE,reset_INE;

 output OUT_E,OUT_FGO,OUT_FGI,OUT_INE;
 output [15:0] DR_OUT,AC_OUT,IR_OUT;
 wire IN_E;
 wire [15:0] MEM_BUS , IR_BUS , TR_BUS , BUS_OUT ,ALU_RES;
 
 wire [11:0] AR_BUS , PC_BUS ; 

 wire [7:0] INPR_ALU;

 FGO FGO_FF(.SET(SET_FGO),.OUT_FGO(OUT_FGO),.reset(reset_FGO),.clock(clock),.rst(reset));
 FGI FGI_FF(.SET(SET_FGI),.OUT_FGI(OUT_FGI),.reset(reset_FGI),.clock(clock),.rst(reset));

 AR AR_register(.AR_OUT(AR_BUS) , .CLR(CLR_AR) , .LD(LD_AR) ,.INC(INC_AR) , .AR_INP(BUS_OUT[11:0]) , .CLK(clock),.reset(reset)); 

 DR DR_register (.DR_OUT(DR_OUT) , .CLK(clock) , .CLR(CLR_DR) , .LD(LD_DR) ,.INC(INC_DR) , .DR_INP(BUS_OUT),.reset(reset));

 TR TR_register (.TR_OUT(TR_BUS) , .TR_INP(BUS_OUT) , .LD(LD_TR) , .CLR(CLR_TR) , .INC(INC_TR) , .CLK(clock),.reset(reset));

 IR IR_register (.IR_OUT(IR_OUT) ,.IR_INP(BUS_OUT) ,.LD(LD_IR) , .CLK(clock),.reset(reset));
 
 
 AC AC_register(.AC_OUT(AC_OUT) , .CLK(clock) , .CLR(CLR_AC) , .LD(LD_AC) ,.INC(INC_AC) , .AC_INP(ALU_RES),.reset(reset));

 PC PC_register(.PC_OUT(PC_BUS) , .PC_INP(BUS_OUT[11:0]) , .LD(LD_PC) , .CLR(CLR_PC) , .INC(INC_PC) , .CLK(clock),.reset(reset));
 
 
 Memory MEM (.data_out(MEM_BUS),.address(AR_BUS),.data_in(BUS_OUT),.Write(Write_memory),.Read(Read_memory),.clock(clock),.reset(reset));

 INPR INPR_register (.INPR_OUT(INPR_ALU) , .INPR_INP(8'hff) , .CLK(clock),.reset(reset) );

 OUTR OUTR_register (.OUTR_OUT() , .OUTR_INP(BUS_OUT[7:0]) ,.LD(LD_OUTR) ,.CLK(clock),.reset(reset) );

 BUS BUS_mux(.Sel(Sel) , .INP_1(AR_BUS) ,.INP_2(PC_BUS) , 
	 .INP_3(DR_OUT), .INP_4(AC_OUT) , .INP_5(IR_OUT),.INP_6(TR_BUS),
	 .INP_7(MEM_BUS),.OUT(BUS_OUT));

 ALU alu( .ALU_Operation(aluop) , .AC_INP(AC_OUT) ,  .DR_INP(DR_OUT) , .INPR(INPR_ALU) , .AC_OUT(ALU_RES) , .OUT_E(IN_E),.IN_E(OUT_E) );
 
 E_FF E(.W(Write_E),.IN_E(IN_E),.OUT_E(OUT_E),.reset(reset),.clock(clock),.rst(reset));

 INE INE_Team6(.SET(SET_INE),.OUT_INE(OUT_INE),.reset(reset_INE),.clock(clock),.rst(reset));
 
endmodule 
