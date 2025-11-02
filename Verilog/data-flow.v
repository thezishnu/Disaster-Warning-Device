// ===========================================================
// Dataflow Model of Disaster Warning Device
// ===========================================================
module disaster_dataflow(
    input r1, r0, s1, s0, w1, w0, l1, l0, mode,
    output flood_led, cyclone_led, earthquake_led, tsunami_led
);

    // Disaster equations
    wire flood     = r1 & (w1 | l1 | r0);
    wire cyclone   = w1 & (w0 | l1 | r1);
    wire earthquake= s1;
    wire tsunami   = s1 & l1;

    // Priority encoder
    wire [1:0] code =
        (flood) ? 2'b00 :
        (cyclone) ? 2'b01 :
        (earthquake) ? 2'b10 :
        (tsunami) ? 2'b11 : 2'b00;

    // Decoder
    wire Df = (code == 2'b00);
    wire Dc = (code == 2'b01);
    wire De = (code == 2'b10);
    wire Dt = (code == 2'b11);

    // Mode logic
    assign flood_led      = (~mode & Df) | (mode & flood);
    assign cyclone_led    = (~mode & Dc) | (mode & cyclone);
    assign earthquake_led = (~mode & De) | (mode & earthquake);
    assign tsunami_led    = (~mode & Dt) | (mode & tsunami);

endmodule
