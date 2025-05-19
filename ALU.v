module ALU(  ALU_Operation , AC_INP ,  DR_INP , INPR , AC_OUT , OUT_E,IN_E );

    input [3:0] ALU_Operation ;
    input [15:0] AC_INP , DR_INP;
    input [7:0] INPR ;
    output reg [15:0] AC_OUT ;
    output reg OUT_E ;
    input  IN_E ; 
    wire [16:0]result ;
    assign result = AC_INP +DR_INP;
    always @(*) begin
         case (ALU_Operation)
           4'b0000 : AC_OUT = AC_INP & DR_INP ; // AND operation (AC & DR) 
           4'b0001 :begin
			 AC_OUT = result[15:0];
			 OUT_E = result[16];
			end // ADD operation (AC + DR)
           4'b0010 : AC_OUT = DR_INP ; // LOAD DR Value to AC 
           4'b0011 : AC_OUT = ~ AC_INP; // COMPLEMENT AC =(~AC)
           
           4'b0100 : begin  // CIRCULATE AC AND E TO THE RIGHT 
                          AC_OUT = {IN_E , AC_INP[15:1]};
                          OUT_E = AC_INP[0];     
                    end
           
           
           4'b0101 : begin   // CIRCULATE AC AND E TO THE LEFT 
                          AC_OUT = {AC_INP[14:0] , IN_E};
                          OUT_E = AC_INP[15];     
                    end
                 
           4'b0110 : AC_OUT = {8'b0 ,  INPR } ; // Load INPR value to AC    
           4'b0111 : OUT_E = ~IN_E ; // complement E 
           4'b1000 : OUT_E = 1'b0; // CLEAR E;
     		default AC_OUT = 0;
 	    endcase
    end
endmodule







