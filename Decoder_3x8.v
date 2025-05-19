module Decoder_3x8 (decoded_input , decoded_output );
    input [2:0] decoded_input ;  // 3-bit binary input
    output reg [7:0] decoded_output ;// 8-bit decoded output


    always @(*) begin
        // initialize all outputs to 0
        decoded_output = 8'b00000000;

        // use the decoded input as an index to set the corresponding output bit to 1
        case (decoded_input)
            3'b000: decoded_output = 8'b00000001;
            3'b001: decoded_output = 8'b00000010;
            3'b010: decoded_output = 8'b00000100;
            3'b011: decoded_output = 8'b00001000;
            3'b100: decoded_output = 8'b00010000;
            3'b101: decoded_output = 8'b00100000;
            3'b110: decoded_output = 8'b01000000;
            3'b111: decoded_output = 8'b10000000;
            default: decoded_output = 8'b00000000; // default case
        endcase
    end

endmodule
