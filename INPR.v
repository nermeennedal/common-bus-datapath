module INPR #(parameter size = 8) (INPR_OUT , INPR_INP , CLK,reset ) ;
 input CLK ,reset;
 output reg  [size-1:0] INPR_OUT;
 input [size-1:0] INPR_INP;

 always @(negedge CLK,posedge reset) begin 
  if (reset)begin
   INPR_OUT <=8'h00;
  end else
   INPR_OUT <= INPR_INP ;
 end

 endmodule
 
 
 
 