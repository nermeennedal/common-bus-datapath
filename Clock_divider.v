module Clock_divider(clock_in,clock_out,reset,enable);
input clock_in,reset; // input clock on FPGA
input enable;
output reg clock_out; // output clock after dividing the input clock by divisor


    reg [22:0] counter; // 13-bit counter (log2(5000) = ~12.3)

    always @(posedge clock_in or posedge reset) begin
        if (reset) begin
            counter <= 0;         // Reset counter
            clock_out <= 0;       // Reset output clock
        end 
		  else if(enable)begin
				counter <= 0;         // Reset counter
            clock_out <= 0;       // Reset output clock
		  end
		  
		  else begin
            if (counter == 4_999_999) begin
                counter <= 0;     // Reset counter
                clock_out <= ~clock_out; // Toggle the output clock
            end else begin
                counter <= counter + 23'b1; // Increment counter
            end
        end
    end
endmodule