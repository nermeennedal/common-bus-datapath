module PC #(parameter size = 12 ) (PC_OUT , PC_INP , LD , CLR , INC , CLK,reset);
  input LD, CLR, INC, CLK,reset;
  input [size-1:0] PC_INP;
  output reg [size-1 : 0] PC_OUT;
  
  
always @(negedge CLK ,posedge reset) begin
  if (reset)begin
    PC_OUT <= 12'h1;
  end 
 else if (CLR) begin
      PC_OUT <= 12'b0;  
    end 
    else if (LD) begin
      PC_OUT <= PC_INP;  
    end 
    else if (INC) begin
      PC_OUT <= PC_OUT + 1;  
    end
    else 
      PC_OUT <= PC_OUT;
end


 
endmodule

  
  
