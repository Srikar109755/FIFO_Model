# 🚀 FIFO Model in Verilog

This repository contains a complete Verilog implementation of a **synthesizable FIFO (First-In-First-Out) Model**, with robust functionality and verification. It supports parameterized depth and width, and includes useful status flags to monitor FIFO state.

---

## 📁 Table of Contents

* [Overview](#overview)
* [Block Diagram](#-block-diagram)
* [I/O Port Descriptions](#-io-port-descriptions)
* [Features](#-features)
* [Modules](#-modules)
* [Testbench Description](#-testbench-description)
* [Simulation](#-simulation)

---

## Overview

This project implements a synchronous FIFO design with:

* Parameterized width and depth
* Separate memory block module for data storage
* Comprehensive testbench covering full functionality
* Multiple status flags indicating real-time FIFO conditions

---

## 📊 Block Diagram

![FIFO Block Diagram](https://raw.githubusercontent.com/Srikar109755/FIFO_Model/main/FIFO/images/FIFO_Block_Diagram.png)

---

## 🔌 I/O Port Descriptions

All signals ending in `N` are **active low**.

### 🔀 Input Ports:

| Port Name | Description               |
| --------- | ------------------------- |
| `Clk`     | Clock signal              |
| `RstN`    | Reset signal              |
| `Data_In` | 32-bit input data to FIFO |
| `FInN`    | Write-enable signal       |
| `FClrN`   | Clear FIFO                |
| `FOutN`   | Read-enable signal        |

### 🛄 Output Ports:

| Port Name  | Description                         |
| ---------- | ----------------------------------- |
| `F_Data`   | 32-bit output data from FIFO        |
| `F_FullN`  | FIFO is full                        |
| `F_EmptyN` | FIFO is empty                       |
| `F_LastN`  | Space left for one more data value  |
| `F_SLastN` | Space left for two more data values |
| `F_FirstN` | Only one data value remains in FIFO |

---

## ✅ Features

* **Parameterization:** Configurable FIFO width and depth via macros (`FWIDTH`, `FDEPTH`)
* **Synchronous Design:** Write and read are synchronized to the clock
* **Modular Architecture:** Dedicated memory module for data storage
* **Status Flags:**

  * `F_EmptyN`: FIFO is empty
  * `F_FullN`: FIFO is full
  * `F_FirstN`: One element left
  * `F_LastN`: One space left
  * `F_SLastN`: Two spaces left
* **Robust Testbench:** Covers all operational and boundary conditions

---

## 📁 Modules

### 1. `FIFO_Model.v`

* Controls FIFO behavior
* Manages read/write pointers and counter
* Generates status signals

### 2. `FIFO_MEM_BLK.v`

* Implements synchronous memory storage
* Controlled writes and asynchronous reads

### 3. `FIFO_Model_tb.v`

* Testbench for simulation
* Generates stimuli, monitors flags and verifies data flow

---

## 🧪 Testbench Description

The testbench validates FIFO operation through various tests:

* Clock generation and reset sequencing
* Continuous writes to fill the FIFO
* Check for full and overflow conditions
* Reads to empty the FIFO
* Check for empty and underflow conditions
* Status flag checks:

  * When FIFO has only one element (`F_FirstN`)
  * When two slots remain (`F_SLastN`)
  * When one slot remains (`F_LastN`)

Verbose simulation output is generated via `$display`.

---

## ▶️ Simulation

You can simulate the design with any Verilog simulator such as:

* **ModelSim**
* **Vivado XSIM**
* **Verilator**
* **VCS**

### Example Commands (ModelSim):

```bash
# Compile all source files
vlog FIFO_MEM_BLK.v FIFO_Model.v FIFO_Model_tb.v

# Simulate
vsim FIFO_Model_tb
