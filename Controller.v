module Controller #(
    parameter N = 3,
    localparam EMPTY = 2'b01,
    localparam COUNT = 2'b10,
    localparam FULL  = 2'b11
)(
    input clk,rst,
    input leave,enter,
    input t1,t2,t3,
    input [N-1:0] Pcount_C,
    output [1:0] Tcount_C,
    output reg UP_C,DOWN_C,
    output EN,
    output reg Empty_Flag,Full_Flag,
    output Empty_alert,Full_alert
);

    reg [1:0] cs,ns;

    always @(posedge clk) begin
        if (rst) begin
            cs <= EMPTY;
        end
        else begin
            cs <= ns;
        end
    end

    always @(*) begin
        ns = cs;
        UP_C = 1'b0;
        DOWN_C = 1'b0;
        Empty_Flag = 1'b0;
        Full_Flag = 1'b0;
        case (cs)
            EMPTY: begin
                Empty_Flag = 1'b1;
                Full_Flag = 1'b0;
                if (enter) begin
                    ns = COUNT;
                    UP_C = 1'b1;
                    DOWN_C = 1'b0;
                end
            end    
            COUNT: begin
                Empty_Flag = 1'b0;
                Full_Flag = 1'b0;
                if (enter && !leave) begin
                    UP_C = 1'b1;
                    DOWN_C = 1'b0;
                    if (Pcount_C == 6)begin
                        ns = FULL;
                    end    
                    else begin
                        ns = COUNT;
                    end
                end
                else if (leave && !enter) begin
                    UP_C = 1'b0;
                    DOWN_C = 1'b1;
                    if (Pcount_C == 1)begin
                        ns = EMPTY;
                    end    
                    else begin
                        ns = COUNT;
                    end
                end
                else begin
                    UP_C = 1'b0;
                    DOWN_C = 1'b0;
                    ns = COUNT;
                end
                // if (Pcount_C == 7) begin
                //     ns = FULL;
                //     UP_C = 1'b0;
                //     DOWN_C = 1'b0;
                // end
                // else if(Pcount_C == 0) begin
                //     ns = EMPTY;
                //     UP_C = 1'b0;
                //     DOWN_C = 1'b0;
                // end
                // else if(Pcount_C < 7) begin
                //     ns = COUNT;
                //     if (enter && !leave) begin
                //         UP_C = 1'b1;
                //         DOWN_C = 1'b0;
                //     end
                //     else if (leave && !enter) begin
                //         UP_C = 1'b0;
                //         DOWN_C = 1'b1;
                //     end
                //     else begin
                //         UP_C = 1'b0;
                //         DOWN_C = 1'b0;
                //     end   
                // end
            end    
            FULL: begin
                Empty_Flag = 1'b0;
                Full_Flag = 1'b1;
                if (leave) begin
                    ns = COUNT;
                    UP_C = 1'b0;
                    DOWN_C = 1'b1;
                end
            end    
        endcase
    end

    assign Empty_alert = ((cs == EMPTY) && leave)? 1'b1 : 1'b0;
    assign Full_alert = ((cs == FULL) && enter)? 1'b1 : 1'b0;
    assign EN = UP_C | DOWN_C;
    assign Tcount_C = t1 + t2 + t3;

endmodule