// ===========================================================
// Behavioral Model of Disaster Warning Device
// ===========================================================
module disaster_behavioral(
    input r1, r0, s1, s0, w1, w0, l1, l0, mode,
    output reg flood_led, cyclone_led, earthquake_led, tsunami_led
);
    reg flood, cyclone, earthquake, tsunami;
    reg [1:0] code;
    reg Df, Dc, De, Dt;

    always @(*) begin
        // --- Disaster detection ---
        flood      = r1 & (w1 | l1 | r0);
        cyclone    = w1 & (w0 | l1 | r1);
        earthquake = s1;
        tsunami    = s1 & l1;

        // --- Priority encoder ---
        if (flood)       code = 2'b00;
        else if (cyclone) code = 2'b01;
        else if (earthquake) code = 2'b10;
        else if (tsunami) code = 2'b11;
        else code = 2'b00;

        // --- Decoder ---
        case (code)
            2'b00: {Df,Dc,De,Dt} = 4'b1000;
            2'b01: {Df,Dc,De,Dt} = 4'b0100;
            2'b10: {Df,Dc,De,Dt} = 4'b0010;
            2'b11: {Df,Dc,De,Dt} = 4'b0001;
            default: {Df,Dc,De,Dt} = 4'b0000;
        endcase

        // --- Mode Logic ---
        flood_led      = (~mode & Df) | (mode & flood);
        cyclone_led    = (~mode & Dc) | (mode & cyclone);
        earthquake_led = (~mode & De) | (mode & earthquake);
        tsunami_led    = (~mode & Dt) | (mode & tsunami);
    end
endmodule
