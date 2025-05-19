module DR #(parameter size = 16 ) (DR_OUT , CLK , CLR , LD ,INC , DR_INP,reset);    
input CLK , CLR , LD ,INC ,reset;
input [size -1 :0] DR_INP ;
output reg [size -1 :0] DR_OUT ;

always @(negedge CLK,posedge reset) begin
   if (reset)begin
    DR_OUT <= 0;
   end
    else if (CLR) begin 
        DR_OUT <= 0;
    end 
    
    else if (LD) begin
        DR_OUT <= DR_INP ; 
    end
    
    else if(INC) begin
        DR_OUT <= DR_OUT + 1;  
    end 
    else
    DR_OUT <= DR_OUT ;
    end
endmodule


