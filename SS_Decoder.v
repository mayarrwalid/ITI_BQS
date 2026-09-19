module SS_Decoder #(
    parameter N = 4
)(
    input [N-1:0] A,
    output reg [6:0] OUT
);

always @(*) begin
        case (A)
            0 : OUT = 7'b1111110;
            1 : OUT = 7'b0110000;
            2 : OUT = 7'b1101101;
            3 : OUT = 7'b1111001;
            4 : OUT = 7'b0110011;
            5 : OUT = 7'b1011011;
            6 : OUT = 7'b1011111;
            7 : OUT = 7'b1110000;
            8 : OUT = 7'b1111111;
            9 : OUT = 7'b1111011;
            default: OUT = 7'b1111111;
        endcase
    end 
endmodule