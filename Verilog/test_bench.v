// ===========================================================
// Testbench for Disaster Warning Device
// ===========================================================
`timescale 1ns/1ps
module tb_disaster;
    reg r1, r0, s1, s0, w1, w0, l1, l0, mode;
    wire flood_led, cyclone_led, earthquake_led, tsunami_led;

    // Change this line to test any version:
    disaster_behavioral uut (
        .r1(r1), .r0(r0), .s1(s1), .s0(s0),
        .w1(w1), .w0(w0), .l1(l1), .l0(l0),
        .mode(mode),
        .flood_led(flood_led),
        .cyclone_led(cyclone_led),
        .earthquake_led(earthquake_led),
        .tsunami_led(tsunami_led)
    );

    initial begin
        $dumpfile("disaster.vcd");
        $dumpvars(0, tb_disaster);

        // Header
        $display("time\tmode\tr1r0 w1w0 s1s0 l1l0 | F C E T");

        // Initialize all inputs
        mode = 0;
        {r1,r0,s1,s0,w1,w0,l1,l0} = 8'b00000000;

        // Test unique disaster mode (mode=0)
        repeat(8) begin
            {r1,r0,s1,s0,w1,w0,l1,l0} = $random;
            #5;
            $display("%0t\t%b\t%b%b %b%b %b%b %b%b | %b %b %b %b",
                $time, mode, r1,r0, w1,w0, s1,s0, l1,l0,
                flood_led, cyclone_led, earthquake_led, tsunami_led);
        end

        // Test multi-disaster mode (mode=1)
        mode = 1;
        repeat(8) begin
            {r1,r0,s1,s0,w1,w0,l1,l0} = $random;
            #5;
            $display("%0t\t%b\t%b%b %b%b %b%b %b%b | %b %b %b %b",
                $time, mode, r1,r0, w1,w0, s1,s0, l1,l0,
                flood_led, cyclone_led, earthquake_led, tsunami_led);
        end

        #10 $finish;
    end
endmodule
