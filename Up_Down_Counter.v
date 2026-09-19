module UP_DOWN_Counter #(
    parameter N = 3
)(
    input clk_c,rst_c,
    input UP,DOWN,enable_c,
    output reg [N-1:0] count
);

always @(posedge clk_c) begin
    if (rst_c) begin
        count <= 0;
    end
    else if (enable_c) begin
        if((UP) && (count != {N{1'b1}})) begin
            count <= count + 1;
        end
        else if((DOWN) && (count != {N{1'b0}})) begin
            count <= count - 1;
        end
    end
end
endmodule 

