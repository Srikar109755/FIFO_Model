# 🚀 FIFO Model in Verilog

This repository contains the complete Verilog code and testbench for a **FIFO (First-In-First-Out) Model** with multiple status flags including Full, Empty, First, Last, and Second-Last indications. This design is useful for digital system buffering, communication interfaces, and pipelined data processing.

---

## 📑 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Features](#features)
- [Modules](#modules)
- [Testbench Description](#testbench-description)
- [Simulation](#simulation)
- [How to Run](#how-to-run)
- [License](#license)

---

## 📖 Overview

This project implements a synchronous FIFO model with:

- Parametrized width and depth
- Separate memory block module
- Comprehensive testbench covering various FIFO operations
- Multiple status flags indicating FIFO conditions

---

## 📁 Project Structure


---

## ✨ Features

- Configurable FIFO Width and Depth using Verilog `define`
- Fully synchronous design
- Separate memory block design for cleaner architecture
- Multiple status flags:
  - `F_FullN`  : FIFO Full
  - `F_EmptyN` : FIFO Empty
  - `F_FirstN` : Only one element present
  - `F_LastN`  : One empty space left
  - `F_SLastN` : Two empty spaces left
- Testbench simulates:
  - Write operations
  - Read operations
  - Overflow and underflow handling
  - Status flag verification

---

## 🧩 Modules

### 1️⃣ FIFO_Model.v

Main FIFO controller module:
- Handles write/read operations
- Manages pointers and counters
- Generates status flags

### 2️⃣ FIFO_MEM_BLK.v

Dedicated FIFO memory block module:
- Implements FIFO storage using synchronous memory
- Simple interface for data read/write

### 3️⃣ FIFO_Model_tb.v

Testbench module:
- Generates clock, reset, and stimulus
- Tests all FIFO scenarios
- Monitors FIFO status flags using display statements

---

## 🧪 Testbench Description

The testbench validates the FIFO for:

- Normal write and read operations
- FIFO Full and Empty conditions
- Write attempt when full
- Read attempt when empty
- Status flags (`F_FullN`, `F_EmptyN`, `F_FirstN`, `F_LastN`, `F_SLastN`)

Key events are displayed using `$display` statements for simulation tracking.

---

## ▶️ Simulation

You can simulate using any Verilog simulator:

- ModelSim
- VCS
- XSIM (Vivado)
- Verilator (Open-source)

**Example simulation commands:**

```bash
# Compile
vlog FIFO_MEM_BLK.v FIFO_Model.v FIFO_Model_tb.v

# Simulate
vsim FIFO_Model_tb

# Observe display output and view waveforms

