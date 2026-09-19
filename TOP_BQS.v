module TOP_BQS #(
    parameter N = 3
)(
    input CLK,RST,
    input Enter_Cell,Leave_Cell,
    input T1,T2,T3,
    output [N-1:0] Pcount,
    output [1:0] Tcount,
    output [6:0] Wtime,
    output [6:0] Pcount_SS,Tcount_SS,Wtime_tens_SS,Wtime_unit_SS,
    output FULL_QUEUE,EMPTY_QUEUE,FULL_ALARM,EMPTY_ALARM
);
    wire Enter,Leave;
    wire up_wire,down_wire,enable;
    wire [3:0] Wtime_tens,Wtime_unit;


    Edge_Detector BackSensor (.clk_ED(CLK),.rst_ED(RST),.sig(Enter_Cell),.pulse(Enter));
    Edge_Detector FrontSensor (.clk_ED(CLK),.rst_ED(RST),.sig(Leave_Cell),.pulse(Leave));

    Controller HEAD (
        .clk(CLK),.rst(RST),.leave(Leave),
        .enter(Enter),.t1(T1),.t2(T2),.t3(T3),
        .Pcount_C(Pcount),.Tcount_C(Tcount),
        .UP_C(up_wire),.DOWN_C(down_wire),.EN(enable),
        .Empty_Flag(EMPTY_QUEUE),.Full_Flag(FULL_QUEUE),
        .Empty_alert(EMPTY_ALARM),.Full_alert(FULL_ALARM)
    );

    UP_DOWN_Counter Counter (
        .clk_c(CLK),.rst_c(RST),
        .UP(up_wire),.DOWN(down_wire),
        .enable_c(enable),.count(Pcount)
    );

    SS_Decoder #(.N(N)) PcountDisplay (.A(Pcount),.OUT(Pcount_SS));
    SS_Decoder #(.N(2)) TcountDisplay (.A(Tcount),.OUT(Tcount_SS));

    ROM MEM (.Addr({Pcount,Tcount}),.clk_R(CLK),.rst_R(RST),.Wtime_R(Wtime));

    assign Wtime_tens = Wtime / 10;
    assign Wtime_unit = Wtime % 10;

    SS_Decoder WtimeTensDisplay (.A(Wtime_tens),.OUT(Wtime_tens_SS));
    SS_Decoder WtimeUnitsDisplay (.A(Wtime_unit),.OUT(Wtime_unit_SS));
    

endmodule 