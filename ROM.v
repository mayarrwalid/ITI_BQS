module ROM (
    input [4:0] Addr,
    input clk_R,rst_R,
    output reg [6:0] Wtime_R
);

    reg [6:0] rom [31:0];

    always @(posedge clk_R) begin
        if (rst_R) begin
            Wtime_R <= 0;
        end
        else 
            Wtime_R <= rom[Addr];
        end

    initial begin
        $readmemh("ROM.txt",rom);
    end
endmodule