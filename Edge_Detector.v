module Edge_Detector (
    input clk_ED,rst_ED,sig,
    output pulse
);    
    reg sig_dly;

    always @(posedge clk_ED or posedge rst_ED) begin
        if (rst_ED) begin
            sig_dly <= 1'b0;
        end
        else begin
            sig_dly <= sig;
        end
    end

    assign pulse = sig & ~sig_dly;

endmodule