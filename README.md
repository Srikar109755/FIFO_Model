# 🚀 FIFO Model in Verilog

This repository contains a complete Verilog implementation of a **FIFO (First-In-First-Out) Model** with full functional verification through simulation. The design includes multiple status flags — Full, Empty, First, Last, and Second-Last — providing robust monitoring of FIFO state. This design is applicable to digital system buffering, communication interfaces, pipelined data flow, and ASIC/FPGA design pipelines.

---

## 📑 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Features](#features)
- [Modules](#modules)
- [Testbench Description](#testbench-description)
- [Simulation](#simulation)

---

## Overview

This project implements a synchronous FIFO design with:

- Parameterized width and depth
- Separate memory block module for data storage
- Comprehensive testbench covering full functionality
- Multiple status flags indicating real-time FIFO conditions

---

## 📁 Project Structure


---

## Features

- **Parameterization:** Configurable FIFO width and depth via Verilog macros
- **Synchronous Design:** Fully synchronous write and read operations
- **Dedicated Memory Block:** Clean architecture separation for data storage
- **Multiple Status Flags:**
  - `F_FullN`  : FIFO Full Indicator
  - `F_EmptyN` : FIFO Empty Indicator
  - `F_FirstN` : Single element remaining
  - `F_LastN`  : One space remaining for new data
  - `F_SLastN` : Two spaces remaining
- **Comprehensive Testbench:** Covers:
  - Write and Read operations
  - Overflow and Underflow handling
  - Status flag validations under various conditions

---

## Modules

### FIFO_Model.v

The main controller module responsible for:

- Managing write and read pointers
- Tracking FIFO element count
- Generating real-time status flags based on FIFO occupancy

### FIFO_MEM_BLK.v

Dedicated memory block module:

- Implements FIFO storage using synchronous memory array
- Controlled write operations triggered on clock edge
- Asynchronous data read

### FIFO_Model_tb.v

Complete testbench for functional verification:

- Clock generation
- Reset sequencing
- Stimulus for write and read operations
- Test cases covering:
  - Normal operations
  - Overflow attempts
  - Underflow attempts
  - Flag condition validations

---

## Testbench Description

The testbench rigorously verifies the FIFO behavior:

- Applies initial reset and clear signals
- Performs continuous write operations to fill FIFO
- Validates FIFO full condition
- Tests writing into a full FIFO (overflow prevention)
- Reads back data until FIFO empty
- Validates FIFO empty condition
- Tests reading from an empty FIFO (underflow prevention)
- Verifies individual status flags:
  - `F_FirstN` (only one element left)
  - `F_SLastN` (two spaces left)
  - `F_LastN` (one space left)
- `$display` statements are used throughout for clear simulation tracking

---

## Simulation

You can simulate this design using any Verilog-compatible simulation tool:

- **ModelSim**
- **VCS**
- **Vivado XSIM**
- **Verilator (open-source)**

### Example Simulation Commands:

```bash
# Compile all Verilog files
vlog FIFO_MEM_BLK.v FIFO_Model.v FIFO_Model_tb.v

# Run simulation
vsim FIFO_Model_tb
