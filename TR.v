module TR #(parameter size = 16 )(TR_OUT , TR_INP , LD , CLR , INC , CLK,reset);
  input LD, CLR, INC, CLK,reset;
  input [size -1 :0] TR_INP;
  output reg [size - 1:0] TR_OUT;

  
always @(negedge CLK, posedge reset) begin
  if (reset)begin
    TR_OUT <=0;
  end 
 else if (CLR) begin
      TR_OUT <= 0;  
    end 
    else if (LD) begin
      TR_OUT <= TR_INP;  
    end 
    else if (INC) begin
      TR_OUT <= TR_OUT + 1;  
    end
    else
      TR_OUT<=TR_OUT;
end

  
 
endmodule
