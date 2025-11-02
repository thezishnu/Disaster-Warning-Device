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
  
  ![block diagram]([https://github.com/user-attachments/assets/588c9f81-997e-431b-8da3-0b40f3713d4e](https://github.com/thezishnu/S1-T19-25-26/blob/main/Snapshots/block_diagram.png))

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

  > 
</details>

## References
<details>
  <summary>Detail</summary>
  
> BBC News. *India train crash: At least 275 dead in Odisha, 2023*. Accessed: 2024-09-30.  
   [(https://www.bbc.com/news)](https://www.bbc.com/news/world-asia-india-65793257)
   
</details>


