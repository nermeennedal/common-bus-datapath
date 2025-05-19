module IR #(parameter size = 16 ) (IR_OUT ,IR_INP ,LD , CLK ,reset);
input CLK ,LD ,reset;
input [size-1:0] IR_INP ;
output reg [size-1:0] IR_OUT ;


  
always @(negedge CLK, posedge reset) begin   
  if (reset) begin
	IR_OUT = 0;
  end 
  else if (LD) begin
        IR_OUT = IR_INP ;
   end
end


endmodule

