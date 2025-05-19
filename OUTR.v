module OUTR #(parameter size = 8) (OUTR_OUT , OUTR_INP ,LD ,CLK ,reset) ;
 output reg [size-1 :0] OUTR_OUT;
 input [size-1 :0] OUTR_INP;
 input LD , CLK ,reset;

 always @(negedge CLK,posedge reset) begin 
   if (reset)begin
   OUTR_OUT <= 0;	
   end else
   if(LD) begin 
      OUTR_OUT <= OUTR_INP;
   end
 end

endmodule
