# ALU8 ASIC Design using OpenLane and SKY130A

## Introduction

Application Specific Integrated Circuits (ASICs) are custom integrated circuits designed for a specific functionality or application. Modern ASIC design involves multiple stages beginning from Register Transfer Level (RTL) coding and ending at fabrication-ready GDSII layout generation.

This project presents the complete RTL-to-GDSII implementation of an 8-bit Arithmetic Logic Unit (ALU) using Verilog HDL, OpenLane ASIC flow, and the SKY130A Process Design Kit (PDK).

The design was synthesized, floorplanned, placed, routed, verified, and exported successfully to final GDSII layout without critical violations.

---

# Project Objective

The objective of this project is to implement a fully synthesizable 8-bit ALU and successfully complete the entire ASIC physical design flow using OpenLane and SKY130A technology.

The project demonstrates:

- RTL Design using Verilog HDL
- Logic Synthesis
- Floorplanning
- Placement
- Clock Tree Synthesis
- Routing
- Static Timing Analysis
- DRC/LVS Verification
- GDSII Generation

---

# ALU Functional Description

The ALU performs arithmetic, logical, and comparison operations selected through a 3-bit opcode.

## Input Signals

| Signal | Width | Description |
|--------|-------|-------------|
| A | 8-bit | Operand A |
| B | 8-bit | Operand B |
| opcode | 3-bit | Operation Select |

## Output Signals

| Signal | Width | Description |
|--------|-------|-------------|
| result | 8-bit | Operation Result |
| carry | 1-bit | Carry/Borrow Output |
| zero | 1-bit | Zero Flag |

---

# Operations Supported

| Opcode | Operation | Description |
|--------|------------|-------------|
| 000 | Addition | A + B |
| 001 | Subtraction | A - B |
| 010 | AND | A & B |
| 011 | OR | A \| B |
| 100 | XOR | A ^ B |
| 101 | NOT | ~A |
| 110 | Greater Than | A > B |
| 111 | Equality | A == B |

---

# RTL Design

The ALU was implemented using combinational Verilog logic with an `always @(*)` block and a case statement for opcode selection.

The design contains:

- No sequential logic
- No flip-flops
- No latches
- Pure combinational architecture

Carry output is initialized during every evaluation cycle to avoid latch inference.

Comparator operations return logic `1` when the condition is true and logic `0` otherwise.

---

# Testbench

The functionality of the ALU was verified using a Verilog testbench.

Different opcodes were applied sequentially to verify arithmetic, logical, and comparison operations.

---

# Timing Constraints

Static timing constraints were defined using Synopsys Design Constraints (SDC) format.

## constraints.sdc

```tcl
create_clock -name clk -period 10 [get_ports clk]

set_clock_transition 0.1 [get_clocks clk]

set_clock_uncertainty 0.01 [get_clocks clk]

set_input_delay 1.0 -clock clk [get_ports A]
set_input_delay 1.0 -clock clk [get_ports B]
set_input_delay 1.0 -clock clk [get_ports opcode]

set_output_delay 1.0 -clock clk [get_ports result]
set_output_delay 1.0 -clock clk [get_ports carry]
set_output_delay 1.0 -clock clk [get_ports zero]
```

---

# OpenLane ASIC Flow

The design was implemented using OpenLane, an open-source RTL-to-GDSII automated ASIC flow based on OpenROAD and SKY130A PDK.

The following ASIC design stages were completed successfully.

---

# 1. Synthesis

Logic synthesis converts RTL code into a gate-level netlist using standard cells from the SKY130 HD library.

Yosys synthesis tool was used during this stage.

## Synthesis Results

| Metric | Value |
|--------|-------|
| Synthesis Status | PASSED |
| Cell Area | 1977.78 |
| Sequential Elements | 0 |
| Core Utilization | ~9% |

## Linting Results

| Metric | Result |
|--------|--------|
| Errors | 0 |
| Warnings | 0 |
| Status | PASSED |

---

# 2. Floorplanning

Floorplanning defines:

- Die dimensions
- IO placement
- Power Distribution Network
- Core dimensions

Tap cells and decap cells were inserted successfully.

## Floorplan Metrics

| Parameter | Value |
|-----------|------|
| Width | 288.88 µm |
| Height | 277.44 µm |
| Die Area | ~0.080 mm² |
| Power Nets | VPWR / VGND |

---

# 3. Placement

Placement determines optimized locations for standard cells to minimize routing congestion and timing delay.

## Placement Stages

| Stage | Status |
|-------|-------|
| Global Placement | PASSED |
| Post-GPL STA | PASSED |
| Resizer Optimization | PASSED |
| Detailed Placement | PASSED |
| Post-DPL STA | PASSED |

---

# 4. Clock Tree Synthesis (CTS)

Since the ALU is purely combinational and contains no sequential elements, no physical clock tree was inserted.

However, CTS stage completed successfully as part of the automated flow.

---

# 5. Routing

Routing creates physical metal interconnections between all standard cells.

Global routing and detailed routing were completed successfully.

## Routing Results

| Metric | Value |
|--------|------|
| DRC Violations | 0 |
| Via Count | ~247 |
| Routing Layers | Metal1 to Metal6 |
| Antenna Violations | Repaired |

---

# 6. Static Timing Analysis (STA)

Static Timing Analysis verifies timing correctness of the design without functional simulation.

## Timing Results

| Check | Result |
|-------|-------|
| Setup Violations | 0 |
| Hold Violations | 0 |
| Max Slew Violations | 0 |
| Max Fanout Violations | 0 |
| Max Capacitance Violations | 0 |

---

# 7. Power Analysis

Power analysis was performed during signoff stage.

## Power Results

| Metric | Value |
|--------|------|
| Internal Power | 3.0 µW |
| Switching Power | 10.0 µW |
| IR Drop Status | PASSED |

---

# 8. Physical Verification

Physical verification ensures manufacturability and logical correctness of layout.

## Verification Results

| Verification | Status |
|-------------|-------|
| DRC | PASSED |
| LVS | PASSED |
| ERC | PASSED |
| Antenna Check | PASSED |

---

# Final Outputs

The following fabrication-ready files were generated successfully.

| File | Description |
|------|-------------|
| alu8.gds | Final GDSII Layout |
| alu8.def | Design Exchange Format |
| alu8.lef | Abstract LEF |
| alu8.spice | Extracted SPICE Netlist |
| alu8.v | Powered Verilog Netlist |
| metrics.csv | Design Metrics |

---

# GDSII Layout

The final GDSII layout was generated successfully without DRC or LVS violations.

---

# Simulation

Simulation can be executed using Icarus Verilog.

```bash
iverilog -o alu8_out alu8.v alu8_tb.v
vvp alu8_out
gtkwave alu8.vcd
```

---

# OpenLane Execution

Run OpenLane flow using:

```bash
flow.tcl -design alu8
```

---

# Result Summary

| Metric | Result |
|--------|--------|
| RTL Verification | PASSED |
| Synthesis | PASSED |
| Placement | PASSED |
| Routing | PASSED |
| STA | PASSED |
| DRC | PASSED |
| LVS | PASSED |
| Antenna Check | PASSED |

---

# Conclusion

The ALU8 ASIC design successfully completed the complete RTL-to-GDSII implementation flow using OpenLane and SKY130A PDK.

The design passed synthesis, floorplanning, placement, routing, timing analysis, DRC, LVS, ERC, and antenna verification without critical violations.

The final GDSII layout is fabrication-ready and demonstrates a complete ASIC implementation methodology from RTL design to physical layout generation.

