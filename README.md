# Disaster Warning Device

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Team ID: 19

  > Member-1: Poluri Sai Jishnu, 241CS140, saijishnup.241cs140@nitk.edu.in

  > member-2: Utkoor Venkatesh, 241CS161, utkoorvenkatesh.241cs161@nitk.edu.in

  > Member-3: Vikash Patel, 241CS163,  vikashpatel.241cs163@nitk.edu.in
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
  
  >
 **Core Background:**<br>
 • Natural disasters like floods, cyclones, earthquakes, and tsunamis cause major damage.<br>
 • Early warning helps to reduce loss of life and property.<br>
• This project uses digital logic to detect possible disasters automatically.<br>
• It works on simple sensor-like binary inputs representing environment factors.<br>
 **Project Working:**<br>
• The system takes 8-bit input (2 bits each for Rainfall, Seismic, Wind, and Sea Level).<br>
• Each 2-bit code shows the level: Low, Medium, High, or Very High.<br>
• Comparators, AND/OR/XOR gates, and decoders process these inputs.<br>
• Logic equations decide which disaster condition matches the given inputs.<br>
• A priority encoder and multiplexer ensure only one LED glows at a time.<br>
• The output is a glowing LED showing one disaster: Flood, Cyclone, Earthquake, or Tsunami.<br>
 **Applications & Educational Value:**<br>
• The LEDs act as warning indicators for different conditions.<br>
• The design is simple, low-cost, and based on basic logic ICs.<br>
• It can be used in educational labs to learn digital system design concepts.<br>
• The project demonstrates practical use of comparators, encoders, and multiplexers in safety systems.<br>
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary>
  
  ![block diagram]([https://github.com/user-attachments/assets/588c9f81-997e-431b-8da3-0b40f3713d4e](https://github.com/thezishnu/S1-T19-25-26/blob/main/Snapshots/block_diagram.png?raw=true))

</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

The **Disaster Warning Device** is a combinational and sequential circuit–based system designed to detect and indicate natural disasters such as **Flood, Cyclone, Earthquake,** and **Tsunami** based on real-time environmental inputs. The system accepts **four 2-bit inputs** representing sensor readings: rainfall (`r1r0`), seismic activity (`s1s0`), wind speed (`w1w0`), and sea level (`l1l0`). Each disaster has a unique Boolean condition that determines its occurrence:

- **Flood** = `r1 & (w1 | l1 | r0)`  
- **Cyclone** = `w1 & (w0 | l1 | r1)`  
- **Earthquake** = `s1`  
- **Tsunami** = `s1 & l1`  

Each condition is implemented using AND and OR gates in dedicated subcircuits, producing four initial disaster signals. These outputs are then passed to a **priority encoder** that generates a 2-bit binary code corresponding to the highest-priority disaster. The encoder output is fed to a **2-to-4 decoder**, which converts the code into a one-hot output for LED indication.

A **mode control input** (`mode`) determines the display behavior:
- When `mode = 0`, only the **highest-priority** disaster is displayed (unique mode).  
- When `mode = 1`, **all active** disasters are shown simultaneously (multi-disaster mode).

Finally, the LED logic combines decoder outputs and raw detection signals to drive four LEDs: `flood_led`, `cyclone_led`, `earthquake_led`, and `tsunami_led`. Thus, the device effectively interprets sensor data, prioritizes disasters, and visually alerts the user in real-time, aiding in early warning and decision-making.

</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  > Update a neat logisim circuit diagram
</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

```verilog
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

## References
<details>
  <summary>Detail</summary>
  
> BBC News. *India train crash: At least 275 dead in Odisha, 2023*. Accessed: 2024-09-30.  
   [(https://www.bbc.com/news)](https://www.bbc.com/news/world-asia-india-65793257)
   
</details>


