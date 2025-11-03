module disaster_gate(
    input  r1, r0, s1, s0, w1, w0, l1, l0, mode,
    output flood_led, cyclone_led, earthquake_led, tsunami_led
);
    wire flood, cyclone, earthquake, tsunami;
    or  or_f1 (earthquake, s1, s0);
    and and_t1 (tsunami, s1, l1);
    or  or_f2 (flood_or_branch, w1, l1, r0);
    and and_f1 (flood, r1, flood_or_branch);
    or  or_c1 (cyclone_or_branch, w0, l1, r1);
    and and_c1 (cyclone, w1, cyclone_or_branch);

    wire nF, nC;
    not notF(nF, flood);
    not notC(nC, cyclone);
    wire e_or_t;
    or  or_et(e_or_t, earthquake, tsunami);
    and and_code1(code1, nF, nC, e_or_t);
    wire nF_nC_and_T;
    and and_tmp(nF_nC_and_T, nF, nC, tsunami);
    or  or_code0(code0, cyclone, nF_nC_and_T);

    wire Df, Dc, De, Dt;
    wire ncode1, ncode0;
    not (ncode1, code1);
    not (ncode0, code0);
    and (Df, ncode1, ncode0);
    and (Dc, ncode1, code0);
    and (De, code1, ncode0);
    and (Dt, code1, code0);

    wire nm;
    not (nm, mode);
    wire uf, uc, ue, ut;
    and (uf, nm, Df);
    and (uc, nm, Dc);
    and (ue, nm, De);
    and (ut, nm, Dt);
    wire mf, mc, me, mt;
    and (mf, mode, flood);
    and (mc, mode, cyclone);
    and (me, mode, earthquake);
    and (mt, mode, tsunami);
    or  (flood_led, uf, mf);
    or  (cyclone_led, uc, mc);
    or  (earthquake_led, ue, me);
    or  (tsunami_led, ut, mt);
endmodule
