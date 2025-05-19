module Memory(data_out,address,data_in,Write,Read,clock,reset);
	input [11:0] address;
	input [15:0] data_in;
	input Write,Read,clock,reset;
	output [15:0]data_out;
	reg [15:0]data_out2;
	reg [15:0] memory [4095:0]; 
	integer i;
	initial begin
			
			for (i = 0; i < 4096; i = i + 1) begin
               		 memory[i] = 16'b0;
           		end
			$readmemh("instruction.txt",memory,1,2047); // instruction memory 
			$readmemh("data.txt",memory,2048,4095); // data memory 
	end
	
	always @(posedge clock,posedge reset) begin
	  if (reset)begin
		data_out2 = 16'b0;
  	  end 
	  else if(Write & (address != 12'b0)) begin // to prevent write data in location 0 into memory
		if( (address > 12'h7FF) )begin // (address > 0 and address < 2048 )to prevent write data into instruction area
			if((address < 12'hFFF) || (address == 12'hFFF)||(address == 12'h000))begin
	        		memory[address] <= data_in;
			end
		end 
	  end
	end
	assign data_out = (Read)? memory[address] :data_out2;
endmodule