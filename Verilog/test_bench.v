`timescale 1ns/1ps
module tb_disaster_all;
    reg  r1, r0, s1, s0, w1, w0, l1, l0, mode;
    wire flood_led_g, cyclone_led_g, earthquake_led_g, tsunami_led_g;
    wire flood_led_d, cyclone_led_d, earthquake_led_d, tsunami_led_d;
    wire flood_led_b, cyclone_led_b, earthquake_led_b, tsunami_led_b;
    disaster_gate       U_GATE (.r1(r1), .r0(r0), .s1(s1), .s0(s0), .w1(w1), .w0(w0), .l1(l1), .l0(l0), .mode(mode),
                                .flood_led(flood_led_g), .cyclone_led(cyclone_led_g), .earthquake_led(earthquake_led_g), .tsunami_led(tsunami_led_g));
    disaster_dataflow   U_DATA (.r1(r1), .r0(r0), .s1(s1), .s0(s0), .w1(w1), .w0(w0), .l1(l1), .l0(l0), .mode(mode),
                                .flood_led(flood_led_d), .cyclone_led(cyclone_led_d), .earthquake_led(earthquake_led_d), .tsunami_led(tsunami_led_d));
    disaster_behavioral U_BEH  (.r1(r1), .r0(r0), .s1(s1), .s0(s0), .w1(w1), .w0(w0), .l1(l1), .l0(l0), .mode(mode),
                                .flood_led(flood_led_b), .cyclone_led(cyclone_led_b), .earthquake_led(earthquake_led_b), .tsunami_led(tsunami_led_b));
    initial begin
        $dumpfile("disaster_all.vcd");
        $dumpvars(0, tb_disaster_all);
    end
    integer i;
    initial begin
        for (mode = 0; mode <= 1; mode = mode + 1) begin
            for (i = 0; i < 256; i = i + 1) begin
                {r1,r0,s1,s0,w1,w0,l1,l0} = i;
                #1;
            end
        end
        #5 $finish;
    end
endmodule
