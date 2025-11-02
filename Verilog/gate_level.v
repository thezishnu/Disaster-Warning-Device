// ===========================================================
// Gate-Level Model of Disaster Warning Device
// ===========================================================
module disaster_gate(
    input r1, r0, s1, s0, w1, w0, l1, l0, mode,
    output flood_led, cyclone_led, earthquake_led, tsunami_led
);

    // --- Individual disaster detection (gate level) ---
    wire flood, cyclone, earthquake, tsunami;
    wire or_flood1, or_cyc1, and_cyc1;

    // FLOOD = r1 * (w1 + l1 + r0)
    or  (or_flood1, w1, l1, r0);
    and (flood, r1, or_flood1);

    // CYCLONE = w1 * (w0 + l1 + r1)
    or  (or_cyc1, w0, l1, r1);
    and (cyclone, w1, or_cyc1);

    // EARTHQUAKE = s1
    assign earthquake = s1;

    // TSUNAMI = s1 * l1
    and (tsunami, s1, l1);

    // --- Priority encoder (Flood > Cyclone > Earthquake > Tsunami) ---
    reg [1:0] code;
    always @(*) begin
        if (flood)       code = 2'b00;
        else if (cyclone) code = 2'b01;
        else if (earthquake) code = 2'b10;
        else if (tsunami) code = 2'b11;
        else code = 2'b00;
    end

    // --- Decoder for one-hot outputs ---
    reg Df, Dc, De, Dt;
    always @(*) begin
        case(code)
            2'b00: {Df,Dc,De,Dt} = 4'b1000;
            2'b01: {Df,Dc,De,Dt} = 4'b0100;
            2'b10: {Df,Dc,De,Dt} = 4'b0010;
            2'b11: {Df,Dc,De,Dt} = 4'b0001;
            default: {Df,Dc,De,Dt} = 4'b0000;
        endcase
    end

    // --- Mode logic ---
    // mode=0 → unique (decoder)
    // mode=1 → multi (direct disaster signals)
    wire nf;
    not (nf, mode);

    wire mf, mc, me, mt, uf, uc, ue, ut;
    and (uf, nf, Df);
    and (uc, nf, Dc);
    and (ue, nf, De);
    and (ut, nf, Dt);

    and (mf, mode, flood);
    and (mc, mode, cyclone);
    and (me, mode, earthquake);
    and (mt, mode, tsunami);

    or  (flood_led, uf, mf);
    or  (cyclone_led, uc, mc);
    or  (earthquake_led, ue, me);
    or  (tsunami_led, ut, mt);

endmodule
