module Verification_tb ();

    reg CLK_tb,RST_tb;
    reg Enter_Cell_tb,Leave_Cell_tb;
    reg T1_tb,T2_tb,T3_tb;
    wire [2:0] Pcount_tb;
    wire [1:0] Tcount_tb;
    wire [6:0] Wtime_tb;
    wire [6:0] Pcount_SS_tb,Tcount_SS_tb,Wtime_tens_SS_tb,Wtime_unit_SS_tb;
    wire FULL_QUEUE_tb,EMPTY_QUEUE_tb,FULL_ALARM_tb,EMPTY_ALARM_tb;

    // //Expected
    // reg [N-1:0] Pcount_exp;
    // reg [1:0] Tcount_exp;
    // reg [6:0] Wtime_exp;
    // reg [6:0] Pcount_SS_exp,Tcount_SS_exp,Wtime_tens_SS_exp,Wtime_unit_SS_exp;
    // reg FULL_QUEUE_exp,EMPTY_QUEUE_exp,FULL_ALARM_exp,EMPTY_ALARM_exp;


    TOP_BQS DUT (
            .CLK(CLK_tb),.RST(RST_tb),
            .Enter_Cell(Enter_Cell_tb),.Leave_Cell(Leave_Cell_tb),
            .T1(T1_tb),.T2(T2_tb),.T3(T3_tb),
            .Pcount(Pcount_tb),.Tcount(Tcount_tb),.Wtime(Wtime_tb),
            .Pcount_SS(Pcount_SS_tb),.Tcount_SS(Tcount_SS_tb),
            .Wtime_tens_SS(Wtime_tens_SS_tb),.Wtime_unit_SS(Wtime_unit_SS_tb),
            .FULL_QUEUE(FULL_QUEUE_tb),.EMPTY_QUEUE(EMPTY_QUEUE_tb),
            .FULL_ALARM(FULL_ALARM_tb),.EMPTY_ALARM(EMPTY_ALARM_tb)
            );

    wire UP = DUT.up_wire;
    wire DOWN = DUT.down_wire;
    wire [1:0] cs = DUT.HEAD.cs;
    wire [1:0] ns = DUT.HEAD.ns;
 

    initial begin
        CLK_tb = 0;
        forever begin
           #3 CLK_tb = ~CLK_tb;
        end
    end    

    initial begin
    ////////////////Check Reset
        RST_tb = 1;
        Enter_Cell_tb = 1;
        Leave_Cell_tb = 0;
        T1_tb = 0;
        T2_tb = 0;
        T3_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        Leave_Cell_tb = 0;
        T1_tb = 1;
        T2_tb = 0;
        T3_tb = 1;
        @(negedge CLK_tb);

    ////////////////Ch
        RST_tb = 0;
        Enter_Cell_tb = 1;  //Pcount = 1
        Leave_Cell_tb = 0;
        T1_tb = 1;
        T2_tb = 1;
        T3_tb = 1;

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;
        Leave_Cell_tb = 1;  //Pcount = 1

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        Leave_Cell_tb = 0;

        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //Pcount = 0 "EMPTY"

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;

        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //EMPTY_ALARM

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        Enter_Cell_tb = 1;  //Pcount = 1

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;  //Pcount = 2

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;  //Pcount = 3

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        Leave_Cell_tb = 1;  //Pcount = 2

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        Enter_Cell_tb = 1;  //Pcount = 3

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;  
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;  //Pcount = 4

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;  //Pcount = 5

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;  //Pcount = 6

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;  //Pcount = 7 "FULL"

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        @(negedge CLK_tb);
        Enter_Cell_tb = 1;  //FULL_ALARM

        @(negedge CLK_tb);
        Enter_Cell_tb = 0;
        Leave_Cell_tb = 1;  //Pcount = 6

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //Pcount = 5

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //Pcount = 4

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //Pcount = 3

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //Pcount = 2

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //Pcount = 1

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //Pcount = 0 "EMPTY"

        @(negedge CLK_tb);
        Leave_Cell_tb = 0;
        @(negedge CLK_tb);
        Leave_Cell_tb = 1;  //EMPTY ALARM

        $stop;
    end

    initial begin
        $monitor(
            "Pcount_tb = %b , Tcount_tb = %b  , Wtime_tb = %b ,Pcount_SS_tb = %b ,Tcount_SS_tb = %b ,Wtime_tens_SS_tb = %b ,Wtime_unit_SS_tb = %b ,FULL_QUEUE_tb = %b ,EMPTY_QUEUE_tb = %b ,FULL_ALARM_tb = %b ,EMPTY_ALARM_tb = %b ", 
            Pcount_tb , Tcount_tb , Wtime_tb,Pcount_SS_tb,Tcount_SS_tb,Wtime_tens_SS_tb,Wtime_unit_SS_tb,FULL_QUEUE_tb,EMPTY_QUEUE_tb,FULL_ALARM_tb,EMPTY_ALARM_tb);
    end
endmodule