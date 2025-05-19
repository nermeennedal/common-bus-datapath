module AR #(parameter size = 12) (AR_OUT  , CLR , LD ,INC , AR_INP , CLK,reset);   
input CLK , CLR , LD ,INC ,reset;
input [size-1 :0] AR_INP ;
output reg[size-1:0] AR_OUT ;


always @(negedge CLK, posedge reset) begin
    if (reset)begin
    	AR_OUT <=0;
    end 
    else if (CLR) begin 
        AR_OUT <= 0;
    end 
    else if (LD) begin
        AR_OUT <= AR_INP ; 
    end
    
    else if(INC) begin
        AR_OUT <= AR_OUT + 1;  
    end 
    else
    	AR_OUT<= AR_OUT;
end

    
endmodule


